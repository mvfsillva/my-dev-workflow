export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

eval "$(starship init zsh)"

plugins=(
  asdf
  colored-man-pages
  extract
  fast-syntax-highlighting
  macos
  zsh-autosuggestions
  zsh-completions
  git
)

plugins=(git)

source ~/fzf-git.sh/fzf-git.sh
source $ZSH/oh-my-zsh.sh

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}


show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Shortcuts
alias dw="cd ~/Downloads"
alias dev="cd ~/Developer"
alias g="git"
alias h="history"
alias npr="npm run"

alias sqlinit="mysql.server start"
alias sqlstop="mysql.server stop"

alias npmandroid="npm run android"
alias npmios="npm run ios"
alias nexpo="npx expo"
alias exponew="npx create-expo-app"

# NeoVim
alias nv="nvim"
alias nvz="nvim ~/.zshrc"
alias nvc="nvim ~/.config/nvim/"
alias nvt="nvim ~/.tmux.conf"

# Tmux
alias t="tmux"
alias tk="tmux kill-session -t"
alias tka="tmux kill-server"
alias tn="tmux new-session -s"
alias tl="tmux ls"
alias ta="tmux attach -t"

# Postgres
alias ps="brew services start postgresql"
alias pp="brew services stop postgresql"
alias pr="brew services restart postgresql"

# Special alias
alias ls="eza --icons=always"
alias cd="z"
alias cat="bat"

PATH=~/.console-ninja/.bin:$PATH

eval "$(starship init zsh)"
eval "$(fzf --zsh)"

export BAT_THEME="Catppuccin Mocha"

# The Fuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Zoxide (better cd)
eval "$(zoxide init zsh)"

export PATH="/usr/local/opt/postgresql@16/bin:$PATH"


# bun completions
[ -s "/Users/mvfsilva/.bun/_bun" ] && source "/Users/mvfsilva/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
