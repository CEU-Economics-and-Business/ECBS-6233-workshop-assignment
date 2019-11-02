

clear all 
set more off



** 1. Loop over the file and merge the data sets

* Merge files over a loop.
forvalues year=1999/2007 {

	* Skip 2000.
	if `year'!=2000 {
	
		* Load the school data  
		use "data/raw/SchoolData`year'",clear
		
		* Merge with restaurant data
		merge 1:1 schoolcode using "data/raw/RestaurantData`year'", nogen

		*  Merge with Census
		merge 1:1 schoolcode using "data/raw/SchoolCensusData`year'", nogen

		* Save temporary files to memory.
		tempfile temp`year'_dataset
		save "`temp`year'_dataset'"

	}
	
}


use `temp1999_dataset', clear

* Loop over the remaining years, appending the temporary data sets
forvalues year=2001/2007{

	append using "`temp`year'_dataset'"

}
