#!/usr/bin/env bash
main() {
    local service name
    while read -r service
    do
        sudo lunchy start -x "$service"
    done < <(sudo lunchy ls | grep -F landesk)
    while read -r service
    do
        lunchy start -x "$service"
    done < <(lunchy ls | grep -F landesk)
    while read -r name
    do
        open -j "$name" && break
    done < <(find /Applications -type d -name 'Ivanti Agent.app')
}
main
