LUADIR ?= /usr
LUA= lua

INCFLAGS= -I$(LUADIR)/include
CFLAGS= -Os -fPIC $(INCFLAGS) 
LDFLAGS= -fPIC

minisock.so:  minisock.c
	$(CC) -c $(CFLAGS) minisock.c
	$(CC) -shared $(LDFLAGS) -o minisock.so minisock.o
	rm -f *.o

all: minisock.so

clean:
	rm -f *.o *.a *.so

.PHONY: clean
