# By Nick DeCapua, for use in Lens environments 
# Based on gnzh theme

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (could use normal escape sequences too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$fg[${(L)color}]%}'
done
eval PR_NO_COLOR="%{$terminfo[sgr0]%}"
eval PR_BOLD="%{$terminfo[bold]%}"

eval PR_COLOR1='${PR_CYAN}'
eval PR_COLOR2='${PR_BLUE}'
eval PR_COLOR3='${PR_BOLD}'
eval PR_COLOR4='${PR_YELLOW}'

# Set user 
if [[ $UID -ne 0 ]]; then # normal user
  eval PR_USER='${PR_COLOR1}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_COLOR1}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_NO_COLOR➤ $PR_NO_COLOR'
else # root
  eval PR_USER='${PR_WHITE}%n${PR_NO_COLOR}'
  eval PR_USER_OP='${PR_WHITE}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_WHITE➤ $PR_NO_COLOR'
fi

# Set host
eval PR_HOST='${PR_COLOR2}%m${PR_NO_COLOR}'

# Virtual ENV
if [[ -n ${VIRTUAL_ENV} ]]; then
    local virtual_env='${PR_COLOR4}${VIRTUAL_ENV##*/}${PR_NO_COLOR%}'
fi

# Local definitions
local return_code="%(?..%{$PR_RED%}%? ↵%{$PR_NO_COLOR%})"
local user_host='${PR_USER}${PR_COLOR4}@${PR_NO_COLOR}${PR_HOST}'
local current_dir='%{$PR_COLOR3%}%~%{$PR_NO_COLOR%}'
local git_branch='$(git_prompt_status) $(git_prompt_info)%i${PR_NO_COLOR%}' # Unused, too slow
local vi_mode='${PR_COLOR4}<<<${PR_NO_COLOR}'
local virtual_env='${PR_COLOR4}${VIRTUAL_ENV##*/}${PR_NO_COLOR%}'

# Prompt!
PROMPT="╭─${user_host} ${current_dir} ${virtual_env}
╰─$PR_PROMPT"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$PR_COLOR4%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$PR_NO_COLOR%}"

# Rprompt, vi-mode status and return code
precmd() {
  RPROMPT="${return_code}"
}
zle-keymap-select() {
  RPROMPT="${return_code}"
  [[ $KEYMAP = vicmd ]] && RPROMPT="${vi_mode} ${return_code}"
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init
