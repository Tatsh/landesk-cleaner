#!/usr/bin/env bash
main() {
    local service name
    declare -a apps
    declare -a landesk_services
    landesk_services=(
        com.landesk.broker
        com.landesk.cba8
        com.landesk.dispatch
        com.landesk.dispatch.pl
        com.landesk.dispatch.sui
        com.landesk.dispatch.ui
        com.landesk.ldtmc
        com.landesk.ldusermenu
        com.landesk.ldwatch
        com.landesk.lockscreen
        com.landesk.msgsys
        com.landesk.pds
        com.landesk.pds2
        com.landesk.remote
        com.landesk.rotatelog
        com.landesk.scheduler
    )
    apps=(
        'Ivanti Agent'
        'Ivanti Workspaces'
        'Portal Manager'
    )

    for service in "${landesk_services[@]}"; do
        sudo lunchy stop -x -w "$service"
    done
    for service in "${landesk_services[@]}"; do
        lunchy stop -x -w "$service"
    done
    for name in "${apps[@]}"; do
        sudo killall -9 "$name" 2>/dev/null
    done
    for name in '/Library/Application Support/LANDesk/bin/'*; do
        sudo killall -9 "$(basename "$name")" 2>/dev/null
    done
}
main
