
scalar schoolcontrols = " rttitlei rtnostud rtpupiltc rtblack rtasian rthispanic rtindian rtmigrant rtfemale rtfreelcelig rtreducedlc rtfteteachers rtpupiltcds rtmigrantds rtlepellds rtiepds rtstaffds rtdiplomarecds rtdmdiplomarecds rttestsc9 rtdmtestsc9" 


scalar censuscontrols = " medhhinc medearn avghhsize medcontrent medgrossrent medvalue pctwhite pctblack pctasian pctmale pctnevermarried pctmarried pctdivorced pctHSdiponly pctsomecollege pctassociate pctbachelors pctgraddegree pctinlaborforce pctunemployed pctincunder10k pctincover200k pcthhwithwages pctoccupied pctpopownerocc pcturban"

xi i.year
scalar yearfixed =" _Iyear_2001 _Iyear_2002 _Iyear_2003 _Iyear_2004 _Iyear_2005 _Iyear_2006 _Iyear_2007"


scalar controls1  = " ffood1 afood1 ffood2 afood2 ffood3 afood3" 
*local schoolcontrols 

scalar controls2 = `"`=scalar(controls1)'"' + `"`=scalar(schoolcontrols)'"' + `"`=scalar(censuscontrols)'"'

scalar controls3 = `"`=scalar(controls1)'"' + `"`=scalar(yearfixed)'"' 

scalar controls4 = `"`=scalar(controls1)'"' + `"`=scalar(yearfixed)'"' + `"`=scalar(schoolcontrols)'"' + `"`=scalar(censuscontrols)'"'


scalar option1 = "[aw=no9Obes], cluster(schoolcode)"
scalar option2 = "[aw=no9Obes], cluster(schoolcode) a(schoolcode)"
