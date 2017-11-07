json/enode/_isanum () [[ -n ${1:-} && $1 == ([+-]#[0-9]#.#[0-9]#) ]]

# TAP/prove isa_testing

json/enode/scalar () {
    case ${(P)1} {
        (true|false) it=${(P)1}; return  ;;
    }
    json/enode/_isanum ${(P)1} && {it=${(P)1}; return}
    it=\"${(P)1}\"
}

json/enode/association () {
    local it
    % (${(Pkv)1}) {
        json/enode/scalar v
        argv+=\"$k\":$it
    }
    shift
    l "{${(j:,:)@}}"
}

json/enode/array () {
    local it
    @ (${(P@)1}) {
        json/enode/scalar it
        argv+=$it
    }
    shift
    l "[${(j:,:)@}]"
}

json/enode () { json/enode/${(Pt)1%-*} $1 }



