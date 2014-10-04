#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""get-new-stats.py - Update repos.dat

File ID: 2b19b4de-469c-11e4-abcb-c80aa9e67bbd
License: GNU General Public License version 2 or later.
Author: Øyvind A. Holm <sunny@sunbase.org>

"""

import json
import time

def get_http(url):
    import urllib.request
    response = urllib.request.urlopen(url)
    str_response = response.readall().decode('utf-8')
    return str_response

if __name__ == "__main__":
    chart = json.loads(get_http('https://www.openhub.net/repositories/chart'))
    v = {
        'bazaar'     : chart['series'][0]['data'][0][1],
        'cvs'        : chart['series'][0]['data'][1][1],
        'git'        : chart['series'][0]['data'][2][1],
        'mercurial'  : chart['series'][0]['data'][3][1],
        'subversion' : chart['series'][0]['data'][4][1],
        }

    with open('repos.dat', 'a') as f:
        f.write("%s %u %u %u %u %u\n" % (
            time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()),
            v['bazaar'],
            v['cvs'],
            v['git'],
            v['mercurial'],
            v['subversion'],
            ))
        f.close()
