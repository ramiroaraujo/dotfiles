# Aliases in this file are bash and zsh compatible

# Don't change. The following determines where YADR is installed.
yadr=$HOME/.yadr

# Get operating system
platform='unknown'
unamestr=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

# git up
git config --global alias.up 'pull --rebase --autostash'

# YADR support
alias yav='yadr vim-add-plugin'
alias ydv='yadr vim-delete-plugin'
alias ylv='yadr vim-list-plugin'
alias yup='yadr update-plugins'
alias yip='yadr init-plugins'

# PS
alias psa="ps aux"
alias psg="ps aux | grep "

# Moving around
alias cdb='cd -'
alias cls='clear;ls'

# Show human friendly numbers and colors
alias df='df -h'
alias du='du -h -d 2'

if [[ $platform == 'linux' ]]; then
  alias ll='ls -alh --color=auto'
  alias ls='ls --color=auto'
elif [[ $platform == 'darwin' ]]; then
  alias ll='ls -alGh'
  alias ls='ls -Gh'
fi

# show me files matching "ls grep"
alias lsg='ll | ag'

# Alias Editing
alias ae='vim $yadr/zsh/aliases.zsh' #alias edit
alias ar='source $yadr/zsh/aliases.zsh'  #alias reload

# vim using
mvim --version > /dev/null 2>&1
MACVIM_INSTALLED=$?
if [ $MACVIM_INSTALLED -eq 0 ]; then
  alias vim="mvim -v"
fi

# mimic vim functions
alias :q='exit'

# vimrc editing
alias ve='vim ~/.vimrc'

# zsh profile editing
alias ze='vim ~/.zshrc'

# Git Aliases
alias cdr='cd $(git rev-parse --show-cdup)'
alias gs='git status'
alias gts='gtm status'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias gi='vim .gitignore'
alias gcm='git ci -m'
alias gci='git ci'
alias gco='git co'
alias gcp='git cp'
alias ga='git add -A'
alias gt='git tag'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gmm='git merge --no-edit'
alias gmne='git merge --no-edit --no-ff'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gl='git l'
alias gf='git fetch'
alias gd='git diff'
alias gd1='git diff HEAD~1..HEAD'
alias gd2='git diff HEAD~2..HEAD'
alias gd3='git diff HEAD~3..HEAD'
alias gb='git b'
alias gbd='git b -D -w'
alias gdc='git diff --cached -w'
alias gpub='grb publish'
alias gtr='grb track'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsh='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias guiu='git update-index --assume-unchanged'
alias guic='git update-index --no-assume-unchanged'
alias guil='git ls-files -v|grep "^h"'
alias gdmb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

# git svn alias
alias gsco='git svn clone --prefix=svn/'
alias gsu='git svn rebase'
alias gsc='git svn dcommit'

# Common shell functions
alias less='less -r'
alias tf='tail -f'
alias l='less'
alias lh='ls -alt | head' # see the last modified files
alias screen='TERM=screen screen'
alias cl='clear'

alias copy="tr -d '\n' | pbcopy"

# tmux
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tk='tmux kill-session -t'
alias tl='tmux list-sessions'
alias td='tmux detach'
alias ms='mux start'

alias terminal-notifier='reattach-to-user-namespace terminal-notifier'

# node and npm shorthands
alias nis='npm install --save'
alias nrs='npm uninstall --save'
alias nisd='npm install --save-dev'
alias nrsd='npm uninstall --save-dev'

# phpstorm
alias pst='pstorm'
alias idiff='/Applications/PhpStorm.app/Contents/MacOS/phpstorm diff'

# Zippin
alias gz='tar -zcvf'

alias ka9='killall -9'
alias k9='kill -9'

# Gem install
alias sgi='sudo gem install --no-ri --no-rdoc'

# TODOS
# This uses NValt (NotationalVelocity alt fork) - http://brettterpstra.com/project/nvalt/
# to find the note called 'todo'
alias todo='open nvalt://find/todo'

# Forward port 80 to 3000
alias portforward='sudo ipfw add 1000 forward 127.0.0.1,3000 ip from any to any 80 in'

alias rdm='rake db:migrate'
alias rdmr='rake db:migrate:redo'

# Homebrew
alias brewu='brew update && brew unlink php53 && brew unlink php54 && brew unlink php55 && brew unlink php56 && brew unlink php70 && brew link php53 && brew upgrade | 2>&1 && brew unlink php53 && brew link php54 && brew upgrade | 2>&1 && brew unlink php54 && brew link php55 && brew upgrade | 2>&1 && brew unlink php55 && brew link php56 && brew upgrade | 2>&1 && brew unlink php56 && brew link php70 && brew upgrade | 2>&1 && brew unlink php70 && brew link php56 && brew cleanup && brew prune && brew doctor'

# yeoman tasks
alias gser='grunt serve'

