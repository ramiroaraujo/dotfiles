# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

function gpb () {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    git checkout master
    git merge ${branch} --no-ff --no-edit
    git push
    git checkout ${branch}
}

function ginit () {
  if [ $1 ]; then
      title=$1
  else
      pwd=$(pwd)
      title=$(basename "$pwd")
  fi
  git init
  gtm init
  echo "# $title" > README.md
  git add .
  git commit -m 'init'
}

function git {
   local tmp=$(mktemp -t git)
   local repo_name

   if [ "$1" = clone ] ; then
     command git "$@" --progress 2>&1 | tee $tmp
     repo_name=$(awk -F\' '/Cloning into/ {print $2}' $tmp)
     rm -f $tmp
     printf "changing to directory %s\n" "$repo_name"
     cd "$repo_name"
     command gtm init
   else
     command git "$@"
   fi
}

function msdg-ssh {

    env="$1"

    if [ $env != dev ] && [ $env != live ] ; then
        echo "select dev or live"
        return 0
    fi

    env="$1"

    readme=$(cat $(git rev-parse --show-toplevel 2> /dev/null)/README.md 2> /dev/null)
    if [ $readme == "" ]; then
        echo "not a proper msdg git repo"
        return 0
    fi

    host=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?host: (.+?)\n/si;')
    user=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    pass=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?password: (.+?)\n/si;')

    print -z 'sshpass -p "'$pass'" ssh '$user@$host
}

function msdg-mysql {

    env="$1"

    readme=$(cat $(git rev-parse --show-toplevel 2> /dev/null)/README.md 2> /dev/null)

    host=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?host: (.+?)\n/si;')
    user=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    pass=$(echo $readme | perl -0ne 'print $1 if /Servers.+?\#\#\# '$env'.+?password: (.+?)\n/si;')

    ddbb_user=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?user: (.+?)\n/si;')
    ddbb_pass=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?password: (.+?)\n/si;')
    ddbb_name=$(echo $readme | perl -0ne 'print $1 if /Databases.+?\#\#\# '$env'.+?database: (.+?)\n/si;')

    port=$(gshuf -i 3400-4000 -n 1)

    print -z 'sshpass -p "'$pass'" ssh '$user@$host \''mysql -u'$ddbb_user' -p'"$ddbb_pass" $ddbb_name\'
}



export GTM_STATUS=""
export GTM_NEXT_UPDATE=0
export GTM_LAST_DIR="$(PWD)"

function gtm_record_terminal() {
  let epoch=$((`date +%s`))
  if [[ "${GTM_LAST_DIR}" != "${PWD}" ]] || [[ $epoch -ge $GTM_NEXT_UPDATE ]]; then
    export GTM_NEXT_UPDATE=$(( $epoch + 30 ))
    export GTM_LAST_DIR="${PWD}"
    if ! GTM_STATUS=$(gtm record -terminal -status) ; then
      echo "Error running 'gtm record -terminal', you may need to install gtm or upgrade to the latest"
      echo "See http://www.github.com/git-time-metric/gtm for how to install"
    fi
  fi
}

if [[ -n "$ZSH_VERSION" ]]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd gtm_record_terminal
elif [[ -n "$BASH_VERSION" ]]; then
  PROMPT_COMMAND="gtm_record_terminal; $PROMPT_COMMAND"
else
  echo "Unknown shell not supported for GTM plugin"
fi
