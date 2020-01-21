



use "data/derived/finaldata.dta", clear
do code/scalars.do


local check1 "school_fe \checkmark"
local check2 "census_c \checkmark"
local check3 "year_fe \checkmark"
local check4 "school_c \checkmark"

capture program drop stats
program stats

	estadd local obs=e(N)
	lincom ffood1 + ffood2 + ffood3
	estadd local lincompoint = round(r(estimate), 0.0001)
	estadd local lincomse = round(r(se), 0.001)
end

forvalues i= 1/4{
	if `i'<3{
	reg fit9Obes `=scalar(controls`i')' `=scalar(option1)'
	eststo variation`i'
	stats
	if `i'==2{
		forvalues j=2/4{
			estadd local  "`check`j''", replace	
		}
	}
}
	
	if `i'>2{
	reg fit9Obes `=scalar(controls`i')' `=scalar(option2)'
	eststo variation`i'
	stats
	estadd local  `check1', replace	
	
	if `i'==4{
		forvalues j=1/4{
		estadd local  "`check`j''", replace	
		}
	}
	}
	}
	
esttab variation1 variation2 variation3 variation4 ///
using "./output/tables/table2.tex", se(3) b(3)  ///
stats(lincompoint lincomse  school_fe year_fe  census_c school_c obs r2, ///
label( "Implied cumulative effect \\ to fast food restaurant within 0.1 miles" ///
 " (standard errors)" "School FE" "Year FE" "Census Controls" "School Controls" "N" "R2" )) ///
 label star(* 0.1 ** 0.05 *** 0.01) nonotes ///
nomtitles mgroups( "Percent of ninth graders that are obese " , ///
pattern(1 0 0 0)  prefix(\multicolumn{@span}{c}{) suffix(}) ///
span) keep(`=scalar(controls1)')   replace 


	
	
