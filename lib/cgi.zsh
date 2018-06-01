@ (GET POST Q ) our% $it

cgi/_url_encode () {
    # TODO: should be url/decode ?
    # TODO: use busybox httpd -e if available ?
    @ (math begin end ) our@ $it
    local data=$1 
    data=${data//+/ }
    uze/no/strict
    data=${data//\%(#b)([0-F][0-F])/\\\x$match[1]}
    l     $data
}

cgi/is_set () {
    (( $+QUERY_PARAMETERS )) || typeset -g QUERY_PARAMETERS
    : ${QUERY_PARAMETERS:=${QUERY_STRING?neither QUERY_STRING or QUERY_PARAMETERS are set. are you inside a CGI ?}}
}

cgi/get () {
    cgi/is_set || return
    @ (${(s:&:)QUERY_PARAMETERS})
        % (${(s:=:)it}) { cgi/_url_encode $v | read GET\[$k] }
}

cgi/post () {
    set -- "${(f):-$( tr '&=' $'\n' )}"
    (( $# > 1 )) && POST=( "$@" )
    % (${(kv)POST}) { cgi/_url_encode $v | read POST\[$k] }
}

cgi/params () {
    cgi/get
    cgi/post
    Q=( "${(@kv)GET}" "${(@kv)POST}" )
}

uze/export/cgi () {
    ((#)) && [[ $1 == --setup ]] && cgi/params
}
