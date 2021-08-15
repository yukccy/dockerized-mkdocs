#! /bin/sh

produce() {
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
	#extract result.tar.gz
	tar -xvzf result.tar.gz -C project/site
	cd project
	mkdocs serve -a 0.0.0.0:8000
}

gitlab() {
	cd project
	mkdocs build
    cd site
    cat index.html
}

case $1 in
	produce)
		produce $2
		;;
	serve)
		serve
		;;
	gitlab)
		gitlab
		;;
esac