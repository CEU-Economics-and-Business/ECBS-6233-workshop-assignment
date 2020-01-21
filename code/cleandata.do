

clear all 

*Loop over the file and merge the data sets

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

* Destring variables
destring ffood* afood, replace


label var ffood "Fast food"
label define fast ///
	0 "No fast food restaurant" /// 
	1 "Fast food within 0.10 miles" ///
	2 "Fast food within 0.10 - 0.25 miles" ///
	3 "Fast food within 0.25 - 0.5 miles"
label values ffood fast

label var afood "Other restaurant"
label define any ///
	0 "No other restaurant" ///
	1 "Other restaurant within 0.10 miles" ///
	2 "Other restaurant within 0.10 - 0.25 miles" ///
	3 "Other restaurant within 0.25 - 0.5 miles"
label values afood any


*create variables needed for the analysis
foreach variable in afood ffood ffoodlag{
	gen `variable'1=inlist(`variable',1)
	gen `variable'2=inlist(`variable',1,2)
	gen `variable'3=inlist(`variable',1,2,3)
}	

	
*preserve labels
foreach variable in afood ffood {
	
	local vname "`variable'"

	levelsof `vname', local(levs)
	local dctname `:value label `vname''
	forvalues i = 1/3 {
	loca adjusted = ustrregexra("`:label `dctname' `i''", "[0-9].[0-9][0-9] - ","")
	label variable `vname'`i' "`adjusted'"
	}

}

save "data/derived/finaldata.dta", replace 

