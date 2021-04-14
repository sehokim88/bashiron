setup_git_ssh() {
    # todo (skim) Impelement argument validation.
    local git_host=$1
    local git_domain=$(echo $git_host | cut -d '.' -f 1)
    local git_user=$2
    local priv_key_file=$HOME/.ssh/${git_domain}_${git_user}
    local ssh_config_path=$HOME/.ssh/config

    echo "Creating a ssh key pair for ${git_domain}_${git_user}..."
    if [ -e $priv_key_file ]; then
        echo "$priv_key_file already exists."
    else
        ssh-keygen -f $priv_key_file # todo (skim) Catch if error if this fails.

        echo "Setting proper permission for the key file..."
        chmod 600 $priv_key_file

        echo "Creating entry in ssh config file..."
        echo -e "Host $git_host\n\tUser git\n\tIdentityFile $priv_key_file\n" >> $ssh_config_path

        echo "Make sure to put the pubkey to the target host."
        pubkey_on_target='no'
        while :; do
            read -p "Have you successfully put the pubkey to the target host? (yes/no): " pubkey_on_target
            if [ $pubkey_on_target = 'no' ]; then
                echo "Make sure to put the pubkey to the target in order to use git."
                break
            elif [ $pubkey_on_target = 'yes' ]; then
                break
            else
                continue
            fi
        done
    fi
}

main () {
    setup_git_ssh "github.com" "sehokim88" 
    setup_git_ssh "bitbucket.com" "skim88"
    # pull_configs $pubkey_on_target
}

main $@

# # Pull startup management project repo
# mkdir /home/sehokim/projs &&\
# git clone 

# # Set up bash Startup
# # todo (skim) Implement control flow.
# # curl .bashrc from s3
# # curl .bash_aliases from s3

# # Pull vim startup
# # todo (skim) Implement control flow.
# # curl .vimrc from s3

# # Pull vscode startup
# # todo (skim) Implement control flow.
# # curl .vscode from s3