json/encode/_isanum () [[ -n ${1:-} && $1 == ([+-]#[0-9]#.#[0-9]#) ]]

# TAP/prove isa_testing

json/encode/scalar () {
    case $1 { (true|false) it=$1 ; return  ;; }
    json/encode/_isanum $1 && {it=$1; return}
    it=\"$1\"
}

json/% () {
    local it
    my@ encoded
    % { json/encode/scalar $v
        encoded+=\"$k\":$it }
    l "{${(j:,:)encoded}}" }

json/@ () {
    local it
    my@ encoded
    @ { json/encode/scalar $it
        encoded+=$it }
    l "[${(j:,:)encoded}]"
}

json/encode/association () { json/% ${(Pkv)1} }
json/encode/array       () { json/@ ${(P@)1}  }
json/encode             () { json/encode/${(Pt)1%-*} $1 }



