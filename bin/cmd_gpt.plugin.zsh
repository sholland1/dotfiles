#!/bin/zsh

# This ZSH plugin reads the text from the current buffer,
# allows the user to describe a change to command in natural
# language, and uses a python script to get a changed command
# from Open AI.

create_completion() {
    MSGS_FILE="~/bin/CmdLinePrompt.jsonl"
    FILENAME="/tmp/PROMPT_MSG"
    text=${BUFFER}

    echo -n "$text" > "$FILENAME"
    $EDITOR "$FILENAME"

    completion=$(ai_completion_from_file.py $MSGS_FILE $FILENAME)

    BUFFER=$completion
    CURSOR=${#BUFFER}
}

zle -N create_completion
bindkey '^X' create_completion
