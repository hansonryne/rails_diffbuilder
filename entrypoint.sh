#!/bin/sh

rm -rf /app/tmp/pids/server.pid

rails s -b 0.0.0.0
