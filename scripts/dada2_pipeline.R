library(dada2)

path <- "data/trimmed_fastq"
fastqFs <- list.files(path, pattern="fastq", full.names=TRUE)

filt_path <- file.path(path, "filtered")

filterAndTrim(
  fwd = fastqFs,
  filt = file.path(filt_path, basename(fastqFs)),
  truncLen = 250,
  trimLeft = 30
)
