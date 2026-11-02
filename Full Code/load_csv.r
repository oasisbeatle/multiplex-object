
# ------------------------------------- #
## Title: "load_csv.r"

## Description: This script loads the RDS objects onto the R space and saves the channel wise data of 

# ------------------------------------- #


# Load the SPE RDS Datasets into objects
ileum_cd <- readRDS("../data/output/spe/ileum_cd.rds")
ileum_ctrl <- readRDS("../data/output/spe/ileum_ctrl.rds")
rectum_cd <- readRDS("../data/output/spe/rectum_cd.rds")
rectum_ctrl <- readRDS("../data/output/spe/rectum_ctrl.rds")

# For each of the ROIs define a sample type from {ileum_cd, ileum_ctrl, rectum_cd, rectum_ctrl} and a region from {ileum, rectum}. Then each of the cells 
# are given a unique cell number from "cell1" to "celln" where n is the total number of cells. The counts assay is normalized to create two new assays:
# the exprs assay based on inverse cosine normalization while the logs assay based on log normalization. The final objects are used to write csv objects
# that would be used as input for cell-labeling models. 

# Ileum CD
ileum_cd$sample_type <- "ileum_cd"
ileum_cd$region <- "ileum"
colnames(ileum_cd) <- paste0('cell', seq_len(ncol(ileum_cd)))
assay(ileum_cd, "exprs") <- asinh((65535 * counts(ileum_cd))/1)
assay(ileum_cd, "logs") <- log(counts(ileum_cd) + 0.01)
ileum_cd_exprs <- assay(ileum_cd, "exprs")
ileum_cd_logs <- assay(ileum_cd, "logs")
write.csv(ileum_cd_exprs, "../data/output/sheets/ileum_cd_exprs.csv")
write.csv(ileum_cd_logs, "../data/output/sheets/ileum_cd_logs.csv")

# Ileum CTRL 
ileum_ctrl$sample_type <- "ileum_ctrl"
ileum_ctrl$region <- "ileum"
colnames(ileum_ctrl) <- paste0('cell', seq_len(ncol(ileum_ctrl)))
assay(ileum_ctrl, "exprs") <- asinh((65535 * counts(ileum_ctrl))/1) 
assay(ileum_ctrl, "logs") <- log(counts(ileum_ctrl) + 0.01)
ileum_ctrl_exprs <- assay(ileum_ctrl, "exprs")
ileum_ctrl_logs <- assay(ileum_ctrl, "logs")
write.csv(ileum_ctrl_exprs, "../data/output/sheets/ileum_ctrl_exprs.csv")
write.csv(ileum_ctrl_logs, "../data/output/sheets/ileum_ctrl_logs.csv")


# Rectum CD
rectum_cd$sample_type <- "rectum_cd"
rectum_cd$region <- "rectum"
colnames(rectum_cd) <- paste0('cell', seq_len(ncol(rectum_cd)))
assay(rectum_cd, "exprs") <- asinh((65535 * counts(rectum_cd))/1) 
assay(rectum_cd, "logs") <- log(counts(rectum_cd) + 0.01)
rectum_cd_exprs <- assay(rectum_cd, "exprs")
rectum_cd_logs <- assay(rectum_cd, "logs")
write.csv(rectum_cd_exprs, "../data/output/sheets/rectum_cd_exprs.csv")
write.csv(rectum_cd_logs, "../data/output/sheets/rectum_cd_logs.csv")

# Rectum CTRL 
rectum_ctrl$sample_type <- "rectum_ctrl"
rectum_ctrl$region <- "rectum"
colnames(rectum_ctrl) <- paste0('cell', seq_len(ncol(rectum_ctrl)))
assay(rectum_ctrl, "exprs") <- asinh((65535 * counts(rectum_ctrl))/1) 
assay(rectum_ctrl, "logs") <- log(counts(rectum_ctrl) + 0.01)
rectum_ctrl_exprs <- assay(rectum_ctrl, "exprs")
rectum_ctrl_logs <- assay(rectum_ctrl, "logs")
write.csv(rectum_ctrl_exprs, "../data/output/sheets/rectum_ctrl_exprs.csv")
write.csv(rectum_ctrl_logs, "../data/output/sheets/rectum_ctrl_logs.csv")

# Load the raw counts as csv files too
write.csv(counts(ileum_cd), "../data/output/sheets/ileum_cd_counts.csv")
write.csv(counts(ileum_ctrl), "../data/output/sheets/ileum_ctrl_counts.csv")
write.csv(counts(rectum_cd), "../data/output/sheets/rectum_cd_counts.csv")
write.csv(counts(rectum_ctrl), "../data/output/sheets/rectum_ctrl_counts.csv")

# Rewrite saved rds files with new assay data 
saveRDS(ileum_cd, paste("../data/output/spe/", "ileum_cd", ".rds", sep = ""))
print("Ileum CD object saved.")
saveRDS(ileum_ctrl, paste("../data/output/spe/", "ileum_ctrl", ".rds", sep = ""))
print("Ileum CTRL object saved.")
saveRDS(rectum_cd, paste("../data/output/spe/", "rectum_cd", ".rds", sep = ""))
print("Rectum CD object saved.")
saveRDS(rectum_ctrl, paste("../data/output/spe/", "rectum_ctrl", ".rds", sep = ""))
print("rectum ctrl object saved.")