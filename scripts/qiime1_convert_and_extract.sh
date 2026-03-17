## Purpose: Convert FASTA+QUAL to FASTQ, extract barcodes, split files if needed
#!/bin/bash

# Set directories
RAW_DIR=../raw_data
OUT_DIR=../raw_data/converted

mkdir -p $OUT_DIR

# Convert FASTA + QUAL to FASTQ
python convert_fastaqual_fastq.py \
  -f $RAW_DIR/090816ND515F.fasta \
  -q $RAW_DIR/090816ND515F.qual \
  -o $OUT_DIR \
  -c fasta_qual_to_fastq \
  -F \
  -b

python convert_fastaqual_fastq.py \
  -f $RAW_DIR/122117ND515F2.fasta \
  -q $RAW_DIR/122117ND515F2.qual \
  -o $OUT_DIR \
  -c fasta_qual_to_fastq \
  -F \
  -b

# Extract barcodes (Mr. DNA style, 8bp each)
python Extract_barcodes.py \
  -f $OUT_DIR/090816ND515F-full.fastq \
  -c barcode_paired_stitched \
  -l --bc1_len 8 --bc2_len 8 \
  -o $OUT_DIR

python Extract_barcodes.py \
  -f $OUT_DIR/122117ND515F2-full.fastq \
  -c barcode_paired_stitched \
  -l --bc1_len 8 --bc2_len 8 \
  -o $OUT_DIR

# Optional: Split large FASTQ files, good for multithreading
# ./fastq-splitter-1.0.0/fastq-splitter.pl -f $OUT_DIR/090816ND515F-full.fastq -l 1000000 -o $OUT_DIR/split
