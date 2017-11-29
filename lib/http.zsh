# TODO: handle multiple headers ?


my% HTTP_CODE=(
    OK     200
    ERROR  500
)

http/header () {
    local code=${(U)1?http error name (case insensitive)}
    shift
    say   "HTTP/1.1 ${HTTP_CODE[$code]} $code" \
        "Content-Type: ${as:-text/html}" \
        "$@" \
        "Connection: Closed" '' }

