# Multiplex Project Requirements
This document lists the software and R packages needed for accessing and interacting with the multiplex dataset `ileum_spe.rds`.  

## Required software

| Software | Setup version | Installation / source |
| --- | --- | --- |
| R | **4.6.1** | [Download R from CRAN](https://cran.r-project.org/banner.shtml) |
| RStudio Desktop | **2026.09.0+174** (open-source edition) | [Download RStudio Desktop](https://docs.posit.co/ide/user/#direct-downloads-open-source) |
| Bioconductor | **3.23** | [Bioconductor installation guide](https://bioconductor.org/install/) |

Install R before RStudio. In RStudio, ensure that the selected R installation is R 4.6.1. Bioconductor 3.23 uses the R 4.6 series; R 4.6.0 is its release baseline, and R 4.6.1 is the current stable patch release. Use Bioconductor 3.23 for the package versions listed here. The package versions will depend on the current version of R being run.

## Required R packages

These are the packages that are recommended to be installed. 

| Package | Latest version | Repository / source |
| --- | --- | --- |
| `readr` | 2.2.0 | [CRAN](https://cran.r-project.org/package=readr) |
| `dplyr` | 1.2.1 | [CRAN](https://cran.r-project.org/package=dplyr) |
| `stringr` | 1.6.0 | [CRAN](https://cran.r-project.org/package=stringr) |
| `data.table` | 1.18.6.1 | [CRAN](https://cran.r-project.org/package=data.table) |
| `cytomapper` | 1.24.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/cytomapper.html) |
| `SpatialExperiment` | 1.22.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html) |
| `tidyverse` | 2.0.0 | [CRAN](https://cran.r-project.org/package=tidyverse) |
| `ggrepel` | 0.9.8 | [CRAN](https://cran.r-project.org/package=ggrepel) |
| `EBImage` | 4.54.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/EBImage.html) |
| `scuttle` | 1.22.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/scuttle.html) |
| `dittoSeq` | 1.24.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/dittoSeq.html) |
| `scater` | 1.40.2 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/scater.html) |
| `viridis` | 0.6.5 | [CRAN](https://cran.r-project.org/package=viridis) |
| `Rphenograph` | 0.99.1 | [GitHub Library](https://github.com/JinmiaoChenLab/Rphenograph/blob/master/DESCRIPTION) |
| `mclust` | 6.1.3 | [CRAN](https://cran.r-project.org/package=mclust) |
| `patchwork` | 1.3.2 | [CRAN](https://cran.r-project.org/package=patchwork) |
| `cowplot` | 1.2.0 | [CRAN](https://cran.r-project.org/package=cowplot) |
| `harmony` | 2.0.5 | [CRAN](https://cran.r-project.org/package=harmony) |
| `BiocSingular` | 1.28.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/BiocSingular.html) |
| `scran` | 1.40.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/scran.html) |
| `imcRtools` | 1.18.1 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/imcRtools.html) |
| `ggprism` | 1.0.7 | [CRAN](https://cran.r-project.org/package=ggprism) |
| `ggpubr` | 1.0.0 | [CRAN](https://cran.r-project.org/package=ggpubr) |
| `bluster` | 1.22.0 | [Bioconductor 3.23](https://bioconductor.org/packages/release/bioc/html/bluster.html) |

## Installation

Run the following in the RStudio R console. Required package dependencies are installed automatically. `BiocManager` and `remotes` are installation helpers.

### 1. Install Bioconductor

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

BiocManager::install(version = "3.23", ask = FALSE)
```

### 2. Install CRAN packages

```r
cran_packages <- c(
  "readr", "dplyr", "stringr", "data.table", "tidyverse",
  "ggrepel", "viridis", "mclust", "patchwork", "cowplot",
  "harmony", "ggprism", "ggpubr"
)

install.packages(cran_packages)
```

### 3. Install Bioconductor packages

```r
bioc_packages <- c(
  "cytomapper", "SpatialExperiment", "EBImage", "scuttle",
  "dittoSeq", "scater", "BiocSingular", "scran", "imcRtools",
  "bluster"
)

BiocManager::install(bioc_packages, version = "3.23", ask = FALSE)
```

### 4. Install Rphenograph from GitHub

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

remotes::install_github("JinmiaoChenLab/Rphenograph", upgrade = "never")
```

GitHub installation builds `Rphenograph` from source, so an R-compatible compilation toolchain is required. See the [R installation manual](https://cran.r-project.org/doc/manuals/r-release/R-admin.html) for platform-specific setup. Other packages may also require compilation tools and system libraries when binary packages are unavailable.

## Load the packages

To use the installed packages, please load the following using the library() command. 

```r
library(readr)
library(dplyr)
library(stringr)
library(data.table)
library(cytomapper)
library(SpatialExperiment)
library(tidyverse)
library(ggrepel)
library(EBImage)
library(scuttle)
library(dittoSeq)
library(scater)
library(viridis)
library(Rphenograph)
library(mclust)
library(patchwork)
library(cowplot)
library(harmony)
library(BiocSingular)
library(scran)
library(imcRtools)
library(ggprism)
library(ggpubr)
library(bluster)

```

## Next Steps
To load the RDS object and interact with it, please use the `Loading_Instructions.md` document. The guide also explains the parameters present in the RDS file. 