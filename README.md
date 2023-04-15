# wallpaper-rotator

Automatic desktop wallpaper rotator from specific picture path(s) for LXDE.

script looks for defined image file extensions from multiple directories and sub-directories.

copy ```wallpaper-rotator.sh``` and ```services.sh``` anywhere you wish (by default paths inside .service file set to ```~/.local/bin/```)

make dirs "systemd" and "user" as ```~/.config/systemd/user``` then copy ```wallpaper-rotator.service``` file in there.

then make both .sh scripts executable with ```chmod +x wallpaper-rotator.sh``` and ```chmod +x services.sh``` then add ```@/home/$user/.local/bin/services.sh``` in ```/home/$user/.config/lxsession/LXDE/autostart``` to autostart the script.

run ```systemctl --user start/stop/restart/status wallpaper-rotator.service``` to start/stop/restart and check status of the service.

* script requires ```ImageMagick``` to be installed to get correct resolution and aspect ratio information of the wallpaper images. so make sure you have it installed or you can install by ```sudo apt install imagemagick```
