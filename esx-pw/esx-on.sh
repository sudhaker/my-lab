#! /bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: $(basename $0) n1|n2|n3|all"
	exit
fi

PW_STATE=on

for N in "$@"
do
	if [ "$N" == "all" ] || [ "$N" == "n1" ]; then
		ipmitool -H 192.168.20.11 -U root -P root chassis power $PW_STATE 2> /dev/null
		sleep 5
	fi

	if [ "$N" == "all" ] || [ "$N" == "n2" ]; then
		ipmitool -H 192.168.20.12 -U root -P root chassis power $PW_STATE 2> /dev/null
		sleep 5
	fi

	if [ "$N" == "all" ] || [ "$N" == "n3" ]; then
		ipmitool -H 192.168.20.13 -U root -P root chassis power $PW_STATE 2> /dev/null
		sleep 5
	fi
done

