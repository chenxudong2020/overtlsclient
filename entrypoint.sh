#!/bin/sh

source /utils.sh


identity=$(random_string_gen 4)
result=$(checkconfig)
if [ -z "${result}" ]; then
   initovertlsconfig
fi

/overtls -v $OVERTLS_LOG_LEVEL -r client -c /overtlsclient/config.json & initsingboxconfig && /sing-box run -c /config.json

