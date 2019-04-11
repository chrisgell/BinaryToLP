//Chris Gell 2019

//Section of code using MohoLibJ plugin (COnnected Components and geodesic path) to create very rough LPs along MTs.

//You need the update site detailed here: https://imagej.net/MorphoLibJ#Installation





mtImageName="Image 107.czi";
doMTDetection();


function doMTDetection() {

	//if (getBoolean("Do you want to attempt automatic detection of the microtubules?") == 1) {
		
		
		//check to see if anything in ROI and clear it
		if (roiManager("count") !=0) {
			
			roiManager("Deselect");
			roiManager("Delete");
		
		}
		
		//preprocessing
		selectWindow(mtImageName);
		run("Duplicate...", "title=MT-copy");
		run("Auto Threshold", "method=Default white");
		run("Area Opening", "pixel=70");
		
		//detection
		run("Connected Components Labeling", "connectivity=4 type=[16 bits]");
		selectWindow("MT-copy-areaOpen");
		selectWindow("MT-copy-areaOpen-lbl");
		run("Geodesic Diameter", "label=MT-copy-areaOpen-lbl distances=[City-Block (1,2)] show image=["+mtImageName+"] export");

		
		//display results
		selectWindow(mtImageName);
		run("Enhance Contrast", "saturated=0.35");
		run("Remove Overlay");
		

		
		roiManager("Show All");
		setTool("polyline");


}

