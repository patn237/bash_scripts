#!/bin/bash

#Continue building on this script.

DELAY=3

while [[ "$REPLY" != 0 ]]; do
    clear

    if [[ $(date +%w) -eq 0 ]]; then
        echo "Hello $USER! Happy Sunday!!"
    elif [[ $(date +%w) -eq 1 ]]; then
        echo "Hello $USER! Happy Monday!!"
    elif [[ $(date +%w) -eq 2 ]]; then
        echo "Hello $USER! Happy Tuesday!!"
    elif [[ $(date +%w) -eq 3 ]]; then
        echo "Hello $USER! Happy Wednesday!!"
    elif [[ $(date +%w) -eq 4 ]]; then
        echo "Hello $USER! Happy Thursday!!"
    elif [[ $(date +%w) -eq 5 ]]; then
        echo "Hello $USER! Happy Friday!!"
    elif [[ $(date +%w) -eq 6 ]]; then
        echo "Hello $USER! Happy Saturday!!"
    else
        echo "Something went wrong." >&2
        exit 1
    fi

    read -p "What can I do for you?
    1. System Check
    2. Updates & Upgrades
    3. Backup Directory
    4. Play the Numbers game
    0. Quit

    Enter selection [0-4] > "

    if [[ ! "$REPLY" =~ ^[0-4]$ ]]; then
        echo "Invalid entry. Please try again."
        sleep "$DELAY"
        clear
    fi

    if [[ "$REPLY" == 1 ]]; then
        if [ -d "/home/$USER/system_check_logs" ]; then
            echo "The directory, system_check_logs, already exists."
            sleep "$DELAY"
            echo "Creating log file..."
            echo "System Name:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "$HOSTNAME" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "System Uptime:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            uptime >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "Network Information:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            ifconfig wlp3s0 >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            df -h | sort -r -k 5 -i | grep -v "loop" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "Home Space Utilization:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            du -sh "$HOME" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            sleep "$DELAY"
            echo "Log file created."
            sleep "$DELAY"
        else
            echo "Creating system_check_logs directory."
            mkdir /home/$USER/system_check_logs
            sleep "$DELAY"
            echo "Creating log file..."
            echo "System Name:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "$HOSTNAME" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "System Uptime:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            uptime >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "Network Information:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            ifconfig wlp3s0 >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            df -h | sort -r -k 5 -i | grep -v "loop" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo -en '\n' >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            echo "Home Space Utilization:" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            du -sh "$HOME" >>/home/$USER/system_check_logs/system_check_$(date +%m%d%Y).txt
            sleep "$DELAY"
            echo "Log file created."
            sleep "$DELAY"
        fi

    elif [[ "$REPLY" == 2 ]]; then
        clear
        while [[ "$REPLY" != d ]]; do
            read -p "Choose one of the following
            a. Perform Update
            b. Perform Upgrade
            c. Perform Update and Upgrade
            d. Exit
            
            Enter selection [a-d] > "

            if [[ ! "$REPLY" =~ ^[a-d]$ ]]; then
                echo "Invalid entry. Please try again."
                sleep "$DELAY"
                clear
                continue
            fi

            if [[ "$REPLY" == a ]]; then
                echo "Performing Update..."
                apt-get -y update
                sleep "$DELAY"
                echo "Update complete."
                sleep "$DELAY"
                clear
                continue
            elif [[ "$REPLY" == b ]]; then
                echo "Performing Upgrade..."
                apt-get -y upgrade
                sleep "$DELAY"
                echo "Upgrade complete."
                sleep "$DELAY"
                clear
                continue
            elif [[ "$REPLY" == c ]]; then
                echo "Performing Update then Upgrade..."
                apt-get -y update && apt-get -y upgrade
                sleep "$DELAY"
                echo "Update and Upgrade complete."
                sleep "$DELAY"
                clear
                continue
            else
                [[ "$REPLY" == d ]]
                echo "Returning to main menu."
                sleep "$DELAY"
                return
            fi
            break
        done

    elif [[ "$REPLY" == 3 ]]; then
        clear
        while [[ "$target" != 0 ]]; do

            echo -en '\n'
            echo "Please note, all directories and files will be stored into /home/$USER/backups. If there is no backups directory, this script will make one for you."
            echo -en '\n'
            echo "Press 0 to return to main menu."
            echo -en '\n'
            read -p "Please type in which directory or file you wish to backup: " target

            if [[ "$target" != 0 ]]; then

                if [ -d /home/$USER/backups ]; then
                    echo "Backing up target..."
                    sleep "$DELAY"
                    cp -rv $target /home/$USER/backups
                    echo "Backup completed."
                    sleep "$DELAY"
                    clear
                    continue
                else
                    echo "Creating backups directory..."
                    mkdir /home/$USER/backups
                    sleep "$DELAY"
                    echo "backups directory created."
                    sleep "$DELAY"
                    echo "Backing up target..."
                    sleep "$DELAY"
                    cp -rv $target /home/$USER/backups
                    echo "Backup completed."
                    sleep "$DELAY"
                    clear
                    continue
                fi

            else
                [[ "$target" == 0 ]]
                echo -en '\n'
                echo "Returning to main menu."
                sleep "$DELAY"
                unset target
                return
            fi
            break
        done

    elif [[ "$REPLY" == 4 ]]; then
        echo "Opening the Numbers game..."
        sleep "$DELAY"
        ./number_game.sh #Opens my numbers game script
        sleep "$DELAY"
        continue

    else
        [[ "$REPLY" == 0 ]]
        echo "Exiting script."

    fi
    break
done
