#!/bin/bash
###############################################################
#                                                             #
#			filename: dice.sh                     #
#			 written@kr0nica                      #
#	A simple BASH-based simulator of dice rolling         #
#                                                             #
###############################################################


#Definitions of used functions
##############################
#Print bolded font
bold() {
   	tput bold
	echo -n "$@"
	tput sgr0
}

#Print underlined font
ul() {
	tput smul
	echo -n "$@"
	tput rmul
}

#Help
show_help() {
	echo -e "\t
	$(bold Usage: dice XdY) 
	$(bold XdY = X Y-sided dices)
	$(bold For example: dice 4d6 18d11)
	"
}

#Options description and errors
###############################
if [[ "$#" -eq 0 ]]; then
	show_help
	exit 1
fi

for args in "$@"; do
	if [[ ! "$args" =~ ^[1-9][0-9]*d[1-9][0-9]*$ ]]; then
		echo ""
		echo -e "\t\e[1;31mInvalid format for die.\e[0m"
		echo -e "\t\e[1;31mThat would break reality.\e[0m"
		show_help
		exit 1
        fi
done

#Rollig dices
#############
for arg in "$@"; do
	dice=$(echo $arg | cut -dd -f1)
	sides=$(echo $arg | cut -dd -f2)
	echo ""
	echo "Rolling..."
	sleep 1
	echo -ne "\e[36m$arg\e[0m  "

		#Results calculation
		####################
		sum=0
		while [ $dice -gt 0 ]; do
			roll=$(( ( $RANDOM % $sides ) + 1 ))
			echo -n "$roll "
			sum=$(( $sum + $roll ))
			tsum=$(( $tsum + $roll ))
			dice=$(( $dice - 1 ))
		done

		echo -e "= \e[34m$(bold $sum)\e[0m"
done
	echo ""
	echo -e "\tCalculating..."
	sleep 1
	echo -e "\t\t\e[31m$(bold $(ul TOTAL $tsum))\e[0m"
	echo ""
