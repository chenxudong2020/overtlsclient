#!/bin/bash
echolog() {
    echo -e "\033[32m[overtls log]\033[0m" $*
}

echoerr() {
    echo -e "\033[31m[overtls err]\033[0m" $*
}

random_string_gen() {
    local PASS=""
    local MATRIX="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" # "~!@#$%^&*()_+="
    local LENGTH=$1
    [ -z $1 ] && LENGTH="16"
    while [ "${n:=1}" -le "$LENGTH" ]
    do
        PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
        let n+=1
    done

    echo ${PASS}
}


checkconfig(){
     
      if [ -z "${SERVER_HOST}" ]; then
        echo "SERVER_HOST"
        exit 1
      fi
       if [ -z "${SERVER_PORT}" ]; then
        echo "SERVER_PORT"
        exit 1
      fi
       if [ -z "${SERVER_DOMAIN}" ]; then
        echo "SERVER_DOMAIN"
        exit 1
      fi
       if [ -z "${TUNNEL_PATH}" ]; then
        echo "TUNNEL_PATH"
        exit 1
      fi
        
}
initovertlsconfig(){
    rm -rf /overtlsclient/config.json
    cat > /overtlsclient/config.json <<EOF
    {
        "remarks": "${identity}",
        "method": "none",
        "password": "password",
        "tunnel_path": "${TUNNEL_PATH}",
        "client_settings": {
            "server_host": "${SERVER_HOST}",
            "server_port": ${SERVER_PORT},
            "server_domain": "${SERVER_DOMAIN}",
            "listen_user": "${OVERTLS_USER}",
            "listen_password": "${OVERTLS_PASS}",
            "listen_host": "127.0.0.1",
            "listen_port": 1080
          } 
      }     
EOF
}


initsingboxconfig(){
  local file="/overtlsclient/singbox.json"
  if [ ! -f "$file" ]; then     
       \cp -rf /singbox.json /overtlsclient/singbox.json
  fi
rm -rf /config.json
sed \
-e 's/\$//g' \
-e "s/UI_PORT/${UI_PORT}/g" \
-e "s/UI_SECRET/${UI_SECRET}/g" \
-e "s/PROXY_PORT/${PROXY_PORT}/g" \
-e "s/OVERTLS_USER/${OVERTLS_USER}/g" \
-e "s/OVERTLS_PASS/${OVERTLS_PASS}/g" \
-e "s/PROXY_USER/${PROXY_USER}/g" \
-e "s/PROXY_PASS/${PROXY_PASS}/g" \
/overtlsclient/singbox.json > /config.json
}