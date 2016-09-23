

drop _all
set mem 100m


do "~/Dropbox/Duch Stevenson Replication/labeldata.do"

	cd "~/Dropbox/Duch Stevenson Replication/

drop if pm~=1

twoway scatter  rnjwSPsm rnjwvol, title("Economic Vote: Volatility and PM Economic Vote", size(medium))  || lfit  rnjwSPsm rnjwvol 
		graph export 3_PMversusvolatile.png, replace 

regr rnjwSPsm rnjwvol


drop if pm~=1
egen tag=group(rnjwSPsm)

gen range=rnjwSPsu-rnjwSPsl
gen flag=0
replace flag=1 if range<0
gen rangepos=0
replace rangepos=rnjwSPsu if rnjwSPsu>=0
gen posratio=rangepos/range if rnjwSPsl<=0
replace posratio=1 if rnjwSPsl>0


summarize range rangepos posratio

gen negative=0
replace negative=range-rangepos
sort flag
egen rangettl=sum(range)
egen rangettl2=sum(range), by(range)
summarize rangettl rangettl2


#delimit;
twoway rbar rnjwSPsu rnjwSPsl tag if tag<170, yline(0)
xlabel(none)
title("Confidence Bands for Economic Vote, Prime Ministerial Parties", size(medium))
xtitle(" ")
legend(off)
ytitle("Economic Vote")
||scatter rnjwSPsm tag if tag<170;

		graph export 3_confidPMparty.png, replace ;






drop _all
set mem 100m

do "~/Dropbox/Duch Stevenson Replication/utility.do"

	cd "~/Dropbox/Duch Stevenson Replication/"

		replace twodigcty="usp" if cnumb==23
		replace twodigcty="usc" if uscong==1


		sort studysyr
		histogram rnjwSPsm if pm==1, normal 	xtitle("Impact on PM Party Support of Worsening Economic Perceptions",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1) t1("Figure 2. Impact on PM Party Support of Worsening Economic Perceptions", size(medium))
		graph export electoralstud_2.wmf, replace 	
		summarize rnjwSPsm if pm==1
		tabulate rnjwSPsm if pm==1


		graph box rnjwSPsm if pm==1, over(twodigcty, label(alternate) sort(1)) ytitle("PM Party Economic Vote",size(small)) t1("Figure 3.9. PM Party Economic Vote by Country") note("Note: Economic perceptions move from neutral to worse category", size(vsmall))
		graph export chap3_3_9.png, replace 






/* For Electoral Studies Artile */



drop _all
set mem 100m

do "~/Dropbox/Duch Stevenson Replication/utility.do"

	cd "~/Dropbox/Duch Stevenson Replication/"

		replace twodigcty="usp" if cnumb==23
		replace twodigcty="usc" if uscong==1


		sort studysyr


/*
		histogram rndwSPsm if pm==1, normal 	xtitle("Impact on PM Party Support of Worsening Economic Perceptions",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1) t1("Figure 2. Impact on PM Party Support of Worsening Economic Perceptions", size(medium))
		graph export electoralstud_2.wmf, replace 	
		summarize rndwSPsm if pm==1
		tabulate rndwSPsm if pm==1
*/

		graph box rndwSPsm if pm==1, over(twodigcty, label(alternate) sort(1)) ylabel(#6,format(%9.2fc) labs(vsmall)) ytitle("PM Party Economic Vote",size(small)) t1("Figure 2. PM Party Economic Vote by Country") note("Note: PM Vote responding to economic perceptions that move one unit in worse direction", size(vsmall))
		graph export electoraldw_3_9.png, replace 



	/* Figure 3 for Electoral Studies Article */
		
		sort studysyr
		graph box rndwSPsm if studysyr~=1993 & pm==1, over(studysyr, label(alternate)) ylabel(#6,format(%9.2fc)labs(vsmall)) ytitle("PM Party Economic Vote",size(small)) t1("Figure 3. Magnitude of the PM Economic Vote by Year") note("Note: PM Vote responding to economic perceptions that move one unit in worse direction", size(vsmall))
		graph export electoralstud_3.wmf, replace 		



drop _all
set mem 100m


do "~/Dropbox/Duch Stevenson Replication/utility.do"

cd	"~/Dropbox/Duch Stevenson Replication/"

drop if pm~=1
egen tag=group(rndwSPsm)

gen range=rndwSPsu-rndwSPsl
gen flag=0
replace flag=1 if range<0
gen rangepos=0
replace rangepos=rndwSPsu if rndwSPsu>=0
gen posratio=rangepos/range if rndwSPsl<=0
replace posratio=1 if rndwSPsl>0


summarize range rangepos posratio

gen negative=0
replace negative=range-rangepos
sort flag
egen rangettl=sum(range)
egen rangettl2=sum(range), by(range)
summarize rangettl rangettl2
egen negttl=sum(negative)

#delimit;
twoway rbar rndwSPsu rndwSPsl tag if tag<170 & (rndwSPsl>-.3 & rndwSPsu<.2), yline(0)
xlabel(none)
title("Figure 1. Confidence Bands for Economic Vote, Prime Ministerial Parties", size(medium))
xtitle(" ")
ylabel(#4,labs(vsmall))
note("Confidence bounds less than -.3 and greater than 2 truncated for display", size(vsmall))
legend(off)
ytitle("Economic Vote")
||scatter rndwSPsm tag if tag<170 & (rndwSPsl>-.3 & rndwSPsu<.2);

		graph export 1_dwconfidPMparty.png, replace ;







