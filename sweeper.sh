#!/bin/bash

function class() {

if [ $CLASS == "/8" ]
then
	class_A
elif [ $CLASS == "/16" ]
then
	class_B
elif [ $CLASS == "/24" ]
then
	class_C
else
	echo "There was an error"
	main
fi
}

function class_A() {
echo "Welcome to CLASS A"
read -p "PRESS ENTER"
main
}

function class_B() {
#echo "Welcome to CLASS B"
#read -p "PRESS ENTER"
#main

echo "Live Hosts"
echo "==============================================="

SCAN_IP=$(echo "$IP" | sed 's/\./ /g' | awk '{print $1,$2}' | sed 's/ /\./g')
for b in {1..254}
do
	for c in {1..254}
	do
		sleep .008
        	ping -c 1 "$SCAN_IP"."$b"."$c" | grep ^64 | awk '{print $4}' | cut -d ":" -f 1 &
	done
done
echo "==============================================="
echo ""
read -p "Press ENTER to continue"
tput -x clear
main


}


function class_C() {
echo "Live Hosts"
echo "==============================================="

SCAN_IP=$(echo "$IP" | sed 's/\./ /g' | awk '{print $1,$2,$3}' | sed 's/ /\./g')
for i in {1..254}
do
        ping -c 1 $SCAN_IP.$i | grep ^64 | awk '{print $4}' | cut -d ":" -f 1 &
done
echo "==============================================="
echo ""
read -p "Press ENTER to continue"
tput -x clear
main
}

function main() {
echo "         Sweeper Host Discovery Sytem"
echo "==============================================="
NETS=$(ip addr | grep 'inet ' | sed 's/^\t//g' | sed 's/$/\*/g' | awk '{print $NF $2}' | sed 's/\*/ | /g' | awk '{print $1,$2,$3}' | sed 's/\// \//g' | awk '{printf "%-16s %-2s %-16s %-4s \n", $1,$2,$3,$4}')
echo "$NETS" | sed '=' | sed '{N;s/\n/)  /}'
NUMBER_OF_NETS=$(echo "$NETS" | sed '=' | sed '{N;s/\n/.)  /}')
echo ""
echo "==============================================="
echo ""
echo
read -p "Type number of network to scan...> " NET
echo ""
CLASS=$(echo "$NUMBER_OF_NETS" | grep ^$NET | awk '{print $5}')
IP=$(echo "$NUMBER_OF_NETS" | grep ^$NET | awk '{print $4}')

	if [[ "$CLASS" == "/8" ]]
	then
        	class_A
	elif [[ "$CLASS" == "/16" ]]
	then
        	class_B
	elif [[ "$CLASS" == "/24" ]]
	then
        	class_C
	else
        	echo "There was an error"
        	main
	fi


}

main


#for i in {1..254}
#do
#	ping -c 1 $IP.$i | grep ^64 | awk '{print $4}' | cut -d ":" -f 1 &
#done
