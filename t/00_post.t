uze TAP :all

uze cgi

cgi_basics () {
    local got
    % ( 'été%20indien' 'été indien'
    ) { cgi/_url_encode $k |read got
        is $got $v }
}

TAP/prove cgi_basics





