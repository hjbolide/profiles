# {{{ color
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval $color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done
FINISH="%{$terminfo[sgr0]%}"
#}}}

local count_db_wth_char=${#${${(%):-%/}//[[:ascii:]]/}}
local leftsize=${#${(%):-%~ %/}}+$count_db_wth_char
local rightsize=${#${(%):-%D %T }}
HBAR=" -"

FILLBAR="\${(l.(($COLUMNS - ($leftsize + $rightsize +2)))..${HBAR}.)}"

RPROMPT=$(echo "%(?..$RED%?$FINISH)")
PROMPT=$(echo "$BLUE%M $GREEN%~ $WHITE${(e)FILLBAR} $MAGENTA%D %T$FINISH
$CYAN%n $_YELLOW>>>$FINISH ")

#chpwd{{{
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
      sun-cmd) print -Pn "\e]l%~\e\\"
        ;;
      *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
        ;;
    esac
  }
#}}}

#标题栏、任务栏样式{{{
case $TERM in (*xterm*|*rxvt*|(dt|k|E)term)
   preexec () { print -Pn "\e]0;%n@%M//%/\ $1\a" }
   ;;
esac
#}}}

#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#历史纪录文件
#export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS      
#为历史纪录中的命令添加时间戳      
setopt EXTENDED_HISTORY      

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格，不将此命令添加到纪录文件中
#setopt HIST_IGNORE_SPACE      
#}}}

#每个目录使用独立的历史纪录{{{
HISTDIR="$HOME/.zhistory"
    [[ ! -d "$HISTDIR" ]] && mkdir -p "$HISTDIR"
#HISTFILE="$HISTDIR/${PWD//\//:}"
#chpwd() {
#   fc -W                                       # write current history  file
#   "setopt INC_APPEND_HISTORY"
#    HISTFILE="$HISTDIR/${PWD//\//:}"            # set new history file
#    [[ ! -e "$HISTFILE" ]] && touch $HISTFILE
#    local ohistsize=$HISTSIZE
#        HISTSIZE=0                              # Discard previous dir's history
#        HISTSIZE=$ohistsize                     # Prepare for new dir's history
#    fc -R                                       # read from current histfile
#}

#function allhistory { cat $HISTDIR/* }                                   #*/
#function convhistory {
#            sort $1 | sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |
#            awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'  
#}
#使用 histall 命令查看全部历史纪录
# function histall { convhistory =(allhistory) |
#           sed '/^.\{20\} *cd/i\\' }
#使用 hist 查看当前目录历史纪录
# function hist { convhistory $HISTFILE }

#杂项 {{{
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      

#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
#setopt AUTO_CD
      
#扩展路径
setopt complete_in_word

#禁用 core dumps
limit coredumpsize 0

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
#}}}

#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE

autoload -U compinit
compinit

#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

#彩色补全菜单 
# eval $(dircolors -b) 
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正      
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全      
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组 
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
#}}}

##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域 
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字
#}}}

#空行(光标在行首)补全 "cd " {{{
user-complete(){
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd  " )                   # TAB + 空格 替换为 "cd ~"
            BUFFER="cd ~"
            zle end-of-line
            zle expand-or-complete
            ;;
        " " )
            BUFFER="!?"
            zle end-of-line
            ;;
        "cd --" )                  # "cd --" 替换为 "cd +"
            BUFFER="cd +"
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
            BUFFER="cd -"
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete

#显示 path-directories ，避免候选项唯一时直接选中
cdpath=$HOME
#}}}

#命令别名 {{{
alias -g cp='cp -i'
alias -g mv='mv -i'
alias -g rm='rm -i'
alias -g ls='ls -F --color=auto'
alias -g la='ls -a'
alias -g l='ls'
alias -g ll='ls -l'
alias -g grep='grep --color=auto'
alias -g egrep='egrep --color'
alias -g history='history -fi'
alias -g nano='nano -w'


#[Esc][h] man 当前命令时，显示简短说明 
alias run-help >&/dev/null && unalias run-help
autoload run-help

#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
# hash -d winc="/mnt/winc"
# hash -d wind="/mnt/wind"
# hash -d wine="/mnt/wine"
#}}}
    
#{{{自定义补全
#补全 ping
zstyle ':completion:*:ping:*' hosts 192.168.128.1{38,} http://www.g.cn \
       192.168.{1,0}.1{{7..9},}

#}}}

#{{{ F1 计算器
arith-eval-echo() {
  LBUFFER="${LBUFFER}echo \$(( "
  RBUFFER=" ))$RBUFFER"
}
zle -N arith-eval-echo
bindkey "^[[11~" arith-eval-echo
#}}}

####{{{
function timeconv { date -d @$1 +"%Y-%m-%d %T" }

# }}}

##{{{ Function Defs
gitup () {
    echo "Running git fetch"
    git fetch
    DIRTY=$([[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo true)
    if [ "$DIRTY" = true ]; then
        echo $fg_bold[red] Local is dirty
        return -1
    fi
    for file in `git status --porcelain 2>/dev/null | awk '{print $1"|"$2;}'`; do
        if ! echo $file | grep "^??" > /dev/null 2>&1; then
            echo $fg_bold[green] New change: `echo $file | sed -e 's;^[^|][^|]*|\(.*\);\1;'`
            DIRTY=true; continue
          elif ! echo $file | egrep "(var/)|(TAGS)|(\.tern-project)|(.*?test\.sh)|(.*?nose-ch\.cfg)|(\.projectile)|(\.tern-port)" > /dev/null 2>&1; then
            echo $fg_bold[red] Untracked change: `echo $file | sed -e 's;^[^|][^|]*|\(.*\);\1;'`
            DIRTY=true; break
        fi
        echo $fg[cyan] Ignored change: `echo $file | sed -e 's;^[^|][^|]*|\(.*\);\1;'`
    done

    if [ "$DIRTY" = true ]; then
        echo
        echo $fg_bold[red] Local is dirty
        return -1
    fi

    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    BASE=$(git merge-base @ @{u})

    if [ $LOCAL = $REMOTE ]; then
        echo $fg_bold[green] Local is up-to-date
    elif [ $LOCAL = $BASE ]; then
        echo $fg_bold[yellow] Need to run a pull
        git pull -r
        echo
        need_to_make=0
        for file in `git log -p --reverse --no-merges --stat --name-status @{1}.. | cat | egrep '^(A|M|D)\s+.+$' | awk '{print $1 "-|-" $2;}'`; do
            if [[ $file =~ '^ *A' ]]; then
                printf $fg_bold[cyan]
            elif [[ $file =~ '^ *M' ]]; then
                printf $fg_bold[yellow]
            elif [[ $file =~ '^ *D' ]]; then
                printf $fg_bold[grey]
            fi

            if [[ $file =~ '(idl|xml)' ]]; then
                need_to_make=1;
            fi
            echo $file
        done
        echo

        if [ $need_to_make -eq 1 ]; then
            echo $fg_bold[red] Need to run a make
        else
            echo $fg_bold[green] Restart the site
        fi
    elif [ $REMOTE = $BASE ]; then
        echo $fg_bold[red] Local is dirty
    else
        echo $bg[red] $fg[white] Divergent!
    fi
}
#}}}

# others
if [[ -d $HOME/.zsh ]]; then
    for file in $HOME/.zsh/*; do
        source $file
    done
fi


eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export JAVA_HOME=$HOME/dev/amazon-corretto-11.jdk/Contents/Home
export PATH=$PATH:$HOME/dev:$JAVA_HOME/bin

## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
