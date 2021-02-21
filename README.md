# Aylinux-2021
Milis linux tabanlı olarak hazırlanan Aylinux 2021 isosunu hazırlamak için aşağıdaki komutları kullanabilirsiniz.

(Milis Linux yada Aylinux 2021 üzerinde çalışır)
------------------------------------------------------------------------
wget https://github.com/oltulu/mps/raw/main/bin/Aylinux-isoyap

chmod +x ./Aylinux-isoyap

sudo su
(root şifrenizi yazınız)

./Aylinux-isoyap
-------------------------------------------------------------------------
Bu komutlardan sonra ekranı takip ediniz. Aylinux.iso dosyanız (işlemler sorunsuz tamamlanırsa /opt/Aylinux-isoyap dizini altında oluşacaktır.
(Xfce masaüstü hazırdır diğer masaüstleri üzerinde çalışılmaktadır.)

Kullanıcı Adı: root

Root Şifresi: toor

# Aylinux-2021 Özellikleri

1- Paket uzantısı .kur şeklindedir (paket_adı-sürüm.kur)

2- Paket kurmak için "paket kur paket_adı", Paket silmek için "paket sil paket_adı"

3- Uygulamaların depolarda güncel olması sağlanacaktır (imkanlar ölçüsünde)

4- Uygulamaların eksik çevirileri tamamlanarak maksimum seviyede Türkçe arayüz ile gelmesi hedeflenmektedir.

5- Aylinux 2021 sadece kendi depolarını kullanmaktadır ve sürekli güncellenmektedir.

6- Yerli yazılımlar depoya alınacak

# Başlıca Komutlar

paket kur paket_adı  (depodaki paketi kurar)

paket sil paket_adı  (kurulu paketi siler)

paket kur paket_adı-sürüm.kur  (yereldeki paketi kurar)




