#!/usr/bin/bash

PS3='Please choose an operation: '
ops=("Backup"  "Restore" "Exit")
select op in "${ops[@]}"; do
    case $op in
        "Backup")

                NOW=$(date +"%Y-%m-%d-%H%M")

                echo -e "\033[0;32mBackup in progress... \033[0m "
                mkdir -p /home/backup/$NOW
                tar -zcf /home/backup/$NOW/trueshoes.net.$NOW.tar /var/www/html/wordpress/
                mysqldump --databases TrueShoesdb > /home/backup/$NOW/trueshoesdb.net.$NOW.sql 
                echo -e "\033[0;32mBackup is done ! \033[0m "
                ;;

        "Restore")
                
                echo -e "\033[0;32mRestoring Wordpress and Database \033[0m "
                mkdir /home/restore/$NOW/ > /dev/null 2>&1
                cd /home/backup
                ls -alt /home/backup
                read -e -p "What backup to choose ? " BCKUPDIR
                mkdir -p /home/restore/$NOW/ && tar -xf /home/backup/$BCKUPDIR*.tar -C /home/restore/$NOW/
                mysql TrueShoesdb < $BCKUPDIR*.sql
                echo -e "\033[0;32mRestoration complete ! \033[0m "

                ;;
        
        "Exit")
            exit
            ;;

        *) echo "Invalid input";;
    esac
done