
use "data/derived/finaldata.dta", clear

do code/scalars.do

*install lean2 scheme
set scheme lean2

tab year, gen (dum_year)


matrix grund = [.]


	
forvalues i= 1/2{
	matrix w`i'=[.,.]

		reg fit9Obes  `=scalar(controls4)' `=scalar(option`i')'

	forvalues k=1/6 {
	
		matrix beta = e(b)
		matrix beta = beta[1,`k']
		matrix variance = e(V)
		scalar variance = sqrt(variance[`k',`k'])
		matrix S = [beta,variance]
		matrix grund = [grund,S]
		matrix w`i' = [w`i'\beta,variance]

	}
}

matrix dist = [0.1\0.25\0.5] 			
matrix colnames w1 = cs_b cs_se 	
matrix colnames w2 = p_b p_se 		
matrix colnames dist = ffood_dist 	
matrix figur1a=w1,w2
matrix figur1a2 = figur1a[2, 1..4]
matrix figur1a4 = figur1a[4, 1..4]
matrix figur1a6 = figur1a[6, 1..4]
matrix rownames figur1a = x 1miles 25miles 5miles
matrix figur1a = figur1a2\figur1a4\figur1a6
matrix figur1a = figur1a,dist



drop _all
svmat figur1a, names(col)


* Confidence interval
gen cs_ub = cs_b+(1.96*cs_se)
gen cs_lb = cs_b-(1.96*cs_se)
gen p_ub = p_b+(1.96*p_se)
gen p_lb = p_b-(1.96*p_se)


* Generate graph.
twoway (rcap cs_ub cs_lb ffood_dist, ///
	lcolor(red) lwidth(thick) lpattern(-))(rcap p_ub p_lb ffood_dist, ///
	lcolor(blue) lwidth(thin)) (connect cs_b ffood_dist, ///
	lcolor(gray) lwidth(vthin) lpattern(.-) msymbol(Oh) msize(small) ///
	mcolor(blue)) (connect p_b ffood_dist, lcolor(gray)  lwidth(vthin) lpattern(.-) msymbol(X) msize(small) mcolor(navy)), ///
	ytitle(Estimated Change in % obesity among 9th graders, size(small)) ///
	xtitle(Distance from fast food restaurant (in miles), size(small)) ///
	legend(off) xlabel(0 "0" 0.1 ".1" 0.25 "0.25" 0.5 "0.5") yscale(r(-4 (2) 12)) ylabel(-4 (2) 12)
	*title(Impact of Fast Food on Obesity in Scools, size(small))
	*note("Note: The blue vertical bar represent the 95 % confidence interval using panel estimates;" " the red dashed vertical bar represent the 95 % confidence interval using cross-sectional estimates")


graph export "./output/figures/figure1A.png", replace
