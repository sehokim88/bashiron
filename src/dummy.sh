#! /bin/bash

# echo hi, who are you?

# read -p 'username: ' USERNAME
# read -sp 'password: ' PASSWORD
# echo
# echo $USERNAME $PASSWORD

echo $(echo $@ | cut -d ' ' -f 1,2,3 ) 