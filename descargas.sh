#!/bin/bash
cat selected.txt | xargs -n 1 -P 10 wget -q
