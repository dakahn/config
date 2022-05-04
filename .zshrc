#####################################################
# Setup 
#####################################################
TERM=screen-256color
DISABLE_AUTO_TITLE="true"
fpath=($fpath "/home/dak/.zfunctions")
setopt autocd
# Fnm
export PATH=/home/dakahn/.fnm:$PATH
eval "`fnm env`"
# Clipboard config 
yanktoclipboard(){
      echo $BUFFER | xsel -i -b
      
}
pastefromclipboard(){
      RBUFFER=$(xsel -o -b </dev/null)$RBUFFER
      
}
zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard
eval "$(starship init zsh)"
export EDITOR="/usr/bin/nvim"

function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
#####################################################
# System aliases 
#####################################################
alias ..='cd ..'
alias n='nnn -d -e -H -r'
alias ls='n'
alias ...='cd .. && cd ..'
alias code='cd ~/Code'
alias v='nvim'
alias vcfg='nvim ~/.config/nvim/init.lua'
alias zcfg='nvim ~/.zshrc'
alias zsrc='source ~/.zshrc'
alias caa='
  config add ~/.config/nvim/init.lua \
  ~/.config/nvim/lua/lsp.lua \
  ~/.config/nvim/lua/keymap.lua \
  ~/.config/nvim/lua/plugins.lua \
  ~/.config/nvim/lua/settings.lua \
  ~/.config/nvim/lua/statusline.lua \
  ~/.taskrc \
  ~/.tmux.conf.local \
  ~/.alacritty.yml \
  ~/.zshrc \
  && config commit \
  && config push \
'
alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'

#####################################################
# Git
#####################################################
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
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
alias ggpush='git push origin $(current_branch)'
alias glum='git pull upstream main'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gsta='git stash push'
alias gstp='git stash pop'
alias ggclean='gco -- .'


#####################################################
# Carbon aliases 
#####################################################
alias carb='cd ~/Code/carbon'
alias carbr='cd ~/Code/carbon/packages/react'
alias carbs='cd ~/Code/carbon-website'
alias runcarb='cd ~/Code/carbon/packages/react && yarn run storybook'
alias runtests='yarn test --changedSince=master'
alias format='npx prettier --write .'
# Raises the limit to 10000 open files for the current session and reloads the shell
alias prebuild='sudo prlimit -p "$$" --nofile=10000:10000 && exec zsh'
alias bigdev='NODE_OPTIONS=--max_old_space_size=8192 yarn dev'

task ls
