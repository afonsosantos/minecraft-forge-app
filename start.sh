#!/bin/bash

set -eu

SETTINGS_FILE="/app/data/server.properties"

echo "=> Ensure directories"
mkdir -p /app/data/

echo "=> Accept EULA"
echo "eula=true" > /app/data/eula.txt

if [[ ! -f ${SETTINGS_FILE} ]]; then
    echo "=> Copy initial server.properties"
    cp /app/code/server.properties.template ${SETTINGS_FILE}
fi

echo "=> Update server port"
sed -e "s/server-port.*/server-port=${SERVER_PORT}/" -i ${SETTINGS_FILE}
echo "=> Update query port"
sed -e "s/query.port.*/query.port=${SERVER_PORT}/" -i ${SETTINGS_FILE}

if [[ -z "${RCON_PORT:-}" ]]; then
    echo "=> Disable rcon port"
    sed -e "s/rcon.port.*/rcon.port=/" -i ${SETTINGS_FILE}
    sed -e "s/enable-rcon.*/enable-rcon=false/" -i ${SETTINGS_FILE}
else
    echo "=> Update rcon port"
    sed -e "s/rcon.port.*/rcon.port=${RCON_PORT}/" -i ${SETTINGS_FILE}
    sed -e "s/enable-rcon.*/enable-rcon=true/" -i ${SETTINGS_FILE}
fi

echo "=> Ensure permissions"
chown -R cloudron:cloudron /app/data

echo "=> Starting management server"
exec /usr/local/bin/gosu cloudron:cloudron node /app/code/index.js
