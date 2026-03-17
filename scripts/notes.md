# Notes on 16S rRNA Microbiome Analysis Pipeline

## Project Overview
This project investigates the effects of environmental stressors (temperature and pH) on Atlantic silverside fish (Menidia menidia) and their associated microbiome. Experiments include a preliminary 2x2 factorial design and an expanded 3x3 factorial design at 10 days post hatching (dph).  

The goal is to predict holobiont fitness and potential for adaptation to global climate change.

---

## Experimental Design
- **2x2 factorial (Exp1 & Exp23 pilot):**
  - Ages: 0 dph and 10 dph
  - Temperatures: 17°C and 24°C
  - pH: 7.2–7.5 (Control) and 8.2 (High)
  - 3 biological replicates per treatment

- **3x3 factorial (Exp3 ongoing):**
  - Age: 10 dph
  - Temperatures: 17°C, 21°C, 24°C
  - pH: 7.2 (Control), 7.5 (High), 8.2 (Very High)
  - 3 biological replicates per treatment

---

## Pipeline Notes

### QIIME1
1. Convert FASTA + QUAL to FASTQ:
   - `convert_fastaqual_fastq.py -f <fasta> -q <qual> -o <output_dir> -c fasta_qual_to_fastq -F -b`
   - Includes fill fasta headers and barcode identifiers.
2. Extract barcodes from Mr. DNA data:
   - `Extract_barcodes.py -f <fastq> -c barcode_paired_stitched -l --bc1_len 8 --bc2_len 8 -o <output_dir>`
3. Optional: Split large FASTQ files using `fastq-splitter.pl`.

### QIIME2
1. Import FASTQ + barcodes as EMPSingleEndSequences:
   - Must rename files to `barcodes.fastq.gz` and `sequences.fastq.gz`.
2. Demultiplex using `qiime demux emp-single`.
3. Visualize with `qiime demux summarize`.

### Primer Removal (Cutadapt)
- `qiime cutadapt trim-single --i-demultiplexed-sequences <demux.qza> --p-front GTGYCAGCMGCCGCGGTA --p-error-rate 0 --o-trimmed-sequences <output.qza>`

### DADA2 (R)
- Filter and trim reads:
  - `truncLen = 250`, `trimLeft = 30`
  - `maxN = 0`, `maxEE = 2`, `truncQ = 2`
- Perform denoising:
  - `qiime dada2 denoise-single --i-demultiplexed-seqs <trimmed.qza> --p-trim-left 30 --p-trunc-len 280`

### OTU Picking and Validation
- Closed-reference OTU picking (QIIME1):
  - Reference: `gg_13_8_otus/97_otus.fasta`
  - Taxonomy: `gg_13_8_otus/97_otu_taxonomy.txt`
- Validate demultiplexed fasta:
  - `validate_demultiplexed_fasta.py -m <metadata.tsv> -i <seqs.fna> -o <logfile>`

---

## Important Notes
- Barcode length: 8 bp each (Mr. DNA standard)
- Demultiplexing may fail if SampleIDs or barcodes contain invalid characters.
- All FASTQ/FASTA files must be checked for completeness:
  - `wc -l <file>` to confirm line count.
- Split large FASTQ files to reduce memory load during `split_libraries_fastq.py`.
- Refer to tutorials:
  - [DADA2](https://benjjneb.github.io/dada2/tutorial.html)
  - [QIIME2 Moving Pictures](https://docs.qiime2.org/2023.8/tutorials/moving-pictures/)
