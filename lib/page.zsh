uze cgi --setup
uze http

page/ok    () http/header 200 text/html  "$@"
page/text  () http/header 200 text/plain "$@"
page/error () http/header 500 text/html  "$@"

# exemple:
#
# tarea 33x45 'class="those are classes"' <<-\.
# 	this is the least i can do ...
# 	    
# 	welcome to shell scripting
# 	.

tarea () {
	local  rows cols
	IFS=x read rows cols <<< $1
	shift
	print "<input rows=\"$rows\" cols=\"$cols\"${*+ $*}>"
	cat
	print "</input>"
}
