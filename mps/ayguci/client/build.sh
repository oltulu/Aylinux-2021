#!/bin/sh
gcc -Os client.c /usr/lib/liblua.a -rdynamic -lm -ldl -o ayguci-client
