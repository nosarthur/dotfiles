set -o vi
bind -f ~/.inputrc

export EDITOR=/usr/bin/vim

export HISTIGNORE='pwd:exit:fg:bg:top:clear:history:ls:ll:uptime:df'
export HISTCONTROL=ignoredups

shopt -s histappend
export HISTSIZE=10000

shopt -s autocd
shopt -s direxpand

alias c='clear'
alias cv="networksetup -connectpppoeservice 'NYC VPN'"
alias cx='chmod +x'
alias d='docker'
alias ff='find . -name'
alias g='git'
alias ll="ls -lhtr"
alias ls="ls -hG"
alias n='notes'
alias pbc='pbcopy'
alias r='greadlink -f'
alias s='ssh'
alias t='taskell'
alias tf='tail -f'
alias v="vim"
alias vb='v ~/.bashrc'
alias vg='v ~/.gitconfig'
alias vn='v ~/notes/$(notes ls | fzf)'
alias vv='v ~/.vimrc'

alias gita="python3 -m gita"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export CDPATH=.:$HOME:$HOME/src

export SCHRODINGER=/opt/schrodinger/suites2021-3
export SCHRODINGER_SRC=$HOME/src
export S=$SCHRODINGER
export SS=/opt/schrodinger/suites2021-2/
alias sr=$S/run
alias sj=$S/jsc
alias fuzzy="$SCHRODINGER/run python3 -m schrodinger.application.scisol.packages.fep.fuzzy"
alias fuzzy2="/opt/schrodinger/21-2/run python3 -m schrodinger.application.scisol.packages.fep.fuzzy"
alias sip='$SCHRODINGER/run python3 -m IPython'
alias sversion="$SCHRODINGER/run python3 -c 'import schrodinger; print(schrodinger.get_mmshare_version())'"
alias bdg=$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh
export SCHRODINGER_LIB=$HOME/lib
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

function mmv(){
  cat $SCHRODINGER_SRC/mmshare/version.h | grep "#define MMSHARE_VERSION" | awk '{ printf("Next master build -> %03d. Full id -> %d\n", $3%1000+1, $3+1)}'
}

# Enable tab completion
source ~/.git-completion.bash
source ~/.gita-completion.bash

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# colors!
red="\[\033[01;31m\]"
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;37m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$red\A \u$green\$(__git_ps1)$blue \W $ $reset"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

source ~/.vim/z.sh
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
