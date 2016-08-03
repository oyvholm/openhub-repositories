#!/usr/bin/make

# File ID: 3eaf2bda-20dd-11e4-a0e2-c80aa9e67bbd

.PHONY: plot
plot:
	./plot-graph repos.dat
	./convert-to-relative repos.dat >relative.dat
	./plot-graph relative.dat
	./plot-graph --zoom relative.dat

.PHONY: bezier
bezier:
	./plot-graph --bezier repos.dat
	./convert-to-relative repos.dat >relative.dat
	./plot-graph --bezier relative.dat
	./plot-graph --bezier --zoom relative.dat

.PHONY: svg
svg:
	./plot-graph --svg repos.dat
	./convert-to-relative repos.dat >relative.dat
	./plot-graph --svg relative.dat
	./plot-graph --svg --zoom relative.dat

.PHONY: sort
sort:
	sort -u repos.dat >repos.dat.tmp
	mv repos.dat.tmp repos.dat
	sort -u dups.dat >dups.dat.tmp
	mv dups.dat.tmp dups.dat

.PHONY: dups
dups:
	cat repos.dat >>dups.dat
	make sort
	git checkout -f repos.dat
