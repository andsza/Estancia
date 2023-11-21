#!/bin/bash
for file in $(ls *zip azarate_data/mags_ad)
do
  name=$(echo $file | cut -d "." -f 1,2)
  unzip $file && rm README* && mv ncbi_dataset/ $name/
done

