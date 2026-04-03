#!/bin/zsh

function with-spinner() {
    local command="$1"
    local status_text="${2:-Thinking...}"
    local spinner_chars='|/-\\'
    local spinner_speed=0.1

    set +m
    eval "$command" > /tmp/spinner_output_$$ 2>&1 &
    local pid=$!

    local i=1
    while kill -0 $pid 2>/dev/null; do
        printf "\r%s %s\033[K" "${spinner_chars[$i]}" "$status_text" >&2
        i=$(( (i+1) % ${#spinner_chars[@]}))
        ((i++))
        sleep $spinner_speed
    done

    printf "\r\033[K" >&2

    wait $pid
    local exit_code=$?

    set -m

    cat /tmp/spinner_output_$$
    rm /tmp/spinner_output_$$

    return $exit_code
}

