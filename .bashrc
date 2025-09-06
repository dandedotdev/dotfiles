# oh-my-posh
eval "$(/opt/homebrew/bin/oh-my-posh init bash --config ~/.poshthemes/montys.omp.json)"

# bash-completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Enable history search
bind '"\e[A": history-search-backward' # ↑ to search backward
bind '"\e[B": history-search-forward' # ↓ to search forward

# Enable autocompletion
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/path.bash.inc' ]; then . '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/completion.bash.inc'; fi

# kubectl aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
. "$HOME/.local/bin/env"

alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'
