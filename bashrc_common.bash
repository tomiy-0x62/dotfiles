
alias gadd="git add ."
alias gpus="git push origin"
alias gpul="git pull origin"
alias gs="git status"
alias ll='ls -al'
alias make="make -r"

alias jn="jupyter notebook"

alias ls="ls -G"

export LANG=en_US.UTF-8

#printf "hello.\nI’m bash. It sure is great to appear on termial. Unaccustomed as I am to public speaking, I’d like to share with you a maxim I thought of the first time I met 'cmd.exe': NEVER TRUST A SHELL YOU CAN’T CUSTOMIZE FREE.\n"

function ssh_state() {
    if [ -n "$SSH_CLIENT" ] ; then
        echo -e '\e[38;2;255;81;125m [ssh]\e[0m\e[48;5;237m \uE0B1'
    fi
}

# export PS1=`echo -e '\[\e[38;5;215m\]\u@\h\$\[\e[0m\]:\[\e[38;5;075m\]\w\[\e[0m\]$(__git_ps1 ":\[\e[38;5;114m\]\ue0a0 %s")\[\033[00m\] \n\[\e[38;5;087m\]\$\[\e[0m\] '`
export PS1=`echo -e '\e[38;2;127;156;254m[\T]\n\[\e[48;5;237m\]$(ssh_state)\[\e[38;2;${HOSTCOLOR}m\] @\h \[\033[00m\]\[\e[48;5;237m\]\uE0B1 \[\e[38;5;202m\]\u\[\e[0m\]\[\e[48;5;237m\] \uE0B1 \[\e[38;5;039m\]\w\[\e[0m\]$(__git_ps1 "\[\e[48;5;237m\] \uE0B1 \[\e[38;5;114m\]\ue0a0 %s")\[\033[00m\]\[\e[48;5;237m\] \[\033[00m\]\[\e[38;5;237m\]\uE0B0\[\033[00m\]\n\[\e[38;2;155;225;223m\]\$\[\e[0m\] '`
GIT_PS1_SHOWDIRTYSTATE=true
# デバッグ用
# bash -x hoge.sh でデバッグ用の出力
export PS4='+ (${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

# 出力の後に改行を入れる
function add_line { 
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}

PROMPT_COMMAND='add_line'

function source() {
    file_name=$(basename $1)
    #echo "source file name = $file_name"
    if [[ $file_name =~ .bash_history|.zsh_history ]]; then
        #echo "histry"
        echo "[source] It's so dangerous to load histry file with source command."
    else
        #echo "not histry"
        command source $1
    fi
}

