#!/usr/bin/env sh

sed -i \
    -e "s/#GAME_STYLE#/${GAME_STYLE:-"3"}/g" \
    -e "s/#MAX_PLAYERS#/${MAX_PLAYERS:-"32"}/g" \
    -e "s/#GAME_PASSWORD#/${GAME_PASSWORD:-""}/g" \
    -e "s/#ADMIN_PASSWORD#/${ADMIN_PASSWORD:-"$(< /dev/urandom tr -dc A-Za-z0-9 | head -c8; echo)"}/g" \
    -e "s/#SERVER_NAME#/${SERVER_NAME:-"Just another FFA"}/g" \
    -e "s/#BALANCE_TEAMS#/${BALANCE_TEAMS:-"1"}/g" soldat.ini

./soldatserver -p 23073 -l ${MAX_PLAYERS:-"32"}