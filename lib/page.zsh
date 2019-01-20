uze cgi --setup
uze http

page/ok    () http/header 200 text/html  "$@"
page/text  () http/header 200 text/plain "$@"
page/error () http/header 500 text/html  "$@"

