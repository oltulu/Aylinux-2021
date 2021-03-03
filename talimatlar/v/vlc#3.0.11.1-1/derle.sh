sed -i '/vlc_demux.h/a #define LUA_COMPAT_APIINTCASTS' modules/lua/vlc.h
sed -i '/LIBSSH2_VERSION_NUM/s/10801/10900/' modules/access/sftp.c
sed -i '/#include <QWidget>/a\#include <QPainterPath>/' \
 modules/gui/qt/util/timetooltip.hpp
sed -i '/#include <QPainter>/a\#include <QPainterPath>/' \
 modules/gui/qt/components/playlist/views.cpp \
 modules/gui/qt/dialogs/plugins.cpp

BUILDCC=gcc ./configure --prefix=/usr \
            --disable-rpath \
            --sysconfdir=/etc \
            --disable-ncurses \
            --enable-aa \
            --enable-upnp \
            --enable-opus \
            --enable-dvbpsi \
            --enable-x264 \
            --enable-x265 \
            --enable-vdpau \
            --enable-sdl-image \
            --enable-fribidi \
            --enable-gnutls \
            --enable-bluray \
            --disable-vpx \
            --disable-opencv

make
