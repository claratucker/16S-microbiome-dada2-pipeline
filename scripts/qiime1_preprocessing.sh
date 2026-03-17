#!/bin/bash

# Extract barcodes for Exp1
extract_barcodes.py \
 -f 090816ND515F-full.fastq \
 -c barcode_paired_stitched \
 --bc1_len 8 --bc2_len 8 \
 -o Exp1_output/

# Extract barcodes for Exp23
extract_barcodes.py \
 -f 122117ND515F2-full.fastq \
 -c barcode_paired_stitched \
 --bc1_len 8 --bc2_len 8 \
 -o Exp23_output/
