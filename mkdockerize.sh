#! /bin/sh

produce() {
    #fail case
    if [[ -z "$1" ]]; then
		echo -e "No valid mkdocs project in the entered path"
		exit 1
	fi
	#success case
	if [[ -d $1 ]]; then
		cd $1
		mkdocs build &> /dev/null
		# make sure mkdocs build works
		echo "dev_addr: 0.0.0.0:8000" >> mkdocs.yml
		cd ..
		tar czf - -C $1 .
	fi
}

serve() {
	#make directory for mkdocs project
	mkdir project
	tar xzf - -C project
	cd project
	mkdocs serve -a 0.0.0.0:8000
}

case $1 in
	produce)
		produce $2
		;;
	serve)
		serve
		;;
esac