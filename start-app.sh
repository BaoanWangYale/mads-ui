#!/bin/bash

# Constants
APP_NAME="mads-ui"
LOG_FILE="app.log"
PID_FILE="app.pid"

# Functions
start_app() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if ps -p "$PID" > /dev/null; then
            echo "App is already running with PID: $PID"
            return 1
        else
            echo "Stale PID file found. Removing it."
            rm "$PID_FILE"
        fi
    fi

    echo "Starting $APP_NAME..."
    nohup npm run serve > "$LOG_FILE" 2>&1 &
    PID=$!
    echo $PID > "$PID_FILE"
    echo "$APP_NAME started with PID: $PID"
    echo "Logs are being written to $LOG_FILE"
}

stop_app() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if ps -p "$PID" > /dev/null; then
            echo "Stopping $APP_NAME with PID: $PID..."
            kill -15 "$PID"
            sleep 2
            if ps -p "$PID" > /dev/null; then
                echo "Forcing termination..."
                kill -9 "$PID"
            fi
            rm "$PID_FILE"
            echo "$APP_NAME stopped"
        else
            echo "No running process found with PID: $PID"
            rm "$PID_FILE"
        fi
    else
        echo "No PID file found. App is not running or was not started with this script."
    fi
}

status_app() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if ps -p "$PID" > /dev/null; then
            echo "$APP_NAME is running with PID: $PID"
            echo "App URL: http://localhost:8081"
            return 0
        else
            echo "PID file exists but process is not running. App may have crashed."
            return 1
        fi
    else
        echo "$APP_NAME is not running"
        return 1
    fi
}

view_logs() {
    if [ -f "$LOG_FILE" ]; then
        tail -f "$LOG_FILE"
    else
        echo "Log file not found"
        return 1
    fi
}

# Main script
case "$1" in
    start)
        start_app
        ;;
    stop)
        stop_app
        ;;
    restart)
        stop_app
        start_app
        ;;
    status)
        status_app
        ;;
    logs)
        view_logs
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|logs}"
        exit 1
        ;;
esac

exit 0 