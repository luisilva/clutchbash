#!/bin/bash
package="rc_backup_ctl" 
        case "$1" in
                -h|--help)
                        echo "$package - Pauses or resumes all backups"
                        echo " "
                        echo "$package [-p|-c] "
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-p, --pause         Pauses all backup jobs currently running that were in crontab"
                        echo "-c, --continue      resumes all paused backup jobs in crontab"
                        exit 0
                        ;;
                -p)
                        SIG="SIGSTOP"
			service puppet stop
			service crond stop
			;;
		--pause)
			SIG="SIGSTOP"
                        service crond stop
			service puppet stop
			;;
                -c)
                        SIG="SIGCONT"
                        service crond start
			service puppet start
			;;
		--continue)
			SIG="SIGCONT"
          		service crond start 
			service puppet start
			;;
        esac
crontab -l |grep run | awk '{print $7}' |sed -e "s/^'//"  -e "s/'$//" | xargs -n1 -I {} pgrep -f  {} | xargs kill -$SIG
