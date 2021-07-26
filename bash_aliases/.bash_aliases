#-------------------------------------------------------------
# Editing & Viewing
#-------------------------------------------------------------
alias catba='cat ~/.bash_aliases'
alias editba='nano ~/.bash_aliases'
alias sourceba='source ~/.bash_aliases'
alias cathosts='cat /etc/hosts'
alias edithosts='sudo vi /etc/hosts'

#-------------------------------------------------------------
# Move around a little easier/lazier
#-------------------------------------------------------------
alias hc='cd ~ && clear'
alias c='clear'
alias h='cd ~'
alias r='cd /'
alias d='cd /data'
alias dl='cd /data/logs'
alias ds='cd /data/scripts'
alias dt='cd /data/temp'

#-------------------------------------------------------------
# Show set system paths
#-------------------------------------------------------------
alias paths='echo -e ${PATH//:/\\n}'

#-------------------------------------------------------------
# Listing the directory structure | pretty
#-------------------------------------------------------------
alias ll='ls -lhG'
alias la='ls -alhG'
alias lx='ls -lB'           #  Sort by extension.
alias lk='ls -lSr'          #  Sort by size, biggest last.
alias lt='ls -ltr'          #  Sort by date, most recent last.
alias lc='ls -ltcr'         #  Sort by/show change time,most recent last.
alias lu='ls -ltur'         #  Sort by/show access time,most recent last.

#-------------------------------------------------------------
# Extraction
#-------------------------------------------------------------
extract(){
    if [ -f "$1" ]
        then
        case $1 in
            *.tar.bz2)  tar xvjf "$1"     ;;
            *.tar.gz)   tar xvzf "$1"     ;;
            *.bz2)      bunzip2 "$1"      ;;
            *.rar)      unrar x "$1"      ;;
            *.gz)       gunzip "$1"       ;;
            *.tar)      tar xvf "$1"      ;;
            *.tbz2)     tar xvjf "$1"     ;;
            *.tgz)      tar xvzf "$1"     ;;
            *.zip)      unzip "$1"        ;;
            *.Z)        uncompress "$1"   ;;
            *.7z)       7z x "$1"         ;;
            *)          echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

#-------------------------------------------------------------
# Compression
#-------------------------------------------------------------
# Creates an archive (*.tar.gz) from given directory.
mkgz(){
    tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"
}

# Creates an archive (*.tar.bz2) from a given directory
mkbz2(){
    tar cvjSf "${1%%/}.tar.bz2" "${1%%/}/"
}

# Create a ZIP archive of a file or folder.
makezip(){
    zip -r "${1%%/}.zip" "$1"
}

# Make your directories and files access rights sane.
sanitize(){
    chmod -R u=rwX,g=rX,o= "$@"
}

#-------------------------------------------------------------
# Backup anything you send as an argument
#-------------------------------------------------------------
backup(){
    tar -cPf - "$1" | gzip -9 - > /data/backups/"$1"."$(date "+%Y%m%d-%H.%M.%S")".tar.gz
}

#-------------------------------------------------------------
# Date and time incase Terminal is full screen.
#-------------------------------------------------------------
now(){
    echo "------------------"
    echo -e "${Yellow}Day  : ${Red}  $(date '+%A')"
    echo -e "${Yellow}Date : ${White}  $(date '+%Y-%m-%d')"
    echo -e "${Yellow}Time : ${Green}  $(date '+%r')"
    echo "------------------"
}

#-------------------------------------------------------------
# Processes and services
#-------------------------------------------------------------
ii(){
    # Variables
    os_var_1=`lsb_release -d | awk '{print $2,$3,$4}'`
    os_va_2=`lsb_release -c | awk '{print $2}'`
    uptyme=`uptime | awk '{print $2,$3,$4,$1 " | " $5,$6}'`
    users=`w -h | awk '{print $1,$2,$3}'`
    # Begin
    echo -e "${Red}You are logged on: $NC"
    hostname
    echo " "
    echo -e "${Red}OS Version $NC"
    echo $os_var_2 $os_var_3
    echo " "
    echo -e "${Red}Current date $NC"
    date
    echo " "
    echo -e "${Red}Stats $NC"
    echo $uptyme
    echo " "
    echo -e "${Red}Users logged on $NC"
    w -h
    echo " "
}

#-------------------------------------------------------------
# Change the text color
#-------------------------------------------------------------
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White
# Reset to default
NC='\033[0m'            # Color Reset
