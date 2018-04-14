#!/bin/bash
echo "====================================="
echo "OpenVPN script by noyes@jomgegar.com "
echo "         Version 1.0 2017            "
echo "====================================="
KEY_DIR=~/openvpn-ca/keys
OUTPUT_DIR=~/client-configs/files
LINUX_CONFIG=~/client-configs/linux.conf
WINDOWS_CONFIG=~/client-configs/windows.conf

echo ""
echo "Please select your setting ? :"
echo "1) OpenVPN Client for Windows"
echo "2) OpenVPN Client for Linux"
read -p "Select an option [1-2]: " option
case $option in
	1)
	echo "Your Client's Name ?"
	read client
	echo " 1) Use Password "
	echo " 2) No Password "
	read -p "Select your option 1 or 2 :" option
	case $option in
		1)
		cd ~/openvpn-ca/
		source vars
		./build-key-pass $client
		;;
		2)
		cd ~/openvpn-ca/
		source vars
		./build-key $client
		;;
	esac
	cat ${WINDOWS_CONFIG} \
    	<(echo -e '<ca>') \
    	${KEY_DIR}/ca.crt \
    	<(echo -e '</ca>\n<cert>') \
    	${KEY_DIR}/$client.crt \
    	<(echo -e '</cert>\n<key>') \
    	${KEY_DIR}/$client.key \
    	<(echo -e '</key>\n<tls-auth>') \
    	${KEY_DIR}/ta.key \
    	<(echo -e '</tls-auth>') \
    	> ${OUTPUT_DIR}/$client.ovpn

	;;	
	2) 
	echo "Your Client's Name ?"
	read client
	echo " 1) Use Password "
	echo " 2) No Password "
	read -p "Select your option 1 or 2 :" option
	case $option in
		1)
		cd ~/openvpn-ca/
		source vars
		./build-key-pass $client
		;;
		2)
		cd ~/openvpn-ca/
		source vars
		./build-key $client
		;;
	esac
	cat ${LINUX_CONFIG} \
    	<(echo -e '<ca>') \
    	${KEY_DIR}/ca.crt \
    	<(echo -e '</ca>\n<cert>') \
    	${KEY_DIR}/$client.crt \
    	<(echo -e '</cert>\n<key>') \
    	${KEY_DIR}/$client.key \
    	<(echo -e '</key>\n<tls-auth>') \
    	${KEY_DIR}/ta.key \
    	<(echo -e '</tls-auth>') \
    	> ${OUTPUT_DIR}/$client.ovpn
	;;
esac
