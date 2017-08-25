#! /bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: $(basename $0) n1|n2|n3|all"
	exit
fi

BMS_PREFIX="192.168.20.$MM"
PW_STATE="off"

set_power_state() {
	MM=$(echo $1 | tr n 1)
	BMS_IP="$BMS_PREFIX.$MM"
	echo "BMS => $BMS_IP"
	ipmitool -H $BMS_IP -U root -P root chassis power $PW_STATE 2> /dev/null && sleep 5
}

for N in "$@"
do
	if [ "$N" == "all" ]; then
		set_power_state 'n1'
		set_power_state 'n2'
		set_power_state 'n3'
	else
		set_power_state $N
	fi
done

