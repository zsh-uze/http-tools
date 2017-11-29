# http tools for zsh

TODO: document everything. see test suites for now

## json encoding

usefull demo

    uze json
    my% user
    getent passwd mc |
        IFS=: read user\[login] _ user\[{uid,gid,gecos,home,shell}]
    json/encode user |
        jq .

gives you

    {
      "gecos": "Marc Chantreux,,,",
      "login": "mc",
      "shell": "/bin/zsh",
      "uid": 1000,
      "gid": 1000,
      "home": "/home/mc"
    }

also

    uze json
    json/@ zeus athena taz
    json/% lastname Doe firstname John age 42 missing true

    ["zeus","athena","taz"]
    {"lastname":"Doe","firstname":"John","age":42,"missing":true}

## CGI

because of its very ephemeral nature (a fork by CGI request),
CGI is the perfect choice for a server which serves a lot of
services for few people (1000 pages/minute). examples:
familly server or NGO intranets.

### developement with busybox and tmux

see examples in `eg/`.

starting your devel environment is that simple

    cd ~/document_root_for_my_web_project
    mkdir cgi-bin
    http/serve
    new-script =zsh cgi-bin/hello

`http/serve` and ̀`new-script` are implemented like this

    new-script () {
        l "#! $1" '' > $2
        chmod a+x $2
        ${EDITOR:-vi} $2
    }

    http/serve ()
        if (( $+TMUX )) {
            tmux new -s httpd \;\
                split-window -dl 5 busybox httpd -vvfp 2000
        } else {
            tmux split -dl 5 busybox httpd -vvfp 2000
        }





