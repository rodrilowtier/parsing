#!/bin/env bash


[ ! -x "$(which curl)" ] && echo -e "[*] Curl is not found !" && sudo apt install curl -y && exit 1

RED="\033[0;31m"
DEFAULT_COLOR="\033[0m"
GREEN="\033[0;32m"
PURPLE="\033[1;35m"
YELLOW="\033[1;33m"
L_RED="\033[1;31m"
function _Parsing () {

	echo -e "\n$PURPLE    [+] $DEFAULT_COLOR Resolving URLs In :$L_RED $1\n\n\n$PURPLE"


	curl -s -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36" $1 | grep "href" | cut -d '"' -f 2 | grep "^http.*" | cut -d "/" -f 3 > list
	echo -e "\t$YELLOW######################################################"
	echo -e "\t|->    	$GREEN	[+] $DEFAULT_COLOR Buscando Hosts... $YELLOW            <-|"
	echo -e "\t$YELLOW######################################################$DEFAULT_COLOR\n\n"
	for i in $(cat list)
	do
		echo "[*]  $i"
	done
	echo -e "\n\n\t$YELLOW######################################################"
	echo -e "\t|->    	$GREEN	[+] $DEFAULT_COLOR Resolvendo IPs... $YELLOW            <-|"
	echo -e "\t$YELLOW######################################################$DEFAULT_COLOR\n\n"

	for i in $(cat list)
	do
		host -4 $i | grep -vi "nxdomain" | sed 's/has address/------------/' | grep -vi "ipv6" | grep -vi "alias"
	done

	rm list
}



if [ "$1" == "" ]
then
	echo "usage : $0 <https://example.com> "

else
	_Parsing $1 

fi




