#!/bin/bash
for file in ls *.gz
do
	gunzip  $file
done


