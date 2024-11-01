if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status is-login
    set PATH ~/.local/bin $PATH
end

set -g fish_greeting

set -x PYTHONSTARTUP ~/.pystart

# Dev commands
alias terminal="cd $HOME/Documents/cpp/terminal && source toolchain/toolchain-i686.sh && source tools/run-qemu-x86-default-vars.sh"
alias fatboy="cd $HOME/Documents/linux/fatboy-6.6.4 && linuxtoolchain"
alias linuxtoolchain="export CC=clang && export HOSTCC=clang && export LLVM=1 && export KCONFIG_CONFIG=config.fatboy"
alias vstack="cd $HOME/Documents/js/vspot_stack && ss start docker && doas docker compose -f docker-compose-dev.yml up"
alias vback="cd $HOME/Documents/js/vspot_backend && source .env.dev && yarn run dev"
alias vfront="cd $HOME/Documents/js/vspot_frontend && yarn run dev"

# Git shortcuts
alias ga="git add"
alias gap="git add --patch"
alias gs="git status"
alias gl="git log"
alias gc="git commit"
alias gp="git push"
alias gd="git diff"
alias gpl="git pull"
alias gittok="doas cat ~/Documents/txt/tok"

# Shorts / aliases
alias sudo="doas"
alias ss="doas systemctl"
alias rgrep="grep -r"
alias py="python"
alias pcf="ping 1.1.1.1"
alias pdns="ping archlinux.org"
alias l="ls -l"

# conda is started on demand because starting it for every shell session is slow as hell
alias conda-start='eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source'

# Only works in bash, can't be fucked to patch it for fish, here for reference
#alias gcloud-start="source /etc/profile.d/google-cloud-cli.sh"

alias td="gpg $HOME/Downloads/t.tar.gz.gpg && tar -xvf $HOME/Downloads/t.tar.gz -C $HOME/Downloads"
alias te="tar czvf $HOME/Downloads/t.tar.gz -C $HOME/Downloads t && gpg -c -o $HOME/Downloads/t.tar.gz.gpg $HOME/Downloads/t.tar.gz && rm -rf $HOME/Downloads/t $HOME/Downloads/t.tar.gz"

# System
set EDITOR nvim

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniconda3/bin/conda
	#eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

