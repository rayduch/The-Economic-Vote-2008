
drop _all
set mem 100m


do "~/Dropbox/Duch Stevenson Replication/utility.do"
	cd "~/Dropbox/Duch Stevenson Replication/"

	replace twodigcty="uspr" if cnum==23
	replace twodigcty="usco" if uscong==1


	sort studynum
	by studynum: egen govvote=sum(rndwSPsm) if incumb==1


	describe rndwvol
		
		sort studysyr
		histogram rndwSPsm, normal xtitle("Impact on Party Support of Worsening Economic Perceptions",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1 .15)  t1("Figure 3.5. Impact on Party Support of a Worsening Economic Peception", size(medium))
		graph export 3_5.png, replace 	
		summarize rndwSPsm
		tabulate rndwSPsm


		sort studysyr
		histogram  rndwvol, normal xtitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 3.6. Economic Vote Volatility", size(medium))
		graph export 3_6.png, replace 	
		summarize rndwvol
		tabulate rndwvol

		generate partynum=gnumb+(cnumb/10)
		graph box rndwSPsm if incumb==1, over(partynum, label(nolabel) sort(1)) nooutsides t1("Incumbent Parties", size(medium)) ylabel(#4,labsize(vsmall)) ytitle("Economic Vote",size(small)) saving(three_7, replace) note("", size(vsmall)) yline(0)
	
		summarize rndwSPsm if incumb==1
		tabulate rndwSPsm if incumb==1

		graph box rndwSPsm if incumb==0, over(partynum, label(nolabel) sort(1)) nooutsides t1("Opposition Parties", size(medium)) ylabel(#4,labsize(vsmall)) ytitle("Economic Vote",size(small)) saving(three_8, replace) legend(off) note("Source: Vote Preference Surveys 1979-2001", size(vsmall)) yline(0)
		
		summarize rndwSPsm if incumb==0
		tabulate rndwSPsm if incumb==0

		gr combine three_7.gph three_8.gph, col(1) title("Figure 3.9: Economic Vote of Each Party", size(medium))
		graph export 3_9.png, replace 



		histogram  rndwSPsm, normal xtitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 3.2. Total Vote Volatility Due to a Worsening Economic Perception", size(medium))
		graph export 3_2.png, replace 	
		summarize rndwvol
		tabulate rndwvol




	label define vstatus 0 "Opposition" 1 "Incumbent"
	label values incumb vstatus

		gen partylabel=labctypty
		replace partylabel="PS" if labctypty=="frps-"
		replace partylabel="Green" if labctypty=="frgre"
		replace partylabel="UDF" if labctypty=="frudf"
		replace partylabel="PC" if labctypty=="frpcf"
		replace partylabel="RPR" if labctypty=="frrpr"

		graph box rndwSPsm if cnumb==1, over(partylabel, sort(1)) nooutsides ytitle("Party Economic Vote",size(small)) legend(off) note("") yline(0) by(incumb, t1("Figure 3.4. French Party Economic Vote", size(medium)) note("Source: Vote Preference Surveys 1979-2002", size(vsmall)))
		graph export 3_4.png, replace 
				
/*
		
		replace partylabel="PVD" if labctypty=="nlpvd"
		replace partylabel="CDA" if labctypty=="nlcda"
		replace partylabel="D66" if labctypty=="nld66"
		replace partylabel="VVD" if labctypty=="nllib"
		replace partylabel="Left" if labctypty=="nlexl"
  

*/
		replace partylabel="PVD" if gnum==20
		replace partylabel="CDA" if gnum==63
		replace partylabel="D66" if gnum==22
		replace partylabel="VVD" if gnum==70
		replace partylabel="Left" if gnum==10

       

		graph box rndwSPsm if cnumb==3 & (gnum==20 | gnum==63 | gnum==22 | gnum==70 | gnum==10), over(partylabel, sort(1)) nooutsides ytitle("Party Economic Vote",size(small)) legend(off) note("") yline(0) by(incumb, t1("Figure 3.5. Dutch Party Economic Vote", size(medium)) note("Source: Vote Preference Surveys 1979-2002", size(vsmall)))
		graph export 3_3.png, replace 
		
	
/* NOT USED
		sort studysyr
		histogram rndwSPsm if pm==1, normal xtitle("Economic Vote of the Chief Executive",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1) t1("Figure 3.1. Economic Vote of the Chief Executive", size(medium))
		graph export 3_4.png, replace 	
		summarize rndwSPsm if pm==1
		tabulate rndwSPsm if pm==1

*/


	
		sort cnum	
		graph box rndwSPsm if pm==1, over(twodigcty, label(alternate) sort(1)) ytitle("Economic Vote of the Chief Executive",size(small)) t1("Figure 3.3. Magnitude of the Economic Vote by Country")
		graph export 3_3.png, replace 

		sort studysyr
		graph box rndwSPsm if pm==1, over(studysyr, label(angle(45) labsize(vsmall)) ) ylabel(-.2 -.15 -.1 -.05 0 .05, labsize(vsmall)) ytitle("Economic Vote of the Chief Executive",size(small)) t1("Figure 3.4. Magnitude of the Economic Vote by Year")
		graph export 3_4.png, replace 		


		sort cnum	
		graph box govvote if pm==1, over(twodigcty, label(alternate) sort(1)) ytitle("Economic Vote of the Government",size(small)) t1("Figure 3.8. Economic Vote of the Government by Country")
		graph export 3_8.png, replace 
		summarize govvote


		sort studysyr
		histogram rnjwvol, normal xtitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 3.3. Total Vote Volatility Due to a Worsening Economic Peception", size(medium))
		graph export 3_3.png, replace 	
		summarize rnjwvol
		tabulate rnjwvol
		
		
		generate partynum=gnumb+(cnumb/10)
		graph box rndwSPsm if studysyr<1995 & studysyr~=1993 & incumb==1, over(partynum, label(nolabel) sort(1)) nooutsides t1("Incumbent Vote", size(medium)) ytitle("Party Economic Vote",size(small)) saving(three_7, replace) yline(0) note(" ")



		sort cnum		
		graph box rnjwvol if studysyr<1995 & studysyr~=1993 | pm==1, over(twodigcty, label(alternate) sort(1)) ytitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 3.9. Magnitude of the Economic Vote by Country")
		graph export 3_9.png, replace 

		sort studysyr
		histogram rnjwSPsm if pm==1, normal 	xtitle("Impact on PM Party Support of Worsening Economic Perceptions",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1) t1("Figure 3.7. Impact on PM Party Support of Worsening Economic Perceptions", size(medium))
		graph export 3_6.png, replace 	
		summarize rnjwSPsm if pm==1
		tabulate rnjwSPsm if pm==1


		describe rnjwvol
		
		sort studysyr
		histogram rnjwSPsm, normal xtitle("Impact on Party Support of Worsening Economic Perceptions",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1 .15)  t1("Figure 3.4. Impact on Party Support of a Worsening Economic Peception", size(medium))
		graph export 3_4.png, replace 	
		summarize rnjwSPsm
		tabulate rnjwSPsm











	/* Figure 1 for Electoral Studies Article */
		/* sort studysyr
		histogram rnjwvol, normal xtitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 1. Total Vote Volatility Due to a Worsening Economic Peception", size(medium))
		graph export electoralstud_1.png, replace 	
		summarize rnjwvol
		tabulate rnjwvol

*/
		sort studysyr
		histogram rnjwSPsm if pm==1, normal 	xtitle("Impact on PM Party Support of Worsening Economic Perceptions",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1) t1("Figure 3.5. Impact on PM Party Support of Worsening Economic Perceptions", size(medium))
		graph export 3_4.png, replace 	
		summarize rnjwSPsm if pm==1
		tabulate rnjwSPsm if pm==1

	/* Figure 2 for Electoral Studies Article */

		/*
		sort studysyr
		histogram rnjwSPsm if pm==1, normal 	xtitle("Impact on PM Party Support of Worsening Economic Perceptions",size(small)) xlabel(-.15 -.1 -.05 0 .05 .1) t1("Figure 2. Impact on PM Party Support of Worsening Economic Perceptions", size(medium))
		graph export electoralstud_2.png, replace 	
		summarize rnjwSPsm if pm==1
		tabulate rnjwSPsm if pm==1

		*/


	/* Figure 4 for Electoral Studies Article */
		
		sort studysyr
		graph box rnjwvol if studysyr~=1993 & pm==1, over(studysyr, label(alternate)) ytitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 4. Magnitude of the Economic Vote by Year")
		graph export electoralstud_4.png, replace 		

		#delimit;
		sort cnum;		
		graph box rnjwvol if studysyr<1995 & studysyr~=1993 | pm==1, over(twodigcty, label(alternate) sort(1)) ytitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 3.9. Magnitude of the Economic Vote by Country")
		graph export 3_9.png, replace 

	/* Figure 3 for Electoral Studies Article */


		sort cnum		

		graph box rnjwvol if studysyr<1995 & studysyr~=1993 | pm==1, over(twodigcty, label(alternate) sort(1)) ytitle("Total Vote Volatility Due to Worsening Economic Perceptions",size(small)) t1("Figure 3. Magnitude of the Economic Vote by Country")
		graph export electoralstud_3.png, replace 


		sort studynum;
		twoway scatter rndwvol studynum if pm==1 & (cnumb==1 | cnumb==4 | cnumb==9 | cnumb==5), by(cnumb);
		graph export 3_10.png, replace 	
	
		sort gnumb
		generate partynum=gnumb+(cnumb/10)
		graph box rnjwSPsm if studysyr<1995 & studysyr~=1993, over(partynum, label(nolabel) sort(1)) nooutsides ytitle("Distribution of Impact of Worsening Economic Perceptions on Party Vote",size(small)) t1("Figure 3.6: Impact of Worsening Economic Perceptions on Party Vote", size(medium)) note("Source: Vote Preference Surveys 1979-2002", size(vsmall))
		graph export 3_6.png, replace 	

		sort partynum
		by partynum: summarize rnjwSPsm

		by partynum: summarize rnjwSPsm if cnumb==7
		table nameparty partynum if cnumb==7
		graph box rnjwSPsm if studysyr<1995 & studysyr~=1993 & incumb==1 & cnumb==7, over(partynum)



		#delimit;
		sort gnumb;
		graph box rndwSPsm if studysyr<1995 & studysyr~=1993 & incumb==1, over(gnum, label(alternate))
		ylabel(-.15 -.1 -.05 0 .05 .1)
		yline(0)
		ytitle("Distribution of Impact of Worsening Economic Perceptions on Party Vote",size(small))
		t1("Impact of Worsening Economic Perceptions on Incumbent Party Vote");

		#delimit;
		sort gnumb;
		graph box rndwSPsm if studysyr<1995 & studysyr~=1993 & incumb==0, over(gnum, label(alternate))
		ylabel(-.05 0 .05 .1 .15)
		yline(0)
		ytitle("Distribution of Impact of Worsening Economic Perceptions on Party Vote",size(small))
		t1("Impact of Worsening Economic Perceptions on Non-incumbent Party Vote");




/* Confidence Bound */


drop _all
set mem 100m


do "C:\Projects\Book00\Stata do files\Utility and Label files\utility.do"
	cd "C:\Projects\Book00\First Book\Figures and Tables


#delimit;

foreach num of numlist 1/20 {;
	gen draw`num'=(invnorm(uniform())*(rndwSPss))+rndwSPsm; 
	gen absev=abs(draw`num');
	sort studynum;
	by studynum: egen totch=sum(absev);
	gen volat`num'=totch/2;
	drop totch;
	drop absev;
	drop draw`num';
};

gen uspres=0;
recode uspres 0=1 if cnumb==23&studynum>231101;

replace cname="uspres" if uspres==1;
replace cname="uscong" if uspres==0&cnumb==23;

egen test1=rmean(volat*);
egen volse=rsd(volat*);

gen volup=test1+2*volse;
gen voldn=test1-2*volse;

keep if cnum==1;
twoway rbar volup voldn year if pm==1||scatter test1 year, by(cname, legend(off) t1("Figure 3.3. Confidence Bounds for Economic Vote Volatility") note(""))
		ytitle("Economic Vote Volatility",size(small))
		xtitle("Year of Study",size(small))
;
;


/* PM Vote Confidence Bands */



# delimit ;
drop _all; 

do "C:\Projects\Book00\Stata do files\Utility and Label files\utility.do";

	cd "C:\Projects\Book00\First Book\Figures and Tables";


drop if pm~=1;
sort rnjwSPsm;
egen tag=group(rndwSPsm);

summarize tag;  /* should equal the number of cases if there are no ties */




gen uplim=rnjwSPsu;
replace uplim=.2 if rndwSPsu>.2;

gen lowlim=rnjwSPsl;
replace lowlim=-.3 if rndwSPsl<-.3;


twoway rbar uplim lowlim tag, yline(0) bcolor(gs12)
xlabel(none)
xtitle(" ")
legend(off)
ytitle("Economic Vote of the Chief Executive", size(small))
ylabel(-.3 -.2  -.1 -.0548 "mean" 0 .1 .2, labsize(small))
title("Figure 3.1. Confidence Bands for Economic Vote of the Chief Executive", size(medium))
note("confidence bounds greater than .2 and less than -.3 truncated for display")
||scatter rndwSPsm tag, yline(-.0548, lpattern(shortdash));

		graph export 3_1.png, replace ;

/* do calculation for probablity under zero */

gen dist=abs(rndwSPsu-rndwSPsl);

gen temp2=.;
replace temp2=1/163 if rndwSPsu<0;
replace temp2=0 if rndwSPsl>0;
replace temp2=(1/163)*((dist-rndwSPsu)/dist) if temp2==.;

egen sumprob=sum(temp2);
summarize sumprob;


# delimit ;
drop _all; 

do "~/Dropbox/Duch Stevenson Replication/utility.do";

	cd "~/Dropbox/Duch Stevenson Replication/";

	replace cname="us president" if cnum==23;
	replace cname="us congress" if uscong==1;

/* Make PM Map */

gen upcon=rndwSPsu;
gen dncon=rndwSPsl;
replace upcon=.2 if upcon>.2;
replace dncon=-.3 if dncon<-.3;
gen con=rndwSPsm ;
replace con=-.3 if con<-.3;


twoway rbar upcon dncon date if pm==1, ytitle("Economic Vote of the Chief Executive")
	ylabel(,format(%12.1f) angle(0)) 
	xlabel(, format(%tmy))
	xscale(range(250 502))
	yscale(range(-.3 .2))
	xtitle("Date")
	bcolor(gs7)
	barwidth(10)
	by(cname, legend(off) note("Note: One Greek upper confidence interval is truncated ", size(tiny)) title("Figure 3.2. Economic Vote of the Chief Executive by Country", size(medium)) )
		||scatter con date if pm==1, yline(0);

		graph export 3_2.png, replace ;

		/* This is for DLL Paper */
		

drop _all

do "~/Dropbox/Duch Stevenson Replication/utility.do"

	cd "~/Dropbox/Duch Stevenson Replication/"

	preserve

	replace cname="us president" if cnum==23
	replace cname="us congress" if uscong==1
	keep if cnum==23 & uscong==0
	
/* Make PM Map for U.S. */

gen upcon=rndwSPsu
gen dncon=rndwSPsl
replace upcon=.2 if upcon>.2
replace dncon=-.3 if dncon<-.3
gen con=rndwSPsm 
replace con=-.3 if con<-.3


twoway rbar upcon dncon date if pm==1, ytitle("Economic Vote of the Chief Executive") ///
	ylabel(,format(%12.1f) angle(0))  ///
	xlabel(, format(%tmy)) ///
	xscale(range(250 502)) ///
	yscale(range(-.3 .2)) ///
	xtitle("Year") ///
	bcolor(gs7) ///
	barwidth(10) ///
	by(cname, legend(off) note("", size(tiny)) title("Presidential Economic Vote U.S.", size(medium)) ) ///
		||scatter con date if pm==1, yline(0) 

		graph export usa.png, replace 

		list year pm con
		
restore

		

/* This is for APSA 05 paper */

twoway rbar upcon dncon date if pm==1, ytitle("Economic Vote of Chief Executive")
	ylabel(,format(%12.1f) angle(0)) 
	xlabel(, format(%tmy))
	xscale(range(250 502))
	yscale(range(-.3 .2))
	xtitle("Date")
	bcolor(gs7)
	barwidth(10)
	by(cname, legend(off) note("Note: One Greek upper confidence interval is truncated ", size(tiny)) title("Figure 1. Chief Executive Party Economic Vote by Country", size(medium)) )
		||scatter con date if pm==1, yline(0);

		graph export apsa2005_1.png, replace ;


drop _all
set mem 100m

do "~/Dropbox/Duch Stevenson Replication/utility.do"

	cd "~/Dropbox/Duch Stevenson Replication/"
drop if pm~=1

twoway scatter  rnjwSPsm rnjwvol, title("Figure 3.7. Economic Vote Volatility and Economic Vote of Chief Executive", size(medium))  xtitle("Economic Vote Volatility") ytitle("Economic Vote of Chief Executive") legend(off) || lfit  rnjwSPsm rnjwvol 
		graph export 3_PMversusvolatile.png, replace 

regr rnjwSPsm rnjwvol

#delimit;

drop if pm~=1;
egen tag=group(rndwSPsm);

twoway rbar rndwSPsu rndwSPsl tag if tag<170, yline(0)
xlabel(none)
title("Confidence Bands for Economic Vote, Prime Ministerial Parties", size(medium))
xtitle(" ")
legend(off)
ytitle("Economic Vote")
||scatter rndwSPsm tag if tag<170;

		graph export 3_confidPMparty.png, replace ;



/* Left Right Comparison */

drop _all
set mem 100m

use "~/Dropbox/Duch Stevenson Replication/PM_leftright_pnt5_merge.dta", clear

	gen leftright=abs( diff1_leftright)

	describe leftright
		
		histogram leftright, normal xtitle("Impact on Chief Executive Party Support of Shift in Left-Right Identification",size(small)) t1("Figure 3.10. Impact on Party Support of a Shift in Left-Right Identification", size(medium))
		graph export 3_10.png, replace 


/* Post Materialism Comparison */

	use "~/Dropbox/Duch Stevenson Replication/PM_postmat_pnt75_merge.dta", clear

	gen postmaterialism=abs( diff1_PM)

	describe postmaterialism
		
		histogram postmaterialism, normal xtitle("Simulated Impact on Chief Executive Party Support of Shift in Post-Materialism",size(small)) t1("Figure 3.11. Impact on Party Support of a Shift in Post-Materialism", size(medium))
		graph export 3_11.png, replace 




