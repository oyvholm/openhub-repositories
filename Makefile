#!/usr/bin/make

# File ID: 3eaf2bda-20dd-11e4-a0e2-c80aa9e67bbd

all:
	./plot-graph repos.dat
	./convert-to-relative repos.dat >relative.dat
	./plot-graph relative.dat

bezier:
	./plot-graph --bezier repos.dat
	./convert-to-relative repos.dat >relative.dat
	./plot-graph --bezier relative.dat

sort:
	sort -u repos.dat >repos.dat.tmp
	mv repos.dat.tmp repos.dat
	sort -u dups.dat >dups.dat.tmp
	mv dups.dat.tmp dups.dat
