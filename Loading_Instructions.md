# Multiplex: loading instructions and analysis guide

This guide describes the supplied RDS object and how to explore its saved results. The data exploration code covers some of the key analyis, and makes it accessible for reviewers. Software installation is covered in [Requirements.md](Requirements.md).

## 1. The RDS object

The Ileum_Data RDS file contains a **SpatialExperiment (SPE)** object (ileum_spe): **21 markers × 62,752 cells**. Rows represent markers; columns represent cells. 

### 1.1 Object fields

| Field | Value | Meaning | Access in R |
| --- | --- | --- | --- |
| `class` | `SpatialExperiment` | Container for marker measurements, cell annotations, spatial coordinates and analysis results. | `ileum_spe` |
| `dim` | `21 × 62752` | Number of markers and cells, respectively. | `dim(ileum_spe)` |
| `metadata` | 129 entries | Object-wide information, including colour schemes. | `metadata(ileum_spe)` |
| `assays` | 3 | Marker x Cell matrices.  | `assayNames(ileum_spe)`; `assay(ileum_spe, "exprs")` |
| `rownames` |     21| Multiplex markers shared by the assays. | `rownames(ileum_spe)` |
| `rowData` | 21    | Marker-level annotations, with one row per marker.  | `rowData(ileum_spe)` |
| `colnames` | 62,752 | Cell identifiers like `cell1`, `cell2`, …, `cell62751`, `cell62752`. | `colnames(ileum_spe)` |
| `colData` | 22 fields | Cell-level annotations/metadata, with one row per cell. | `colData(ileum_spe)` |
| `reducedDims` | 7 |  Matrices of cell embeddings. | `reducedDimNames(ileum_spe)`; `reducedDim(ileum_spe, "UMAP")` |
| `mainExpName` | `NULL` | The main experiment has no assigned name. | `mainExpName(ileum_spe)` |
| `altExps` | 0 | No alternative experiments are listed. | `altExpNames(ileum_spe)` |
| `spatialCoords` | 2 coordinate fields | Spatial position of each cell. | `spatialCoords(ileum_spe)` |
| `imgData` | 1 field | Image-level annotation    | `imgData(ileum_spe)` |

### 1.2 Metadata: colour vectors

`color_vectors` is the main metadata that contains color schemes for our cell representation with the legend scheme for our main type of cells `gate_label` annotated using manual gating.

```r# 
# The celltype color scheme
celltype <- setNames(c("#EF8ECC", "#F4AD31","#894F36", "#4DB23B", "#066970", "#6471E2","white",
                       "#FFFF0A","#ADD8E6","#BF0A3D", "#808080", "#F4800C"),
                     c("Stromal Cells", "B Cells", "BnT Cells", "CD4+ T Cells", "Macrophages", "CD8+ T Cells", "CD3+ Cells", 
                       "CD11c+ Cells", "CD11b+ Cells", "Epithelial Cells", "Other", "Plasma Cells"))
# The color_vector gated_cell color specifies the manual annotations
metadata(ileum)$color_vectors$gated_cell_color <- celltype
```

### 1.3 Assays — 3 entries

| No. | Assay | Explanation |
| --- | --- | --- |
| 1 | `counts` | Intensity marker measurements for each cell.  |
| 2 | `exprs` | Expression values used for downstream analysis, normalized using the asinh transformation. |
| 3 | `logs` |   Logartithmic transformed celll intensity counts|


### 1.4 Marker identifiers — 21 entries

Generated using `rownames(ileum_spe)`

| No. | Marker name | Description / role |
| --- | --- | --- |
| 1 | DAPI | Nuclear stain. |
| 2 | CD74 | MHC II Marker|
| 3 | IDO-1 | State Marker|
| 4 | SPINK4 |  Goblet Cell Marker|
| 5 | CD45 | Immune Cell Marker|
| 6 | CD4 |  CD4+ T Cell Marker|
| 7 | CD20 | B Cell Marker |
| 8 | CD138 | Plasma Cell Marker |
| 9 | CD11b | Myeloid Cell Marker |
| 10 | Ki67 | Proliferation Marker |
| 11 | CD11c | Dendritic Cell Marker |
| 12 | CD8 | CD8+ T Cell Marker |
| 13 | CD38 | Plasma Cell Marker |
| 14 | aSMA | Stromal Cell Marker |
| 15 |  CD68| Macrophage Marker  |
| 16 |  S100| Activation Marker (Fibroblasts) |
| 17 | CD3 |  T Cell Marker|
| 18 | E-Cadherin | Epithelial Cell Marker |
| 19 |  CD21  | Dendritic Cell Marker |
| 20 | Vimentin | Intermediate-filament marker. |
| 21 | HLA-DR | MHC class II marker. |

### 1.5 Marker annotations: rowData — 2 fields

Generated using `rowData(ileum_spe)`

| No. | Field | Explanation |
| --- | --- | --- |
| 1 | `use_channel` | Marker-selection flag used to choose filter channels after QC. |
| 2 | `marker_class` | Marker classification, distinguishing phenotype (“type”) and state marker.|

### 1.6 Cell annotations: colData — 22 fields

Generated using `colData(ileum_spe)`

| No. | Field | Explanation / project definition |
| --- | --- | --- |
| 1 | `sample_id` | ROI identifier|
| 2 | `object_id` | Segmented-cell identifier, local to an image |
| 3 | `s.area` | Cell Area |
| 4 | `s.radius.mean` | Cell Radius |
| 5 |  `m.majoraxis`| Cell Elongation |
| 6 | `m.eccentricity` | Cell Eccentricity i.e. deviation from circular shape |
| 7 | `sample_type`  |  Disease Phenotype i.e. ileum_control or ileum_cd|
| 8 | `region` | Biospy that the cell was from i.e. ileum |
| 9 |  `nn_clusters_corrected`| Nearest Neighbours Clusters|
| 10 |  `cluster_celltype`| Annotations of SNN cell clustering approach|
| 11 | `cell_labels` | Automatic annotation cell labels |
| 12 | `harmony_clusters_corrected` | SNN clustering on Harmony Reduced Cells |
| 13 | `cluster_celltype_h` | Cell Annotations of Harmony-SNN clustering |
| 14 |  `celltype`| Alternate clustering annotations |
| 15 |  `aggregatedNeighbors`| Vector of the cells 20 nearest neighbours |
| 16 | `cn_celltypes` | Neighborhoods calculated by KNN |
| 17 | `gate_label` | Cell type annotations from the manual gating approach|
| 18 | `mean_aggregatedExpression` | Mean aggregate expression of each cell type|
| 19 | `cn_expression` | Neighborhoods calculated from marker expression |
| 20 | `spatial_community` | Results of spatial community analysis |
| 21 | `epithelial` | Epithelial annotation |
| 22 | `n_neighbors` | Stored neighbour count per cell for KNN|

### 1.7 Dimensional reductions — 7 entries

Generated using `di(ileum_spe)`

| No. | Saved name | Explanation / source embedding |
| --- | --- | --- |
| 1 | `UMAP` | UMAP embedding |
| 2 | `TSNE` | t-SNE embedding. |
| 3 | `UMAP_FastMNN`| UMAP embedding after FastMNN batch correction|
| 4 | `PCA`| PCA embedding|
| 5 | `fastMNN`|`astMNN embedding| 
| 6 | `harmony` | Harmony batch correciton embedding |
| 7 | `UMAP_harmony` | UMAP generated from Harmony-corrected coordinates|


### 1.8 Spatial coordinates — 2 fields

| No. | Field | Explanation |
| --- | --- | --- |
| 1 | `Pos_X` | Cell x-coordinate of the centroid |
| 2 | `Pos_Y` | Cell y-coordinate of the centroid |

### 1.9 Image annotations: imgData — 1 field

| No. | Field | Explanation |
| --- | --- | --- |
| 1 | `sample_id` | Sample/image identifier in the image annotation table|

### 1.10 Load and inspect the RDS file

To load the SPE object, 

```r
ileum_spe <- readRDS("ileum_data.rds")
ileum_spe

# Full names for the editable tables above
rownames(ileum_spe)
colnames(rowData(ileum_spe))
colnames(colData(ileum_spe))
assayNames(ileum_spe)
reducedDimNames(ileum_spe)
colnames(spatialCoords(ileum_spe))
colnames(imgData(ileum_spe))
```

## 2. Analysis guide

### 2.1 Segmentation

Refer to [Segmentation.md](Segmentation.md) for segmentation guidance.

### 2.2 Access the assays: counts, log and exprs

Select an assay by its exact saved name. Each matrix has markers in rows and cells in columns.

```r
assayNames(ileum_spe)

counts_matrix <- assay(ileum_spe "counts")
log_matrix <- assay(ileum_spe, "logs")
exprs_matrix <- assay(ileum_spe, "exprs")

dim(exprs_matrix)
exprs_matrix[1:5, 1:5]

# Example: all cells' value for CD45
exprs_matrix["CD45", ]
```

Used `exprs` assay for the downstream analysis. 

### 2.3 Dimensional reductions and UMAP before/after Harmony

`fastMNN` and Harmony provide batch-corrected embeddings. UMAP projects an embedding into two dimensions for viewing;before and after plots are dimensional reductions. 

Compare the saved UMAPs:

```r
p1 <- dittoDimPlot(ileum_spe, var = "sample_type", 
                   reduction.use = "UMAP", size = 0.1) + 
    ggtitle("UMAP of Cells by Phenotype")

p2 <- dittoDimPlot(ileum_spe, var = "sample_type", 
                   reduction.use = "UMAP_harmony", size = 0.1) + 
    ggtitle("UMAP of Harmony Batch Corrected Cells By Phenotype")

p1 + p2
```

### 2.4 Cell labels and UMAP coloured by a selected label

Select a label column and view the same cells coloured by that annotation. For example, we see the celltypes from manually gated cells i.e. `gate_label`:

```r
celltype <- setNames(c("#EF8ECC", "#F4AD31","#894F36", "#4DB23B", "#066970", "#6471E2","white",
                       "#FFFF0A","#ADD8E6","#BF0A3D", "#808080", "#F4800C"),
                     c("Stromal Cells", "B Cells", "BnT Cells", "CD4+ T Cells", "Macrophages", "CD8+ T Cells", "CD3+ Cells", 
                       "CD11c+ Cells", "CD11b+ Cells", "Epithelial Cells", "Other", "Plasma Cells"))

metadata(ileum_spe)$color_vectors$gated_cell_color <- celltype

p1 <- dittoDimPlot(ileum_spe, 
                   var = "gate_label", 
                   reduction.use = "UMAP_harmony", 
                   size = 0.2) +
  scale_color_manual(values = metadata(ileum)$color_vectors$gated_cell_color) +
  theme(legend.title = element_blank()) +
  ggtitle("Cell types on UMAP, integrated cells")

p1
```

Use `reduction.use = "UMAP"` to display the selected labels before correction. Repeat with another `label_column` to compare annotation schemes. 

### 2.5 List cell types and view their marker expression in a heatmap

Use the selected label column as the cell-type annotation. List all observed types and their cell counts:

```r
set.seed(220818)
cur_cells <- sample(seq_len(ncol(ileum_spe)), 4000)

# Heatmap visualization - DittoHeatmap
dittoHeatmap(ileum_spe[,cur_cells], 
             genes = rownames(ileum_spe)[rowData(ileum_spe)$use_channel],
             assay = "exprs", 
             cluster_cols = FALSE, 
             scale = "none",
             heatmap.colors = viridis(100), 
             annot.by = c("gate_label", "sample_type", "region"))
```

Rows are markers; columns are cell types; colours show mean expression.  

### 2.6 Spatial graphs and neighbourhoods

Spatial graphs encode cell-to-cell connections in physical space. They are stored in `colPairs`, separate from metadata and dimensional reductions. The spatial graphs generated include:
 


| Workflow graph name | Neighbour definition | Parameters to document |
| --- | --- | --- |
| `knn_interaction_graph` | k nearest cell centroids. | k, directionality and any maximum distance. |
| `expansion_interaction_graph` | Cell centroids within a distance threshold. | Threshold and coordinate units. |
| `delaunay_interaction_graph` | Connections from Delaunay triangulation of centroids. | Any maximum distance and coordinate units. |

Downstream analysis was built on the `knn_interaction_graph`. To visualize the graph for the Ileum CD phenotype use:
```
knn_ileum_cd <-
  plotSpatial(ileum_spe[,ileum_spe$sample_type == "ileum_cd"], 
            node_color_by = "gate_label", 
            node_size_fix = 0.5,
            img_id = "sample_id", 
            draw_edges = TRUE, 
            colPairName = "knn_interaction_graph", 
            nodes_first = FALSE,
            edge_color_fix = "grey") + 
    scale_color_manual(values = metadata(ileum_spe)$color_vector$celltype) +
    ggtitle("knn interaction graph")
```

To visualize the neighbourhoods use:

```
plotSpatial(ileum_spe[,ileum_spe$sample_id %in% c('ileum_ctrl_3')], 
            node_color_by = "cn_celltypes", 
            img_id = "sample_id", 
            node_size_fix = 0.1,
            nrows = 2,
            ncols = 2) +
    scale_color_brewer(palette = "Set2")
```

## 3. Further source code

Any further source code will be available on request.
