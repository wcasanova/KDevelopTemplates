#!/bin/bash

# Exit if something fails
set -e

# TODO Enable if the project is on Github
if [[ $(basename "$PWD") != "%{APPNAME}"* ]];then
    #git clone https://github.com/%{USERNAME}/%{APPNAME}
    #cd %{APPNAME}/
    echo "Please go to the project folder"
    exit
fi

mkdir -p build
cd build
cmake -DQT_PLUGIN_INSTALL_DIR=`kf5-config --qt-plugins` -DCMAKE_BUILD_TYPE=Release  ..
make -j$(nproc)
sudo make install

kquitapp5 krunner 2> /dev/null
kstart5 --windowclass krunner krunner > /dev/null 2>&1 &

echo "Installation finished !";