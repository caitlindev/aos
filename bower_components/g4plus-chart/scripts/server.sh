#!/bin/bash
# first parameter sets the server port
# ./script/server.sh 8080
# by default the port is set to 3333

rm -rf _public
node_modules/gulp/bin/gulp.js --require coffee-script --port=$1 --server=true