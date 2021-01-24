#!/bin/sh
gcc -Os server.c lfs.c /usr/lib/liblua.a -rdynamic -lm -ldl -o ayguci-server
