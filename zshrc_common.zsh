
alias gadd="git add ."
alias gpus="git push origin"
alias gpul="git pull origin"
alias gs="git status"
alias ll='ls -al'
alias make="make -r"

alias jn="jupyter notebook"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

export CLICOLOR=1

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

disable r

#echo "hello.\nI’m zsh. It sure is great to appear on termial. Unaccustomed as I am to public speaking, I’d like to share with you a maxim I thought of the first time I met 'cmd.exe': NEVER TRUST A SHELL YOU CAN’T CUSTOMIZE FREE."

autoload -Uz compinit && compinit  # Gitの補完を有効化

#PROMPT='%F{blue}%n%#%f:%F{cyan}%~%f
#%F{green}→ %f '

function left-prompt() {
  hosti_b="${HOSTCOLOR}m%}"
  name_t='41;44;52m%}'      # user name text clolr
  name_b='208;208;208m%}'    # user name background color
  time_t='127;156;254m%}'  # time text color
  hostname_t='177;184;197m%}'  # host name text color
  hostname_b='59;64;72m%}'   # host name background color
  path_t='255;255;255m%}'     # path text clolr
  path_b='97;175;239m%}'   # path background color
  arrow='99;248;248m%}'   # arrow color
  text_color='%{\e[38;2;'    # set text color
  back_color='%{\e[30;48;2;' # set background color
  reset='%{\e[0m%}'   # reset
  sharp='\uE0B0'      # triangle
  
  time="${text_color}${time_t}"
  user="${back_color}${name_b}${text_color}${name_t}"
  host="${back_color}${hostname_b}${text_color}${hostname_t}"
  dir="${back_color}${path_b}${text_color}${path_t}"
  hosti="${back_color}${hosti_b} ${reset}${back_color}${name_b}${text_color}${hosti_b}${sharp}${reset}"
  echo "${time}[%*]${reset}\n${hosti}${user} @%m ${back_color}${hostname_b}${text_color}${name_b}${sharp} ${host}%n ${back_color}${path_b}${text_color}${hostname_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}%I→ ${reset}"
}

PROMPT=`left-prompt`

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status
  #  文字色を設定
  branch='\ue0a0'
  triangle='\ue0b2'
  fgcolor='%{\e[38;2;' 
  bgcolor='%{\e[48;2;' 
  green='7;134;0m%}'
  red='255;30;14m%}'
  yellow='253;255;19m%}'
  blue='6;20;255m%}'
  reset='%{\e[0m%}'   # reset

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [ -z $branch_name ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="${fgcolor}${green}${triangle}${reset}${bgcolor}${green} ${branch}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="${fgcolor}${red}${triangle}${reset}${bgcolor}${red} ${branch}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="${fgcolor}${red}${triangle}${reset}${bgcolor}${red} ${branch}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="${fgcolor}${yellow}${triangle}${reset}${bgcolor}${yellow} ${branch}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "${fgcolor}${red}${triangle}${reset}${bgcolor}${red} ${branch}!(no branch)${reset}"
    return
  else
    # 上記以外の状態の場合
    branch_status="${fgcolor}${blue}${triangle}${reset}${bgcolor}${blue} ${branch}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}$branch_name ${reset}"
}
 
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

# コマンドの実行ごとに改行
function precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ "`echo $PROMPT | grep ")"`" ]; then
    prompt=$PROMPT
    env=${prompt%%)*}
    name="${env})"
    PROMPT=`left-prompt ${name}`; fi

    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}

function source() {
    file_name=$(basename $1)
    #echo "source file name = $file_name"
    if [[ $file_name == (.zsh_history|.bash_history) ]]; then
        #echo "histry"
        echo "[source] It's so dangerous to load histry file with source command."
    else
        #echo "not histry"
        builtin source $1
    fi
}
