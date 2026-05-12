#!/bin/bash

# =========================
# VARIABLES
# =========================

# First argument passed to the script (IP or network)
identificador=$1

# Second argument passed to the script (starting port)
port1=$2

# Third argument passed to the script (ending port)
port2=$3

# Clears the terminal screen
clear

# =========================
# NMAP INSTALLATION CHECK
# =========================

# Checks if nmap is installed on the system
if ! command -v nmap >/dev/null 2>&1; then

    echo "nmap not found. Installing..."

    # Checks if the system uses apt package manager
    if command -v apt >/dev/null 2>&1; then

        # Updates repositories and installs nmap automatically
        sudo apt update && sudo apt install -y nmap

    fi

fi

# Clears the screen again after installation
clear

# =========================
# MAIN MENU LOOP
# =========================

# The menu will keep appearing until the user selects 0
while [ "$opcio" != "0" ]; do

echo "MAIN MENU NMAP BY MARTÍ GENSANA"
echo "===================================="
echo ""

# =========================
# INPUT VALIDATION
# =========================

# Checks:
# - If no IP/network was provided
# - If the starting port is lower than 0
# - If the ending port is greater than 65535
if [[ ! -n "$identificador" || "$port1" -lt 0 || "$port2" -gt 65535 ]]; then

	clear

	echo "Incorrect port range! Greater than 65535 or lower than 0"

	# Exits the script if validation fails
	exit 0

# Checks if both ports were provided
elif [[ -n "$port1" && -n "$port2" ]]; then

	echo "Selected network/IP: $identificador with port range from $port1 to $port2"

else

	# Shows only the IP/network if ports were not specified
	echo "Selected network/IP: $identificador"

fi

# =========================
# MENU OPTIONS
# =========================

echo ""
echo "1 - Normal network scan"
echo "2 - Operating system scan (requires sudo)"
echo "3 - Services + versions scan"
echo "4 - Port range scan"
echo "5 - About"
echo "0 - Exit"
echo ""
echo -n "Select an option: "

# Reads the user's menu choice
read opcio

# =========================
# CASE MENU
# =========================

case $opcio in

	# =========================
	# OPTION 1 - NORMAL SCAN
	# =========================

	1)

		# If ports were provided
		if [[ -n "$port1" && -n "$port2" ]]; then

				echo ""

				# Informational message
				echo "This option does not use ports, scanning the network $identificador without taking ports into account"

				# Waits 3 seconds
				sleep 3

				echo ""

				# Basic nmap scan
				nmap "$identificador"
			
			else
			
				# Basic scan without ports
				nmap "$identificador"

		fi

		# Waits for the user before continuing
		read -p "Press any key to exit"

	;;

	# =========================
	# OPTION 2 - OS DETECTION
	# =========================

	2)

		# If ports were specified
		if [[ -n "$port1" && -n "$port2" ]]; then
			
			echo "Scanning the network/IP $identificador from port $port1 to $port2 detecting operating systems"

			sleep 3

			# Detects operating systems in the specified port range
			nmap -O -p "$port1-$port2" "$identificador"

		else
			
			echo "Scanning operating systems on the network/IP $identificador"

			sleep 3

			# Detects operating systems without specifying ports
			nmap -O "$identificador"

		fi
	
		read -p "Press any key to exit"

	 ;;

	# =========================
	# OPTION 3 - SERVICES & VERSIONS
	# =========================

	3)

	 	# If ports were specified
	 	if [[ -n "$port1" && -n "$port2" ]]; then
			
			echo "Scanning services and versions on the network/IP $identificador from port $port1 to $port2"

			sleep 3

			# Detects service versions on selected ports
			nmap -sV -p "$port1-$port2" "$identificador"

		else
			
			echo "Scanning services and versions on the network/IP $identificador in general"

			sleep 3

			# General service/version scan
			nmap -sV "$identificador"

		fi
	
		read -p "Press any key to exit"

	 ;;

	# =========================
	# OPTION 4 - PORT RANGE SCAN
	# =========================

	4)

	 # Checks if ports were provided
	 if [[ -n "$port1" && -n "$port2" ]]; then
			
			echo "Scanning the network/IP $identificador from port $port1 to $port2 "

			sleep 3

			# Scans only the selected port range
			nmap -p "$port1-$port2" "$identificador"

		else
			
			# Error if no ports were provided
			echo "Ports must be specified, exiting"

			exit 0
			
		fi

		read -p "Press any key to exit"

	;;

	# =========================
	# OPTION 5 - ABOUT
	# =========================

	5)

	 echo ""
	 echo "Created by: Martí Gensana Claus"
	 echo ""
	 echo "Aspiring pentester/ethical hacker"
	 echo ""
	 echo "Tryhackme: https://tryhackme.com/p/DonTermi"
	 echo ""
	 echo "Linkedin: https://es.linkedin.com/in/mart%C3%AD-gensana-claus-85b4b8398"
	 echo ""

	 # Waits before returning to the menu
	 read -p "Press any key to exit"
	
	;;

	# =========================
	# OPTION 0 - EXIT
	# =========================

	0)

	echo ""

	echo "See you soon $USER! Thanks for using my script! =]"

	# Ends the script
	exit 0

esac

# Clears the screen before showing the menu again
clear

done
