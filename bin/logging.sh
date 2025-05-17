#!/bin/bash

# Logging function
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_file="$HOME/bin/script.log"
    local script_name=$(basename "${BASH_SOURCE[1]:-$0}") # Get calling script name

    # Ensure log file exists
    mkdir -p "$(dirname "$log_file")"
    touch "$log_file"

    # Check if log file size exceeds MAX_SIZE
    local MAX_SIZE=5242880 # 5MB
    if [[ -f "$log_file" && $(du -b "$log_file" | cut -f1) -gt $MAX_SIZE ]]; then
        mv "$log_file" "${log_file}.old"
        touch "$log_file"
    fi

    local TIMEOUT_IN_MS=8000
    case "$level" in
        "debug")
            # Output to stdout and log file only if DEBUG is enabled
            if [[ "${DEBUG:-0}" -eq 1 ]]; then
                echo "[$timestamp] DEBUG [$script_name]: $message" | tee -a "$log_file"
            fi
            ;;
        "info")
            # Output to stdout and log file
            echo "[$timestamp] INFO  [$script_name]: $message" | tee -a "$log_file"
            ;;
        "error")
            # Output to stderr, log file, and notify-send
            echo "[$timestamp] ERROR [$script_name]: $message" | tee -a "$log_file" >&2
            notify-send -t $TIMEOUT_IN_MS -u critical "Error in [$script_name] script" "$message" 2>/dev/null || true
            ;;
        *)
            # Handle invalid log level
            echo "[$timestamp] ERROR [$script_name]: Invalid log level: $level" | tee -a "$log_file" >&2
            notify-send -t $TIMEOUT_IN_MS -u critical "Error in [$script_name] script" "Invalid log level: $level" 2>/dev/null || true
            ;;
    esac
}

# Trap ERR to catch command failures
trap 'log error "Command failed: $BASH_COMMAND (exit code $?)"' ERR
