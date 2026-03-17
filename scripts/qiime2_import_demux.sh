## Purpose: Import barcodes + sequences into QIIME2, perform demux
#!/bin/bash

# Import experiments to QIIME2
qiime tools import \
  --type EMPSingleEndSequences \
  --input-path ../raw_data/converted/Exp1 \
  --output-path ../outputs/Exp1_emp-single-end-sequences.qza

qiime tools import \
  --type EMPSingleEndSequences \
  --input-path ../raw_data/converted/Exp23 \
  --output-path ../outputs/Exp23_emp-single-end-sequences.qza

# Demultiplex
qiime demux emp-single \
  --i-seqs ../outputs/Exp1_emp-single-end-sequences.qza \
  --m-barcodes-file ../metadata.tsv \
  --m-barcodes-category BarcodeSequence \
  --o-per-sample-sequences ../outputs/demux/Exp1_demux.qza

qiime demux emp-single \
  --i-seqs ../outputs/Exp23_emp-single-end-sequences.qza \
  --m-barcodes-file ../metadata.tsv \
  --m-barcodes-category BarcodeSequence \
  --o-per-sample-sequences ../outputs/demux/Exp23_demux.qza

# Summarize
qiime demux summarize \
  --i-data ../outputs/demux/Exp1_demux.qza \
  --o-visualization ../outputs/demux/Exp1_demux.qzv

qiime demux summarize \
  --i-data ../outputs/demux/Exp23_demux.qza \
  --o-visualization ../outputs/demux/Exp23_demux.qzv
