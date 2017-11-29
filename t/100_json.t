uze TAP :all
uze json

detect_numbers () {
    @ ( 12 -12 .0 0 .00 1.00 ) {
        json/encode/_isanum $it
        ok "$it is a num" }
    @ ( "the prisonner" "zero" '' UID RANDOM ) {
        json/encode/_isanum $it
        not_ok "$it is not a num" } }

json_encode_scalar () {
    local desc from expected
    for desc        from    expected (
        'string'    'is'    '"is"'
        'bool'      true    true
        'num'       0       0
        'positive'  42      42
    ) { json/encode/scalar $from
        is $it $expected "converting $desc $from (expecting $expected): $it" }
}

enode_simple_structures () {
    my@ fields=( true zeus 0 /bin/zsh )
    my% user=( login zeus id 0 shell /bin/zsh )
    local got
    % ( fields '[true,"zeus",0,"/bin/zsh"]'
        user '{"login":"zeus","shell":"/bin/zsh","id":0}') {
        json/encode $k | read got
        is $got $v "json/encode k (is a ${(Pt)k%-*})" ||
            note "got      ->$got<-" "expected ->$v<-"
    }
}


simple_json_encode () {
    detect_numbers
    json_encode_scalar
    enode_simple_structures
}

TAP/prove simple_json_encode








