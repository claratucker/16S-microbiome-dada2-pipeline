## Purpose: Run DADA2 on demultiplexed, trimmed sequences
#!/bin/bash

qiime dada2 denoise-single \
  --i-demultiplexed-seqs ../outputs/trimmed/trimmed_Exp1.qza \
  --p-trim-left 30 \
  --p-trunc-len 280 \
  --o-representative-sequences ../outputs/rep-seqs/Exp1_rep-seqs-dada2.qza \
  --o-table ../outputs/OTU_tables/Exp1_table-dada2.qza

qiime dada2 denoise-single \
  --i-demultiplexed-seqs ../outputs/trimmed/trimmed_Exp23.qza \
  --p-trim-left 30 \
  --p-trunc-len 280 \
  --o-representative-sequences ../outputs/rep-seqs/Exp23_rep-seqs-dada2.qza \
  --o-table ../outputs/OTU_tables/Exp23_table-dada2.qza
