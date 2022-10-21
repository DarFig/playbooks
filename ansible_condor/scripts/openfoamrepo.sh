#!/bin/bash

pubkey_url="https://dl.openfoam.com/pubkey.gpg"
repos_url="https://dl.openfoam.com/repos/deb"

apt_pubkey_name="openfoam.gpg"
apt_source_name="openfoam.list"



unset codeName

if [ -e /etc/os-release ]
then
    [ -n "$codeName" ] || codeName="$(sed -ne 's/^UBUNTU_CODENAME=//p' /etc/os-release)"
    [ -n "$codeName" ] || codeName="$(sed -ne 's/^VERSION_CODENAME=//p' /etc/os-release)"
fi

apt_pubkey_path="/etc/apt/trusted.gpg.d/${apt_pubkey_name}"

apt_source_path="/etc/apt/sources.list.d/${apt_source_name}"


fileAction="Added"
if [ -f "$apt_source_path" ]
then
    fileAction="Overwrote"
fi

echo "### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out this entry, but any other modifications may be lost.
deb [arch=amd64] ${repos_url} ${codeName} main" \
    > "$apt_source_path"
echo "$fileAction $apt_source_path"

fileAction="Added"
if [ -f "$apt_source_path" ]
then
    fileAction="Overwrote"
fi

curl -L "${pubkey_url}" 2>/dev/null | gpg --dearmor > "$apt_pubkey_path"
apt-get update -y >/dev/null 2>/dev/null
