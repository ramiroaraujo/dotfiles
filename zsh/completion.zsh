export NVM_DIR="/Users/ramiro/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -r $NVM_DIR/zsh_completion ]] && . $NVM_DIR/zsh_completion

eval "$(gulp --completion=zsh)"
eval "$(grunt --completion=zsh)"

#. <(npm completion)

_cakephp () {
    if [ ! -f bin/cake ] ; then
        return
    fi

    local commands command subcommands command_options subcommand_options

    commands=$(bin/cake completion commands)

    if [[ "$CURRENT" = 2 ]]; then
        compadd `echo ${commands}`
        return 0
    fi

    command=$words[2]
    subcommands=`bin/cake completion subcommands ${command}`
    command_options=`bin/cake completion options ${command}`

    if [[ "$CURRENT" = 3 ]] ; then
        compadd `echo ${subcommands}`
        return 0
    fi

        if [[ "$CURRENT" = 4 ]] ; then
        compadd `echo ${command_options}`
        return 0
    fi
}

compdef _cakephp bin/cake
compdef _cakephp cake

#Alias
#alias c3='bin/cake'

#alias c3cache='bin/cake orm_cache clear'
#alias c3migrate='bin/cake migrations migrate'
