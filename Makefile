# Makefile
# File ID: 3eaf2bda-20dd-11e4-a0e2-c80aa9e67bbd

.PHONY: default
default: status plot

relative.dat: repos.dat repos.sqlite Makefile
	./convert-to-relative repos.dat >relative.dat

repos.sql: repos.dat Makefile
	./create-sql repos.dat >repos.sql

repos.sqlite: repos.sql Makefile
	rm -f repos.sqlite
	sqlite3 repos.sqlite <repos.sql

status.txt: repos.sqlite
	./textreport >status.txt

graph/repos.svg: repos.dat Makefile
	./plot-graph --svg repos.dat

graph/relative.svg: relative.dat Makefile
	./plot-graph --svg relative.dat

graph/relative-zoom.svg: relative.dat Makefile
	./plot-graph --svg --zoom relative.dat

.PHONY: bezier
bezier: relative.dat
	./plot-graph --bezier repos.dat
	./plot-graph --bezier --zoom relative.dat
	./plot-graph --bezier relative.dat

.PHONY: clean
clean:
	rm -fv relative.dat repos.sql repos.sqlite

.PHONY: dups
dups:
	cat repos.dat >>dups.dat
	$(MAKE) sort
	git checkout -f repos.dat

.PHONY: plot
plot: relative.dat
	./plot-graph repos.dat
	./plot-graph --zoom relative.dat
	./plot-graph relative.dat

.PHONY: status
status: repos.sqlite status.txt
	cat status.txt

.PHONY: sort
sort:
	sort -u repos.dat >repos.dat.tmp
	mv repos.dat.tmp repos.dat
	sort -u dups.dat >dups.dat.tmp
	mv dups.dat.tmp dups.dat

.PHONY: svg
svg: graph/repos.svg graph/relative.svg graph/relative-zoom.svg

.PHONY: update
update:
	./get-new-stats.py
