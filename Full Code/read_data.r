# Use the cytomapper to read the images and masks in their respective folders


images <- loadImages(paste("../data/images/", args[1], '/', sep = ""))
print("Images loaded")

masks <- loadImages(paste("../data/masks/", args[1], '/', sep = ""), as.is = TRUE)
print("Masks Loaded")

# To get the channel nanes we need to import a sample csv sheet and extract features # nolint: line_length_linter.
features <- read_csv("../data/sheets/sample.csv")
channels <- c("DAPI", "CD74", "IDO-1", "SPINK4", "CD45", "CD4", "CD20", "CD138", "CD11b", "Ki67", "CD11c", "CD8", "CD38", "aSMA", "CD68", "S100", "CD3", 'E-Cadherin', 'CD21', 'Vimentin', 'HLA-DR') # nolint: line_length_linter.
channel_counts <- features[,channels]
meta <- features[, c("Reg", "Tile Row", "Tile Col", "Tile Z", "Cell Size")]
coords <- features[, c("Absolute X", "Absolute Y")]

# Construct a spatial experiment object
spe <- SpatialExperiment(assays = list(counts = t(channel_counts)), 
                         colData = meta, 
                         spatialCoords = as.matrix(coords))

# Assign the channel names from the multiplex image meta data to the row names 
channelNames(images) <- rownames(spe)

# Extract the sample id from the image names
sample_id <- names(images)
mcols(images) <- mcols(masks) <- DataFrame(sample_id = names(images))

# Generate a spatial experiment object from the image data
img_spe <- measureObjects(masks, image = images, img_id = "sample_id", return_as = "spe") # nolint: line_length_linter.

# Save the SPE object into data
saveRDS(images, paste("../data/output/images/", args[1], ".rds", sep = ""))
print("Image object saved.")

saveRDS(masks, paste("../data/output/masks/", args[1], ".rds", sep = ""))
print("Mask object saved")

saveRDS(img_spe, paste("../data/output/spe/", args[1], ".rds", sep = ""))
print("SPE object saved.")
