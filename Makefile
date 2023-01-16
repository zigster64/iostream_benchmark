all: text
	g++ -O3 -std=c++11 -o bin/iostream iostream.cc
	g++ -O3 -std=c++11 -o bin/stdio stdio.cc
	zig build -p . -freference-trace -Drelease-fast

text:
	curl https://datasets.imdbws.com/title.basics.tsv.gz | gunzip > text

run:
	mkdir -p out
	bash run.sh
