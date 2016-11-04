# Makefile
# File ID: 3eaf2bda-20dd-11e4-a0e2-c80aa9e67bbd

.PHONY: default
default: plot

relative.dat: repos.dat Makefile
	./convert-to-relative repos.dat >relative.dat

.PHONY: bezier
bezier: relative.dat
	./plot-graph --bezier repos.dat
	./plot-graph --bezier relative.dat
	./plot-graph --bezier --zoom relative.dat

.PHONY: clean
clean:
	rm -fv relative.dat

.PHONY: dups
dups:
	cat repos.dat >>dups.dat
	$(MAKE) sort
	git checkout -f repos.dat

.PHONY: plot
plot: relative.dat
	./plot-graph repos.dat
	./plot-graph relative.dat
	./plot-graph --zoom relative.dat

.PHONY: sort
sort:
	sort -u repos.dat >repos.dat.tmp
	mv repos.dat.tmp repos.dat
	sort -u dups.dat >dups.dat.tmp
	mv dups.dat.tmp dups.dat

.PHONY: svg
svg: relative.dat
	./plot-graph --svg repos.dat
	./plot-graph --svg relative.dat
	./plot-graph --svg --zoom relative.dat
