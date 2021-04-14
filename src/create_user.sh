#! /bin/bash

# Create User
create_new_user() {
    # todo (skim) Impelement argument validation.
    local username=$1
    local userhome=/home/$1

    if [ $UID -ne 0 ]; then
        echo "You must be root in order to create a new account."
        exit 1
    fi
    
    if cat /etc/passwd | cut -d ':' -f 1 | grep $username 1>/dev/null 2>&1; then
        echo "$username already exists."
    else
        echo "Creating a new user $username..."
        useradd -s /bin/bash $username
        passwd $username
    fi

    if [ -e $userhome ]; then
        echo "$userhome already exists."
    else
        echo "Creating a home directory $userhome for $username..."
        mkdir $userhome
        chown $username $userhome
        usermod -d $userhome $username
    fi
}


main () {
    while getopts 'u:' flag; do
        case "${flag}" in
            u) username="${OPTARG}" ;;
            *) echo 'Usage...'; exit 1 ;;
        esac
    done

    if ! [ -z $username ] ; then
        create_new_user $username
        su $username
    fi

    echo User created!
    
}


main $@
