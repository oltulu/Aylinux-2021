#!/usr/bin/python3
# -*- coding: utf-8 -*-
import gi, os, sys, json, subprocess
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gio, GObject, GLib, GdkPixbuf

start_dir = "/usr/milis/ayguci/client"
base_dir = "/usr/milis/ayguci/gui"

class AyguciUI(Gtk.Window):
	def __init__(self,j_data):
		super(AyguciUI, self).__init__()
		self.satirlar = {}
		self.iconview = []
		self.radio_groups = {}
		self.main_box = Gtk.VBox()
		self.add(self.main_box)
		self.data = self.get_ui_json(j_data)
		self.parse_ui(self.data)
		self.set_icon(GdkPixbuf.Pixbuf.new_from_file(base_dir+"/icons/ayguci.svg"))
		self.show_all()

	def send_json(self,widget,info):
		t = info["text"].lower()
		if info["url"]:
			json = "{"
			for data in self.post_data:
				if data["info"]["tip"] == "entry":
					j = '"{}":"{}",'.format(data["info"]["post"],data["widget"].get_text())
					json += j
				elif data["info"]["tip"] == "radio":
					if data["widget"].get_active():
						j = '"{}":"{}",'.format(data["info"]["post"],data["info"]["text"])
						json += j
				elif data["info"]["tip"] == "check":
					if data["widget"].get_active():
						j = '"{}":true,'.format(data["info"]["post"])
					else:
						j = '"{}":false,'.format(data["info"]["post"])
						json += j
			json = json[:-1] + "}"
			update_window("{} {}".format(info["url"],json))
			print(json)
		elif t == "geri" or t == "back":
			update_window("module/list")
		elif t == "çıkış" or t == "exit":
			Gtk.main_quit()
		else:
			print("Böyle bir işlev yok")

	def widget_ready_post(self,info,widget,p):
		if info["post"]:
			p.append({"info":info,"widget":widget})
		else:
			return False

	def add_widget(self,box,widget):
		h_scale = False
		if widget["tip"] == "label":
			w = Gtk.Label()
			w.set_text(str(widget["text"]))
			box.pack_start(w, True, True, 5)
		if widget["tip"] == "textbox":
			w = Gtk.TextView()
			scroll = Gtk.ScrolledWindow()
			scroll.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
			scroll.add(w)
			b = w.get_buffer()
			b.set_text(str(widget["text"]))
			box.pack_start(scroll, True, True, 5)
			h_scale = True
			self.set_default_size(580,360)
		elif widget["tip"] == "entry":
			w = Gtk.Entry()
			w.set_text(str(widget["text"]))
			box.pack_start(w, True, True, 5)
		elif widget["tip"] == "radio":
			varmi = self.radio_groups.get(widget["post"],False)
			if varmi:
				w = Gtk.RadioButton.new_from_widget(varmi)
			else:
				w = Gtk.RadioButton()
				self.radio_groups[widget["post"]] = w
			w.set_label(str(widget["text"]))
			if widget["bool"] == "true":
				w.set_active(True)
			else:
				w.set_active(False)
			box.pack_start(w, True, True, 5)
		elif widget["tip"] == "check":
			w = Gtk.CheckButton()
			w.set_label(str(widget["text"]))
			if widget["bool"] == "true":
				w.set_active(True)
			else:
				w.set_active(False)
			box.pack_start(w, True, True, 5)
		elif widget["tip"] == "button":
			w = Gtk.Button()
			w.connect("clicked",self.send_json,widget)
			w.set_label(str(widget["text"]))
			box.pack_start(w, True, True, 5)
		self.widget_ready_post(widget,w,self.post_data)
		return h_scale

	def get_ui_json(self,data):
		parse = json.loads(data)
		if "ui" in parse.keys():
			return parse["ui"]
		else:
			return [{'type': 'form', 'left': 60, 'top': 20, 'val': 'ARAYUZ YOK'},{'type': 'label', 'left': 0, 'top': 0, 'val': 'ARAYÜZ HENÜZ YAZILMAMIŞ'}, {'type': 'button', 'left': 16, 'top': 16, 'val': 'Geri'}]

	def iconview_list(self,widget,path):
		global module
		model = widget.get_model()
		text = model[path][2]
		if self.iconview["post"] == "func":
			module += "/" + model[path][0]
			update_window(module)
		else:
			update_window(self.iconview["url"]+' {"'+self.iconview["post"]+'":'+text+'}')
			module += "/" + model[path][0]

	def parse_ui(self,data):
		print(data)
		for widget in data:
			if widget["type"] == "form":
				self.set_title(widget["val"])
			elif widget["type"] == "list":
				self.iconview = {"val":widget["val"],"post":self.is_here(widget,"post"),"url":self.is_here(widget,"url")}
			elif widget["type"] == "button":
				w = {"tip":"button","su":widget['left'],"sa":widget['top'],"text":widget["val"],"post":self.is_here(widget,"post"),"url":self.is_here(widget,"url")}
				self.add_satirlar(widget['top'],w)
			elif widget["type"] == "label":
				w = {"tip":"label","su":widget['left'],"sa":widget['top'],"text":widget["val"],"post":self.is_here(widget,"post")}
				self.add_satirlar(widget['top'],w)
			elif widget["type"] == "textbox":
				w = {"tip":"textbox","su":widget['left'],"sa":widget['top'],"text":widget["val"],"post":self.is_here(widget,"post")}
				self.add_satirlar(widget['top'],w)
			elif widget["type"] == "entry":
				w = {"tip":"entry","su":widget['left'],"sa":widget['top'],"text":widget["val"],"post":self.is_here(widget,"post")}
				self.add_satirlar(widget['top'],w)
			elif widget["type"] == "radio":
				w = {"tip":"radio","su":widget['left'],"sa":widget['top'],"text":widget["val"],"post":self.is_here(widget,"post"),"bool":widget["bool"]}
				self.add_satirlar(widget['top'],w)
			elif widget["type"] == "check":
				w = {"tip":"check","su":widget['left'],"sa":widget['top'],"text":widget["val"],"post":self.is_here(widget,"post"),"bool":widget["bool"]}
				self.add_satirlar(widget['top'],w)

		if len(self.iconview) != 0:
			s_box = Gtk.HBox()
			self.main_box.pack_start(s_box,True,True,5)
			store = Gtk.ListStore(str,GdkPixbuf.Pixbuf,str)
			view = Gtk.IconView(model=store)
			view.connect("item-activated",self.iconview_list)
			view.set_text_column(0)
			view.set_pixbuf_column(1)
			scroll = Gtk.ScrolledWindow()
			scroll.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
			scroll.add(view)
			s_box.pack_start(scroll,True,True,10)
			s = 1
			for item in self.iconview["val"]:
				icon_path = base_dir+"/icons/{}.svg".format(item)
				if not os.path.exists(icon_path):
					icon_path = base_dir+"/icons/ayguci.svg"
				p_b = GdkPixbuf.Pixbuf.new_from_file_at_size(icon_path,64,64)
				store.append([item,p_b,str(s)])
				s += 1
			self.set_default_size(580,360)

		self.post_data = []
		k = list(self.satirlar.keys())
		k.sort()
		for s in k:
			s_box = Gtk.HBox()
			print(self.satirlar[s])
			satir = self.satirlar[s]
			sutunlar = []
			for su in satir:
				sutunlar.append(su["su"])
			sutunlar.sort()
			h_scale = False
			for sutun in sutunlar:
				for su in satir:
					if su["su"]	== sutun:
						if self.add_widget(s_box,su):
							h_scale = True
						break
			self.main_box.pack_start(s_box,h_scale,True,5)
		print(self.post_data)

	def is_here(self,_dict,_key):
		here = _dict.get(_key,False)
		return here


	def add_satirlar(self,key,widget):
		varmi = self.satirlar.get(key,False)
		if varmi:
			varmi.append(widget)
		else:
			self.satirlar[key] = [widget]

def get_first_json(arg):
	global module
	if arg == "module/list":
		module = ""
	print("//////////",os.path.join(start_dir,"ayguci-client"),arg)
	get = subprocess.Popen([os.path.join(start_dir,"ayguci-client"),arg], stdout = subprocess.PIPE)
	get.wait()
	get = get.communicate()[0]
	get = get.decode("utf-8","strict")
	return get

def update_window(arg):
	global app
	app.destroy()
	g = get_first_json(arg)
	print("####",arg)
	app = AyguciUI(g)
	app.connect("delete-event", Gtk.main_quit)

if __name__ == "__main__":
	g = get_first_json("module/list")
	app = AyguciUI(g)
	app.connect("delete-event", Gtk.main_quit)
	Gtk.main()
