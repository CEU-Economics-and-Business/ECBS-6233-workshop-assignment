
* Use the data set from the previous HW assignment.
use "data/derived/finaldata.dta", clear


local schoolvars no9Obes
	
local schoolchars rttitlei rtnostud rtpupiltc rtblack rtasian rthispanic ///
	rtindian rtmigrant rtfemale rtfreelcelig rtreducedlc rtfteteachers ///
	rttestsc9 rtdmtestsc9
	

local districtchars rtpupiltcds rtmigrantds rtlepellds rtiepds rtstaffds ///
	rtdiplomarecds rtdmdiplomarecds

local censuschars medhhinc medearn avghhsize medcontrent medgrossrent ///
	medvalue pctwhite pctblack pctasian pctmale pctnevermarried pctmarried ///
	pctdivorced pctHSdiponly pctsomecollege pctassociate pctbachelors ///
	pctgraddegree pctinlaborforce pctunemployed pctincunder10k ///
	pctincover200k pcthhwithwages pctoccupied pctpopownerocc pcturban 

local outcome fit9Obes



* Estpost for each column of the summary table.
eststo: estpost tabstat `schoolvars' `schoolchars' `districtchars' `censuschars' `outcome', ///
	stats(mean) col(stat)

foreach value in 3 2 1 {

	eststo: estpost tabstat `schoolvars' `schoolchars' `districtchars' `censuschars' `outcome' if ///
		ffoodlag`value'==1, stats(mean) col(stat)

}

esttab using "output/tables/table1A.tex", replace ///
	refcat(rttitlei "\\ \textit{School Characteristics}" ///
	rtpupiltcds " \\  \textit{School District Characteristics}" ///
	medhhinc "\\  \textit{Census Demographics} " ///
	fit9Obes "\\  \textit{Outcome Variable} " ,nolab)  ///
	label mtitles("All" "$<$0.5 miles FF" "$<$0.25 miles FF" "$<$0.1 miles FF "  "\hline "  ) ///
	cells(mean(fmt(3))) collabels(none) nonum noobs

eststo clear
