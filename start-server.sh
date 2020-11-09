#!/bin/sh

if nc 127.0.0.1 3000 < /dev/null
then
	echo "Server already running on localhost:3000"
else
	echo "Launching meals mock server"
  cd shared/src/ && json-server --watch db.json
fi
