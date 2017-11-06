# cgi devel

this is my debug env

    twd () {
        tmux new \;\
        split-window \;\
        resize-pane -y 10 \;\
        send-keys "$*" C-m \;\
        select-pane -U
    }

    twd busybox -vvfp2000
