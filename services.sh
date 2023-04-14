#!/bin/sh

dbus-update-activation-environment --systemd --all
systemctl --user start wallpaper-rotator.service
# systemctl --user start another.service

# run "systemctl --user start/stop/restart/status wallpaper-rotator.service" to start/stop/restart and check status of the service.
# DO NOT USE "sudo" with "--user"

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

# dbus-update-activation-environment updates the list of environment variables used by dbus-daemon --session when it activates session services without using systemd.
#
# With the --systemd option, if an instance of systemd --user is available on D-Bus, 
# it also updates the list of environment variables used by systemd --user when it activates user services,
# including D-Bus session services for which dbus-daemon has been configured to delegate activation to systemd. 
# This is very similar to the import-environment command provided by systemctl(1)).
#
# dbus-update-activation-environment is primarily designed to be used in Linux distributions' X11 session startup scripts, in conjunction with the "user bus" design. 

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;