#!/usr/bin/env bash
main() {
    declare -a directories_root
    declare -a files_user
    directories_root=(
        '/Applications/Ivanti Agent.app'
        '/Applications/Ivanti Workspaces.app'
        '/Library/Application Support/LANDesk'
        /Library/LaunchAgents/com.landesk.dispatch.pl.plist
        /Library/LaunchAgents/com.landesk.dispatch.sui.plist
        /Library/LaunchAgents/com.landesk.dispatch.ui.plist
        /Library/LaunchAgents/com.landesk.ldusermenu.plist
        /Library/LaunchAgents/com.landesk.lockscreen.plist
        /Library/LaunchDaemons/com.landesk.broker.plist
        /Library/LaunchDaemons/com.landesk.cba8.plist
        /Library/LaunchDaemons/com.landesk.dispatch.plist
        /Library/LaunchDaemons/com.landesk.ldtmc.plist
        /Library/LaunchDaemons/com.landesk.ldwatch.plist
        /Library/LaunchDaemons/com.landesk.msgsys.plist
        /Library/LaunchDaemons/com.landesk.pds.plist
        /Library/LaunchDaemons/com.landesk.pds2.plist
        /Library/LaunchDaemons/com.landesk.remote.plist
        /Library/LaunchDaemons/com.landesk.rotatelog.plist
        /Library/LaunchDaemons/com.landesk.scheduler.plist
        /Library/Preferences/com.landesk.ldms.plist
        /Library/Preferences/com.landesk.uuid.plist
        /usr/local/LANDesk
    )
    files_user=(
        ~/Library/Caches/com.landesk.BridgeIT
        ~/Library/Preferences/com.ivanti.PortalManager.plist
        ~/Library/Preferences/com.ivanti.ldgetpolicyimages.plist
        ~/Library/Preferences/com.landesk.BridgeIT.plist
        ~/Library/Preferences/com.landesk.LDUserMenu.plist
    )

    sudo rm -fR \
        '/Library/Logs/DiagnosticReports/Ivanti Workspaces'* \
        '/Library/Application Support/CrashReporter/Ivanti Workspaces'* \
        "${directories_root[@]}" \
        "${files_user[@]}" || return 1
    sudo find /private/var/folders/ '(' \
        -name 'com.ivanti.*' -o -name 'com.landesk.*' ')' \
        -exec rm -fR {} \; || return 1
    sudo rm -fR \
        ~/Library/Caches/com.landesk.* \
        ~/Library/'Saved Application State'/com.ivanti.* || return 1

    while read -r pkg
    do
        sudo pkgutil --forget "$pkg" --volume /
    done < <(pkgutil --volume / --pkgs='^com.(landesk|ivanti)')
    sudo rm -f /private/var/db/receipts/com.landesk* \
        /private/var/db/receipts/com.ivanti*

    echo 'Reboot for changes to take effect.'
}
main
