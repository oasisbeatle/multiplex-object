# Multiplex: Segmentation

Two approaches were used for cell segmentation: **StarDist** and **CellSeg**. Images for each region of interest (ROI) are available to overlay the segmentation masks from both approaches, just drag and drop the image plus mask into QuPath. These overlays can be used to inspect cell boundaries and compare the segmentation results within the same ROI. The `StarDist` folder contains all the masks by phenotype, so does the `CellSeg` masks folder while the images (ROIs) are given in the `ROIs` folder. 

## 1. StarDist segmentation

The StarDist segmentation masks are provided as **GeoJSON objects**. Overlay these masks on the corresponding ROI images to inspect the segmented cell boundaries.

### Script of StarDist Segmentation
The exisitng script was optimized for our images.

```
import qupath.ext.stardist.StarDist2D
import qupath.lib.scripting.QP
import qupath.lib.objects.PathAnnotationObject

// IMPORTANT! Replace this with the path to your StarDist model
// that takes a single channel as input (e.g. dsb2018_heavy_augment.pb)
// You can find some at https://github.com/qupath/models
// (Check credit & reuse info before downloading)
def modelPath = "/path/to/model.pb"

// Customize how the StarDist detection should be applied
// Here some reasonable default options are specified
def stardist = StarDist2D
    .builder(modelPath)
    .channels('DAPI')            // Extract channel called 'DAPI'
    .normalizePercentiles(1, 99) // Percentile normalization
    .threshold(0.5)              // Probability (detection) threshold
    .pixelSize(0.5)              // Resolution for detection
    .cellExpansion(5)            // Expand nuclei to approximate cell boundaries
    .measureShape()              // Add shape measurements
    .measureIntensity()          // Add cell measurements (in all compartments)
    .build()

// Define which objects will be used as the 'parents' for detection
// Use QP.getAnnotationObjects() if you want to use all annotations, rather than selected objects
def pathObjects = QP.getSelectedObjects()

// Run detection for the selected objects
def imageData = QP.getCurrentImageData()
if (pathObjects.isEmpty()) {
    QP.getLogger().error("No parent objects are selected!")
    return
}
stardist.detectObjects(imageData, pathObjects)

// Get currently selected detections
def detections = getSelectedObjects()

detections.each { det ->
    def roi = det.getROI()
    def ann = new PathAnnotationObject(roi)
    addObject(ann)
}

// Remove original detections if you don’t want them anymore
removeObjects(detections, true)

stardist.close() // This can help clean up & regain memory
print('Done!')

```
### Classification of Segmented Cells
The rules for the Classification were set by the QuPath classifers given in JSON files in the folder `Classifiers` in the `StarDist` folder.

### Script to Quanitfy Cells from Segmentation

The following script `get_cell_counts.py` gives us the cell types given a threshold table and the cell masks.

## 2. CellSeg model

The CellSeg model generated segmentation masks. These masks were subsequently processed into segmented cell data using the an input script given in the CellSeg folder.

The CellSeg masks can be overlaid on the corresponding ROI images to inspect cell boundaries and compare the results with the StarDist segmentation.
