#!/bin/sh

dbus-update-activation-environment --systemd --all
systemctl --user start wallpaper-rotater.service # to be able to run wallpaper-rotator script it needs X so we create this service.sh to run in .config/lxsession/LXDE/autostart
# systemctl --user start another.service

# run "systemctl --user restart wallpaper-rotator.service" to start/restart the script.
# "systemctl --user status wallpaper-rotator.service"  to check status.
# DO NOT USE "sudo" with "--user"