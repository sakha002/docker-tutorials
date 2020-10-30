#!/usr/bin/python3

import sys


for line in sys.stdin:

    line = line.strip()
    unpacked = line.split(",")
    stadium, capacity, expanded, location, surface, turf, team, opened, weather, roof, elevation = line.split(",")
    results = [turf, "1"]
    print("\t".join(results))
