setImageType('FLUORESCENCE');
clearAllObjects();
createSelectAllObject(true);
runPlugin('qupath.imagej.detect.cells.WatershedCellDetection', '{"detectionImage": "Channel 1",  "backgroundRadius": 0.0,  "medianRadius": 0.0,  "sigma": 1.2,  "minArea": 20.0,  "maxArea": 1000.0,  "threshold": 10.0,  "watershedPostProcess": true,  "cellExpansion": 4.0,  "includeNuclei": true,  "smoothBoundaries": true,  "makeMeasurements": true}');
