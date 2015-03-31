README for openhub-repositories.git
===================================

openhub.net (formerly ohloh.net) has an interesting comparison of the 
number of public repositories on the net, based on searches on popular 
hosting services. This comparison is available at 
&lt;<https://www.openhub.net/repositories/compare>&gt; and shows an 
estimated market share between Bazaar, CVS, Git, Mercurial and 
Subversion.

I've been monitoring this since 2014-08-05 to see how things were 
developing, and it's a good indication of the popularity of the various 
version control systems. Generated SVG graphs are stored in `graph/`:

- [**`relative.svg`**](graph/relative.svg)<br />
  Show graphs of relative growth between the various version control 
  systems.
- [**`relative-zoom.svg`**](graph/relative-zoom.svg)<br />
  Same as `relative.svg`, but since the Git graph dwarfs all the others, 
  this is a zoomed-in version to show the differences between Bazaar, 
  CVS, Mercurial and Subversion better.
- [**`repos.svg`**](graph/repos.svg)<br />
  Graph of total number of repositories.

Usage
-----

- **`./get-new-stats.py`**<br />
  Update `repos.dat` with new data from `openhub.net`.
- **`make`**<br />
  Create plots with Gnuplot for local viewing.
- **`make bezier`**<br />
  Same as `make`, but use Bézier smoothing.
- **`make svg`**<br />
  Create SVG plots in `graph/`.
- **`make dups`**<br />
  If there are no updates, execute this to store the new entry in 
  `dups.dat`. This is to avoid polluting `repos.dat` with duplicates, 
  and also document that new data was fetched, but there were no 
  changes.
- **`make sort`**<br />
  Sort `repos.dat` and `dups.dat`. Used by `make dups`.

Dependencies
------------

These programs are necessary to run the various `make` commands or 
`./get-new-stats.py`:

- gnuplot
- Python v3
- bash or any other Bourne-compatible shell
- Perl

Download
--------

The scripts, data files and generated SVG graphs are stored in a Git 
repository at 
&lt;<https://github.com/sunny256/openhub-repositories>&gt;.

License
-------

This program is free software; you can redistribute it and/or modify it 
under the terms of the GNU General Public License as published by the 
Free Software Foundation; either version 2 of the License, or (at your 
option) any later version.

This program is distributed in the hope that it will be useful, but 
WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
General Public License for more details.

Author and contact information
------------------------------

Created by Øyvind A. Holm &lt;<sunny@sunbase.org>&gt;. Patches and 
suggestions are welcome, please use the issue tracker at 
&lt;<https://github.com/sunny256/openhub-repositories/issues>&gt; or 
send an email.

----

    File ID: 69b68b86-d7d8-11e4-a7ba-000df06acc56
    vim: set ts=2 sw=2 sts=2 tw=72 et fo=tcqw fenc=utf8 :
    vim: set com=b\:#,fb\:-,fb\:*,n\:> ft=markdown :
