#!/bin/sh

dbus-update-activation-environment --systemd --all
systemctl --user start wallpaper-rotator.service	# to be able to run wallpaper-rotator script it needs X so we create this service.sh to run in .config/lxsession/LXDE/autostart
# systemctl --user start another.service

# run "systemctl --user start/stop/restart/status wallpaper-rotator.service" to start/stop/restart and check status of the service.
# DO NOT USE "sudo" with "--user"