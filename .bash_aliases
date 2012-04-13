alias ll='ls -l --group-directories-first'
alias la='ls -A --group-directories-first'
alias l='ls -CF --group-directories-first'
alias lla='ls -lA --group-directories-first'

# colorful ls/dir/grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias zgrep='zgrep --color=auto'
fi

alias ack='ack-grep'
alias go='gnome-open'
alias df='df -T'
alias ymd='date +%Y%m%d'

alias k9='sudo killall -9'
alias k15='sudo killall -15'

alias wi='whois -H'

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --stat'
alias gdc='git diff --cached'
alias gg='git grep'
alias ggi='git grep -i'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'

# Something for work. Ignore these.
alias rtpal='cd ~/codebase/pycloud/milo/apps/rtpal/clients/'
alias varex='cd ~/codebase/pycloud/milo/apps/variations/sites/'
alias sinfo='cd ~/codebase/pycloud/milo/apps/storeinfo/clients'
alias pyc='cd ~/codebase/pycloud/'
alias plu='cd ~/codebase/pluto/'
alias reloadtestdb='sh ~/codebase/pycloud/apps/maint/bin/reload_test_db.sh'
