while IFS= read -r line
do
  datasets download genome accession $line --include gff3,rna,cds,protein,genome,seq-report --filename $line.zip 
done < gca_accession.txt
