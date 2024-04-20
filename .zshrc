source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(starship init zsh)"
setopt autocd

## aliases
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias la='ls -la'
alias code='cd ~/code'
alias v='nvim'
alias vf='nvim $(fzf)'
alias vcfg='v ~/.config/nvim/init.lua'
alias zcfg='v ~/.zshrc'
alias zsrc='source ~/.zshrc'
## https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias nuke='echo 💣 NUKING LOCAL DEPENDENCIES 💣 && yarn cache clean && rm -rf node_modules && yarn install --check-files'
alias ggconfig='
  config add ~/.config/nvim/init.lua \
  ~/.taskrc \
  ~/.tmux.conf.local \
  ~/.zshrc \
  && config commit \
  && config push origin wsl\
'
## git
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gsc='git switch -c'
alias gsm='git switch main'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias ggpull='git pull origin $(current_branch)'
alias gprom='git pull --rebase origin master'
alias ggpush='git push --set-upstream origin $(current_branch)'
alias glum='git pull upstream main'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gsta='git stash push'
alias gstp='git stash pop'
alias ggclean='gco -- .'
alias gbd='git branch | grep -v "master\|main" | xargs git branch -D'

export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
