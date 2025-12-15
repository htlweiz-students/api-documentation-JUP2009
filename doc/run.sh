#!/usr/bin/env sh
cd /doc
[ -z "${PORT}" ] && PORT=8000
BIND=0.0.0.0:${PORT}
echo Starting mkdocs on BIND ${BIND}
running="y"
stop() {
  running="n"
}
while [ "y" = "${running}" ]; do
  mkdocs serve -a ${BIND} & 
  pid=$!
  sleep 10
  kill ${pid}
done
