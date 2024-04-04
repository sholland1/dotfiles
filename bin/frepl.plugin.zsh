#!/bin/zsh

start_frepl() {
    temp_file="/tmp/frepl_cache"
    text=${BUFFER}

    parts=("${(s:|:)text}")

    if [ ${#parts} -eq 1 ]; then
        preview_command="$text{q}"
    else
        before_pipe="${(j:|:)parts[1,-2]}"
        after_pipe="${parts[-1]}"
        zsh -c "$before_pipe" > $temp_file
        preview_command="cat $temp_file | $after_pipe{q}"
    fi

    RESULT=$(echo "REPL - $text{}" |
        fzf --print-query --phony \
            --bind 'alt-h:backward-char,alt-l:forward-char' \
            --preview $preview_command --preview-window=down:99% |
        head -1)

    if [ "$RESULT" ]; then
        BUFFER="$text'$RESULT'"
        CURSOR=${#BUFFER}
    fi
}

zle -N start_frepl
bindkey '^[x' start_frepl
