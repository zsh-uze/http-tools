json/encode/_isanum () [[ -n ${1:-} && $1 == ([+-]#[0-9]#.#[0-9]#) ]]

# TAP/prove isa_testing

json/encode/scalar () {
    case ${(P)1} {
        (true|false) it=${(P)1}; return  ;;
    }
    json/encode/_isanum ${(P)1} && {it=${(P)1}; return}
    it=\"${(P)1}\"
}

json/encode/association () {
    local it
    % (${(Pkv)1}) {
        json/encode/scalar v
        argv+=\"$k\":$it
    }
    shift
    l "{${(j:,:)@}}"
}

json/encode/array () {
    local it
    @ (${(P@)1}) {
        json/encode/scalar it
        argv+=$it
    }
    shift
    l "[${(j:,:)@}]"
}

json/encode () { json/encode/${(Pt)1%-*} $1 }



