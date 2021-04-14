# Add or uncomment "set bell-style none" to ~/.inputrc in order to silence annoying beeping sound on CLI.

if [ -f $HOME/.inputrc ]; then
    bell_style_options="`cat $HOME/.inputrc | grep 'set bell-style none'`"
        if ! [ -z "$bell_style_options" ] ; then
            bell_style_option_valid=0
            while read -s -r bell_style_option; do
                if ! echo "$bell_style_option" | cut -d ':' -f 1 | grep '#' 1>/dev/null 2>&1; then
                    bell_style_option_valid=1 # Check if bell_style option is validly enabled.
                    break
                fi
            done <<< $(echo "$bell_style_options" | sed 's/set bell-style none/:/')
            if [ $bell_style_option_valid -eq 0 ]; then
                mv $HOME/.inputrc $HOME/.inputrc_old
                bell_style_is_set=0
                while read -s -r line; do
                    if echo "$line" | grep "set bell-style none" 1>/dev/null 2>&1; then
                        if [ $bell_style_is_set -eq 0 ]; then
                            echo "set bell-style none" >> $HOME/.inputrc # Insert bell-style option in place.
                            bell_style_is_set=1
                        fi
                    else
                        echo "$line" >> $HOME/.inputrc
                    fi
                done < $HOME/.inputrc_old
                rm $HOME/.inputrc_old
            fi
        else 
            echo "set bell-style none" >> $HOME/.inputrc # Insert bell-style option into existing .inputrc.
        fi
else
    echo "set bell-style none" > $HOME/.inputrc # Insert bell-style option into a new .inputrc.
fi

echo "$HOME/.inputrc has been successfully updated!"


