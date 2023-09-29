fortune

# set -o vi
stty -ixon
bind -f ~/.inputrc

export EDITOR=/usr/local/bin/vim

export HISTIGNORE='pwd:exit:fg:bg:top:clear:history:ls:ll:uptime:df'
export HISTCONTROL=ignoredups

shopt -s histappend
export HISTSIZE=10000

shopt -s autocd
shopt -s direxpand
shopt -s extglob
# shopt -s nullglob

alias b='bat'
alias bm='bat Makefile'
# bt: bat latest
alias c='cat'
alias cm='cat Makefile'
alias cdt='cd `ll |grep ^d |ff NF |tail -1`'
alias cdt='cd `ll |grep ^d |ff NF |fzf`'
alias cdt='cd `command ls -tl |grep ^d |ff NF |fzf`'
# ct: cat latest
alias cv="networksetup -connectpppoeservice 'NYC VPN'"
alias cx='chmod +x'
alias d='docker'
alias du1='du -hd 1 |sort -hr'
alias dv="networksetup -disconnectpppoeservice 'NYC VPN'"
alias fe1='v `ls -tr |tail -7 |fzf`'
alias g='git'
alias gca='git ci -am'
alias glo='g lo'
alias gst='git st'
alias h='head'
alias lc='wc -l'
alias ll="ls -lhtr"
alias l=lt
alias ls="ls -G"
alias lll='ls -1tr'
alias m=make
alias n=notes
alias nct='zgrep -c f_m_ct'
alias n2b='mv `find  ~/notes/ -type f -name '*.md' |fzf` `gita ls blog`/_drafts/'
alias nv=nvim
#alias pp='pwd | tr -d "\n" | pbcopy'  # merged into rr
alias p=pwd
alias q='jobs'
alias r='greadlink -f'
alias rmf="fzf | xargs -I '{}' rm {}"
# rr: copy path / field
alias s='ssh'
# ss: sum field
alias sb='. ~/.bashrc'
# alias stack=/Users/dzhou/.local/bin/stack
alias t='touch'
alias tf='tail -f `ls -1t| fzf`'
alias touch=gtouch
# tt: copy field of last row
alias v="/usr/local/bin/vim"
alias vb='v ~/.bashrc'
alias vg='v ~/.gitconfig'
alias vlog='v -p *.log'
alias vm='v Makefile'
alias vmsj='vp *msj'
alias vn='n ls |fzf | n o'
alias vd='v -d'
alias vo='v -O'
alias vp='v -p'
alias vv='v ~/.vimrc'

alias cpumetrics='sudo powermetrics --samplers smc -i1 -n1'

alias gita="python3 -m gita"

alias gap='~/Downloads/gap-4.11.1/bin/gap.sh'

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/Applications/Postgres.app/Contents/Versions/13/bin/:$HOME/.local/bin
export PATH=$PATH:$HOME/bin
export PYFLYBY_PATH=-:$HOME/.pyflyby/
export CSP=/Users/dzhou/src/mega-csp/csp/bin
export CSP2=/Users/dzhou/src/mega-csp/2nd-wtree/bin
export CSP3=/Users/dzhou/src/mega-csp/3rd-wtree/bin
export CSP4=/Users/dzhou/src/mega-csp/4th-wt/bin/
export CSP5=/Users/dzhou/src/mega-csp/5th-wtree/bin

export SCHRODINGER=/opt/schrodinger/suites2023-3/
export SCHRODINGER_SRC=$HOME/src/sdg/
export SCHRODINGER_LIB=$HOME/lib
export S=$SCHRODINGER
export SS=/opt/schrodinger/23-4/
alias sr=$S/run
alias sj=$S/jsc
alias spy='$S/run py'
alias fuzzy="$S/run python3 -m schrodinger.application.scisol.packages.fep.fuzzy"
alias fuzzy2="$SS/run python3 -m schrodinger.application.scisol.packages.fep.fuzzy"
alias bdg=$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

function mmv(){
  cat $SCHRODINGER_SRC/mmshare/version.h | grep "#define MMSHARE_VERSION" | awk '{ printf("Next master build -> %03d. Full id -> %d\n", $3%1000+1, $3+1)}'
}

function dc(){
  date -ju -f "%s" $1 "+%Hh%Mm%Ss" | sed 's/^[^1-9]*//'
}

# Enable tab completion
source ~/.git-completion.bash
source ~/.gita-completion.bash
source ~/.srun_completion.bash
source ~/.jsc_completion.bash


[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# colors!
red="\[\033[01;31m\]"
green="\[\033[0;32m\]"
yellow="\[\033[0;33m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$yellow\A$green\$(__git_ps1)$blue \W $ $reset"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --multi --info=inline'
#export FZF_DEFAULT_COMMAND='find --type f --exclude .git --follow'
export FZF_DEFAULT_COMMAND='rg --files'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} -O "${files[@]}" -p
}

# zd - cd to selected directory
zd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# eval "$(zoxide init bash)"
source ~/.vim/z.sh
unalias z 2> /dev/null
z() {
   [ $# -gt 0 ] && _z "$*" && return
   cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}



# complete make targets
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

[ -f "/Users/dzhou/.ghcup/env" ] && source "/Users/dzhou/.ghcup/env" # ghcup-env

# if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#   __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
#   GIT_PROMPT_ONLY_IN_REPO=1
#   source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
# fi
