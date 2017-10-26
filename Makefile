# Makefile
# File ID: 3eaf2bda-20dd-11e4-a0e2-c80aa9e67bbd

.PHONY: default
default: README.html status

README.html: README.md
	printf '<html><head><title>README</title></head><body>\n' >README.html
	cmark -t html README.md >>README.html
	printf '</body></html>\n' >>README.html

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

.PHONY: abs
abs:
	./plot-graph repos.dat

.PHONY: bezier
bezier: relative.dat
	./plot-graph --bezier relative.dat

.PHONY: clean
clean:
	rm -fv README.html relative.dat repos.sql repos.sqlite
	rm -fv *.tmp
	touch repos.dat

.PHONY: commit
commit: clean update status
	git add repos.dat status.txt
	git ci -m "$$( \
	  printf 'Updates from openhub.net\n\n%s\n\n%s' \
	         "$$(./new-since)" \
	         "$$(suuid -t commit)" \
	)"

.PHONY: dups
dups:
	cat repos.dat >>dups.dat
	$(MAKE) sort
	git checkout -f repos.dat

.PHONY: merge-master
merge-master:
	git merge master || true
	$(MAKE) clean status svg
	git add -u

.PHONY: plot
plot: relative.dat
	./plot-graph relative.dat

.PHONY: status
status: status.txt
	cat status.txt

.PHONY: sort
sort:
	sort -u repos.dat >repos.dat.tmp
	mv repos.dat.tmp repos.dat
	sort -u dups.dat >dups.dat.tmp
	mv dups.dat.tmp dups.dat

.PHONY: svg
svg: graph/repos.svg graph/relative.svg graph/relative-zoom.svg

.PHONY: test
test:

.PHONY: update
update:
	./get-new-stats.py

.PHONY: zoom
zoom: relative.dat
	./plot-graph --zoom relative.dat
