## Purpose: Perform DADA2 filtering and trimming in R
library(dada2)

# Paths
filtpathF <- "filtered/Exp1"
fastqFs <- list.files("trimmed/Exp1", pattern="fastq", full.names=TRUE)

# Trim & filter
filterAndTrim(fwd = fastqFs,
              filt = file.path(filtpathF, basename(fastqFs)),
              truncLen = c(250),
              trimLeft = 30,
              maxN = 0,
              maxEE = 2,
              truncQ = 2,
              compress = TRUE,
              multithread = TRUE)

# Repeat for Exp23
filtpathF <- "filtered/Exp23"
fastqFs <- list.files("trimmed/Exp23", pattern="fastq", full.names=TRUE)

filterAndTrim(fwd = fastqFs,
              filt = file.path(filtpathF, basename(fastqFs)),
              truncLen = c(250),
              trimLeft = 30,
              maxN = 0,
              maxEE = 2,
              truncQ = 2,
              compress = TRUE,
              multithread = TRUE)
