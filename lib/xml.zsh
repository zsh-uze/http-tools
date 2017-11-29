
# TODO: handle multiple headers ?
xml/attr/parse () {
    local tag id
    my@ class
    my@ data
    sed 's/[.,\!]/\n&\n/g' <<< $1 | {
        read tag
        @- {
            case $it {
                (!) read id ;;
                (.) read it ; class+=$it ;;
                (,) read it ; data+=$it ;;
            }
        }
    }
    (( $#id ))    && tag+=" id=\"$id\""
    (( $#class )) && tag+=" class=\"$class\""
    (( $#data )) && {
        set -- data-$^data
        tag+=" $*"
    }
    print -n $tag
}

xml/tag/close () {
    print -n "</${TAGSTACK[-1]}>"
    TAGSTACK[-1]=()
}

xml/tag/open () {
    TAGSTACK+=$1
    print -n "<$1" ;
    shift
    case ${1:-} {
        ([,.!]*) xml/attr/parse $1 ; shift ;;
    }

    while ((#)) {
        case $1 {
            (-) shift ; print -n ">$*" ; return ;;
            (/) print -n "/>"  ; TAGSTACK[-1]=()  ; return ;;
            (*) print -n \ $1=\"$2\" ; shift 2 ;;
        }
    }
    print -n ">"
}

xml/decltag () {
    eval $1 '() {xml/tag/open '$1 '"$@"}'
}
