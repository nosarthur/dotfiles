export PATH=/opt/homebrew/bin/:$PATH:$HOME/bin

fortune

# set -o vi
stty -ixon
bind -f ~/.inputrc

export EDITOR=/opt/homebrew/bin/nvim
export EDITOR=vim

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
alias ca='conda activate ama-dev'
alias caa='conda activate atommap-dev'
alias cab='conda activate'
alias cad='conda deactivate'
alias cs='conda activate siflow-dev'
alias cdt='cd `ll |grep ^d |ff NF |fzf`'
alias cdt='cd `command ls -tl |grep ^d |ff NF |fzf`'
# ct: cat latest
alias ct='cat `ls -tp | grep -v / | head -15 |fzf`'
alias ctags="`brew --prefix`/bin/ctags"
alias cv="networksetup -connectpppoeservice 'NYC VPN'"
alias cx='chmod +x'
alias d='docker'
alias du1='du -hd 1 |sort -hr'
alias dv="networksetup -disconnectpppoeservice 'NYC VPN'"
alias e=exit
alias fe1='v `ls -tr |tail -7 |fzf`'
alias g='git'
alias gca='git ci -am'
alias glo='g lo'
alias gst='git st'
alias h='head'
alias i=vifm
alias ic='imgcat -H 50%'
alias lc='wc -l'
alias ll="ls -lhtr"
alias l=lt
alias ls="ls -G"
alias lll='ls -1tr'
alias m=make
alias mall='make all'
alias n=notes
alias nct='zgrep -c f_m_ct'
alias n2b='mv `find  ~/notes/ -type f -name '*.md' |fzf` `gita ls blog`/_drafts/'
alias nv=nvim
#alias pp='pwd | tr -d "\n" | pbcopy'  # merged into rr
alias p=pwd
alias q='jobs'
alias r='greadlink -f'
alias rmf="fzf | xargs -I '{}' rm {}"
alias rrt="ls -t |fzf|xargs greadlink -f | tr -d '\n'|pbcopy"
# rr: copy path / field
alias s='ssh'
# ss: sum field
alias sb='. ~/.bashrc'
alias t='touch'
alias t=tmux
alias tf='tail -f `ls -1t| fzf`'
alias touch=gtouch
# tt: copy field of last row
alias v=/opt/homebrew/bin/vim
alias v=nv
alias v=vim
alias vb='v ~/.bashrc'
alias vg='v ~/.gitconfig'
alias vlog='v -p *.log'
alias vm='v Makefile'
alias vmsj='vp -p *msj'
alias vn='n ls |fzf | n o'
alias vd='v -d'
alias vo='v -O'
alias vp='v -p'
alias vv='v ~/.vimrc'

alias cpumetrics='sudo powermetrics --samplers smc -i1 -n1'

alias gita="python3 -m gita"

alias gap='~/Downloads/gap-4.11.1/bin/gap.sh'

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/Applications/Postgres.app/Contents/Versions/13/bin/:$HOME/.local/bin:/Users/nos/Library/Python/3.9/bin
export PYFLYBY_PATH=-:$HOME/.pyflyby/

export SCHRODINGER=/opt/schrodinger/suites2024-1/
export SCHRODINGER_SRC=$HOME/src/sdg/
export SCHRODINGER_LIB=$HOME/lib
export S=$SCHRODINGER
export SS=/opt/schrodinger/24-2/
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
source ~/.tmux-completion.bash


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
#
take () {
    mkdir -p "$1" && cd "$1"
}

source /Users/nos/.iterm2_shell_integration.bash
export BAT_THEME='Solarized (light)'

# eval "$(register-python-argcomplete conda)"

