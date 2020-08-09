add-apt-repository -y ppa:gnome-terminator
if [ $? != 0 ]; then
    apt-get install -y software-properties-common
    apt-get update
    add-apt-repository -y ppa:gnome-terminator
fi
apt-get update
apt-get install -y terminator

