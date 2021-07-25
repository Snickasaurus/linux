#!/bin/bash
# date			2018/01/04
# author		Nick Smith
# purpose		First run script to setup account
# requires		Run as sudo
# usage			$ sh ./accountSetup.sh

# Variables
_cd=$(command -v cd)
_cp=$(command -v cp)
_mkdir=$(command -v mkdir)
_apt=$(command -v apt)
_chmod=$(command -v chmod)
_chown=$(command -v chown)
_wget=$(command -v wget)
currentTime=$(date "+%Y%m%d-%H.%M.%S")
currentUser=$(ls -l /dev/console | cut -d " " -f 4)
currentLogDir=/tmp/"$(basename "$0")"

# Running as Root?
if [[ $EUID -ne 0 ]]
	then
	echo "You're not root, exiting."
	exit 1
fi

# Logging
if [ ! -e "$currentLogDir" ]
then
	/bin/mkdir -p "$currentLogDir"
fi

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>/tmp/"$(basename "$0")".log 2>&1

# Script begin
echo "Begin: $currentTime"
echo "- - - - - - - - - - - - - - -"
echo "Creating root/data structure"
if [ ! -e /data ]
then
	$_mkdir -p /data
	$_mkdir -p /data/{backups,logs,scripts,temp}
	$_chown -R "$currentUser" /data
	$_chmod -R 774 /data
fi

echo "- - - - - - - - - - - - - - -"
echo "Creating home/.ssh directory"
if [ ! -e "$currentUser"/.ssh ]
then
	/bin/mkdir -p "$currentUser"/.ssh
fi

"$_cd" /tmp || exit 1; echo "tmp directory is missing"

echo "- - - - - - - - - - - - - - -"
# Pulling down .bash_aliases from Github
echo "Pull .bash_aliases from Github"
"$_wget" --trust-server-names https://git.io/fxBiz

echo "- - - - - - - - - - - - - - -"
echo "Copying .bash_aliases to home dir"
# Moving it into place
"$_cp" .bash_aliases /root
"$_cp" .bash_aliases "$HOME"
source ~/.bash_aliases

echo "- - - - - - - - - - - - - - -"
# Install utils
echo "Running update/upgrade via APT"
"$_apt" update && "$_apt" upgrade -y

echo "- - - - - - - - - - - - - - -"
# Install utils
"$_apt" install -y p7zip unrar mc rkhunter

# Script end
echo "End: $currentTime"

# Done
exit 0
