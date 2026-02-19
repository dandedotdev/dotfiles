# lld
export PATH="/opt/homebrew/opt/lld/bin:$PATH"

# llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# mise
eval "$(mise activate bash)"

# oh-my-posh
if command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init bash --config ~/.poshthemes/montys.omp.json)"
fi

# bash-completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Enable history search
bind '"\e[A": history-search-backward' # ↑ to search backward
bind '"\e[B": history-search-forward' # ↓ to search forward

# Enable autocompletion
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'

# just autocompletion
# https://github.com/casey/just?tab=readme-ov-file#shell-completion-scripts
_just() {
    local i cur prev words cword opts cmd
    COMPREPLY=()

    # Modules use "::" as the separator, which is considered a wordbreak character in bash.
    # The _get_comp_words_by_ref function is a hack to allow for exceptions to this rule without
    # modifying the global COMP_WORDBREAKS environment variable.
    if type _get_comp_words_by_ref &>/dev/null; then
        _get_comp_words_by_ref -n : cur prev words cword
    else
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        words=$COMP_WORDS
        cword=$COMP_CWORD
    fi

    cmd=""
    opts=""

    for i in ${words[@]}
    do
        case "${cmd},${i}" in
            ",$1")
                cmd="just"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        just)
            opts="-E -n -g -f -q -u -v -d -c -e -l -s -h -V --alias-style --check --chooser --clear-shell-args --color --command-color --dotenv-filename --dotenv-path --dry-run --dump-format --explain --global-justfile --highlight --justfile --list-heading --list-prefix --list-submodules --no-aliases --no-deps --no-dotenv --no-highlight --one --quiet --allow-missing --set --shell --shell-arg --shell-command --timestamp --timestamp-format --unsorted --unstable --verbose --working-directory --yes --changelog --choose --command --completions --dump --edit --evaluate --fmt --groups --init --list --man --request --show --summary --variables --help --version [ARGUMENTS]..."
                if [[ ${cur} == -* ]] ; then
                    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                    return 0
                elif [[ ${cword} -eq 1 ]]; then
                    local recipes=$(just --summary 2> /dev/null)

                    if echo "${cur}" | \grep -qF '/'; then
                        local path_prefix=$(echo "${cur}" | sed 's/[/][^/]*$/\//')
                        local recipes=$(just --summary 2> /dev/null -- "${path_prefix}")
                        local recipes=$(printf "${path_prefix}%s\t" $recipes)
                    fi

                    if [[ $? -eq 0 ]]; then
                        COMPREPLY=( $(compgen -W "${recipes}" -- "${cur}") )
                        if type __ltrim_colon_completions &>/dev/null; then
                            __ltrim_colon_completions "$cur"
                        fi
                        return 0
                    fi
                fi
            case "${prev}" in
                --alias-style)
                    COMPREPLY=($(compgen -W "left right separate" -- "${cur}"))
                    return 0
                    ;;
                --chooser)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "always auto never" -- "${cur}"))
                    return 0
                    ;;
                --command-color)
                    COMPREPLY=($(compgen -W "black blue cyan green purple red yellow" -- "${cur}"))
                    return 0
                    ;;
                --dotenv-filename)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --dotenv-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -E)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --dump-format)
                    COMPREPLY=($(compgen -W "json just" -- "${cur}"))
                    return 0
                    ;;
                --justfile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --list-heading)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --list-prefix)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --set)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --shell)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --shell-arg)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --timestamp-format)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --working-directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -d)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --command)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --completions)
                    COMPREPLY=($(compgen -W "bash elvish fish nushell powershell zsh" -- "${cur}"))
                    return 0
                    ;;
                --list)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -l)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --request)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --show)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -s)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
    complete -F _just -o nosort -o bashdefault -o default just
else
    complete -F _just -o bashdefault -o default just
fi

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# uv
export PATH="$HOME/.local/bin:$PATH"

# yew-fmt
export RUSTFMT=yew-fmt

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/path.bash.inc' ]; then . '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/dandelion/Dandelion/SDK/google-cloud-sdk/completion.bash.inc'; fi

# kubectl aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
. "$HOME/.local/bin/env"

alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'
