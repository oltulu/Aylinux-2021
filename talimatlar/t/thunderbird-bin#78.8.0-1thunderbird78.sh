#!/usr/bin/bash

if
	[ ! -d $HOME/.thunderbird78 ]
then
	install -d -m 0700 $HOME/.thunderbird78
fi

exec /opt/thunderbird78/thunderbird --profile $HOME/.thunderbird78 "$@"
