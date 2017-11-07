uze TAP :all
uze json

detect_numbers () {
    @ ( 12 -12 .0 0 .00 1.00 ) {
        json/enode/_isanum $it
        ok "$it is a num" }
    @ ( "the prisonner" "zero" '' UID RANDOM ) {
        json/enode/_isanum $it
        not_ok "$it is not a num" } }

enode_simple_structures () {
    my@ fields=( true zeus 0 /bin/zsh )
    my% user=( login zeus id 0 shell /bin/zsh )
    local got
    % ( fields '[true,"zeus",0,"/bin/zsh"]'
        user '{"login":"zeus","shell":"/bin/zsh","id":0}') {
        json/enode $k | read got
        is $got $v "json/enode k (is a ${(Pt)k%-*})" ||
            note "got      ->$got<-" "expected ->$v<-"
    }
}


simple_json_encode () {
    detect_numbers
    enode_simple_structures
}


TAP/prove simple_json_encode








