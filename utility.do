# delimit ;
drop _all;
set mem 100m;

/* run the label file that will provide lots of labels */

do "~/Dropbox/Duch Stevenson Replication/labeldata.do";

*	do "E:\Projects\Book00\Stata do files\Utility and Label Files\labeldata.do";

/* clean up a little */

	duplicates drop;
	drop if rndwSPsm==.;
	drop if rndwvol==.;

/* get rid of votemani - the vote based on manifesto - it is poor compared to votemackie */

drop votemani;

/* do some missings clean up */

mvencode pm_g incumb_g partner_g deputy_g finance_g ecoaff_g
			nummin pertotmin totmin numtech numjrtech pertech numjrtech
	, mv(0) override;


/* use this tag variable for selecting one case from each study */

	egen studytag=tag(studynum);
	label variable studytag "eqals 1 for one case per study";

/* various labels and identifiers */

	gen uscong=0;
	recode uscong 0=1 if studynum>=230101&studynum<=231101;	
	label variable uscong "marks us congressional elections with a 1";

	
/* a date variable */

	gen date=ym(year, month);
	label variable date "number indicating date that can appear as date in nice format";
	
/* define the labels for parties and countries */

	label define countrynames 1 fr 2 be 3 nl 4 de 5 it 6 lx 7 dk 8 ir 9 uk 11 gc 12 sp 13 pt 15 no 16 fi 17 sw 
	18 as 20 ca 21 au 22 nz 23 us 24 jp 25 sw 28 ic;

	label values cnumb countrynames;

	gen str3 smptynam=substr(ptname, 1, 3);
	label variable smptynam "three letter party group name - may leave off some parties in group";

	gen labyear=studysyr-1900 if studysyr<2000;
	replace labyear=studysyr-2000 if studysyr>=2000;
	label variable labyear "two digit year";
	
	gen labvar=(cnumb*100)+labyear;
	label variable labvar "text name for party in year";
	
	gen ctyptyid=(cnumb*1000)+gnumb;
	label variable ctyptyid "numerical country + party group id";
	
	egen idparty=concat(cnumb labyear month gnumb);
	label variable idparty "numerical id for a gnumb in a year and month in a country";
	
  		local actyn1 "fr";
  		local actyn2 "be";
  		local actyn3 "nl";
  		local actyn4 "de";
  		local actyn5 "it";
  		local actyn6 "lx";
  		local actyn7 "dk";
  		local actyn8 "ir";
  		local actyn9 "uk";
  		local actyn11 "gc";
  		local actyn12 "sp";
  		local actyn13 "pt";
  		local actyn15 "no";
		local actyn16 "fi";
		local actyn17 "sw";
		local actyn18 "as";
		local actyn20 "ca";
		local actyn21 "au";
		local actyn22 "nz";
		local actyn23 "us";
		local actyn28 "ic";

	gen str2 twodigcty=" ";
	foreach cnum of numlist 1 2 3 4 5 6 7 8 9 11 12 13 15 16 17 18 20 21 22 23 28 {; 
		replace twodigcty="`actyn`cnum''" if cnumb==`cnum';
		foreach syer of numlist 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 {;
			lab def mylab `cnum'`syer' "`actyn`cnum''`syer'",add;
		};
	};


		local actynf1 "France";
  		local actynf2 "Belgium";
  		local actynf3 "Netherlands";
  		local actynf4 "Germany";
  		local actynf5 "Italy";
  		local actynf6 "Luxembourg";
  		local actynf7 "Denmark";
  		local actynf8 "Ireland";
  		local actynf9 "United Kingdom";
  		local actynf11 "Greece";
  		local actynf12 "Spain";
  		local actynf13 "Portugal";
  		local actynf15 "Norway";
		local actynf16 "Finland";
		local actynf17 "Sweden";
		local actynf18 "Austria";
		local actynf20 "Canada";
		local actynf21 "Australia";
		local actynf22 "New Zealand";
		local actynf23 "United States";
		local actynf28 "Iceland";

	gen str2 countryname=" ";
	foreach cnum of numlist 1 2 3 4 5 6 7 8 9 11 12 13 15 16 17 18 20 21 22 23 28 {; 
		replace countryname="`actynf`cnum''" if cnumb==`cnum';
	};


	label variable twodigcty "two letter code for country";
	egen labctypty=concat(twodigcty smptynam);
	label variable labctypty "text for country party";

	label values labvar mylab;
	egen nameparty=concat(twodigcty labyear ptname);
	label variable nameparty "text with country year party";

	label values labvar mylab;
	egen ctyyrpty=concat(twodigcty labyear smptynam);
	label variable nameparty "shorter label for country year party";



/* generate the number of party groups that were used in the estimation */

sort studynum;
by studynum: egen npar=count(rnjwSPsm); /* makes no difference that I used this form of the DV */
label variable npar "number of groups in estimattion";


/* generate the number of party groups that were in the gov in the estimation */

sort studynum;
by studynum: egen ngovpar=sum(incumb); 
label variable ngovpar "number of groups in government who were in estimation";

/* generate the number of party groups that were in the opposition in the estimation */

gen nopppar=npar-ngovpar; 
label variable nopppar "number of groups in opposition who were in estimation";


/* construct the effective number of pm contenders calculated historical for group means */

sort(studynum);
egen sumpm60=sum(pmper60), by(studynum);
gen normpm60=pmper60/sumpm60;
gen sqnormpm60=normpm60*normpm60;
egen snormpm60=sum(sqnormpm60), by(studynum);
gen enpm60=1/snormpm60;
drop normpm60;
drop sqnormpm60;
drop snormpm60;
drop sumpm60;
label variable enpm60 "effective number of pms: calc from pmper60";

/* construct the effective number of pm contenders calculated historical for group sums */

sort(studynum);
egen sumsumpm60=sum(sumpmper60), by(studynum);
gen sumnormpm60=sumpmper60/sumsumpm60;
gen sumsqnormpm60=sumnormpm60*sumnormpm60;
egen sumsnormpm60=sum(sumsqnormpm60), by(studynum);
gen sumenpm60=1/sumsnormpm60;
drop sumnormpm60;
drop sumsqnormpm60;
drop sumsnormpm60;
drop sumsumpm60;
label variable sumenpm60 "effective number of pms: calc from sumpmper60";

/* construct the effective number of incumbent contenders calculated historical for group means */

sort(studynum);
egen suminc60=sum(incper60), by(studynum);
gen norminc60=incper60/suminc60;
gen sqnorminc60=norminc60*norminc60;
egen snorminc60=sum(sqnorminc60), by(studynum);
gen eninc60=1/snorminc60;
drop norminc60;
drop sqnorminc60;
drop snorminc60;
drop suminc60;
label variable eninc60 "effective number of incumbents: calc from incper60";

/* construct the effective number parties calculated predicted vote (rnpvSPmn) */

sort(studynum);
gen pvj=rnpvSPmn;
egen sumpv=sum(pvj), by(studynum);  /* this sums to 1 for all groups just to test */
gen sqpvj=pvj*pvj;
egen sumsqpvj=sum(sqpvj), by(studynum);
gen enpPV=1/sumsqpvj;
label variable enpPV "effective number of partis: calc from rnpvSPmn";
drop sumpv;
drop pvj;
drop sqpvj;
drop sumsqpvj;



/* construct the ranking of the parties from smallest to biggest based on
   predicted vote (rnpvSPmn).  Gives a unique rank with ties broken arbitarily */

sort(studynum);
gen pvj=rnpvSPmn;
egen rankpvj=rank(pvj), unique by(studynum);  
label variable rankpvj "rank order of party size 1 smallest: calc from rnpvSPmn";


/* construct the ranking of the parties from biggest to smallest based on
   predicted vote (rnpvSPmn).  Gives same rank to ties */

sort(studynum);
egen rankpvj2=rank(pvj), field by(studynum);  
label variable rankpvj2 "rank order of party size 1 biggest: calc from rnpvSPmn";

/* construct the difference between the biggest and next biggest based on
   predicted vote (rnpvSPmn) */

sort(studynum rankpvj);
*gen pvj=rnpvSPmn;
by studynum: gen nextguy=pvj[_n-1];
gen diffpvj=pvj-nextguy;
gen pdiffpvj=diffpvj/pvj;
replace diffpvj=. if rankpvj~=npar;
replace pdiffpvj=. if rankpvj~=npar;
sort(studynum);
by studynum:egen diff1st2nd=sum(diffpvj);
by studynum:egen pdiff1st2nd=sum(pdiffpvj);
label variable diff1st2nd "difference between 1st and second: calc from rnpvSPmn";
label variable pdiff1st2nd "percentage diff between 1st and second: calc from rnpvSPmn";
drop nextguy;
drop pvj;
drop diffpvj;
drop pdiffpvj;

/* construct the ranking of the parties from smallest to biggest based on
   votemackie.  Gives a unique rank with ties broken arbitarily */

sort(studynum);
gen pvj=votemackie/100;
egen rankpvjmackie=rank(pvj), unique by(studynum);  
label variable rankpvjmackie "rank order of party size 1 smallest: calc from votemackie";

/* construct the difference between the biggest and next biggest based on
   votemackie */

sort(studynum rankpvj);
by studynum: gen nextguy=pvj[_n-1];
gen diffpvj=pvj-nextguy;
gen pdiffpvj=diffpvj/pvj;
replace diffpvj=. if rankpvj~=npar;
replace pdiffpvj=. if rankpvj~=npar;
sort(studynum);
by studynum:egen diff1st2ndmackie=sum(diffpvj);
by studynum:egen pdiff1st2ndmackie=sum(pdiffpvj);
label variable diff1st2nd "difference between 1st and second: calc from votemackie";
label variable pdiff1st2nd "percentage diff between 1st and second: calc from votemackie";
drop nextguy;
drop pvj;
drop diffpvj;
drop pdiffpvj;



/* generate absolute value of party economic votes */

gen absrndw=abs(rndwSPsm);
label variable absrndw "absolute value of rndwSPsm";

/* squares of various variables */

gen sqincper60=incper60*incper60;
label variable sqincper60 "square of incper60";

gen sqpmper60=pmper60*pmper60;
label variable sqincper60 "square of incper60";


/* generate dummy variables for coaliton gov and minority gov */

gen coalgov=coalmin;
gen mingov=coalmin;
recode coalgov 2 3=1 1 4=0;
recode mingov 1 2=1 3 4=0;


/* generate difference in relevant election vote and marginals from survey and pred vote
   from estimation */

gen diffvotemarg=(votemackie/100)-rnfreq;
label variable diffvotemarg "difference in real vote in relevant election and freq in survey";

gen diffvotepv=(votemackie/100)-rnpvSPmn;
label variable diffvotepv "difference in real vote in relevant election and pv in estimation";


/* calculate time since or until relevant election */

gen studysdate=ym(studysyr,studysmo);
gen studyedate=ym(studyeyr,studyemo);
gen releldate=ym(relelyr,relelmo);

label variable studysdate "stata useable study start date";
label variable studyedate "stata useable study end date";
label variable releldate "stata useable relevant election date";

gen surveyperiod=studyedate-studysdate;
label variable surveyperiod "time survey in field in months";

gen proxtoelection=releldate-studysdate;
label variable proxtoelection "months before(neg) or after (pos) elec study started";

/* calculate time since last relevant election */

gen lasteldate=ym(lastelyr,lastelmo);
label variable lasteldate "stata useable last election date";

gen sincelastel=studysdate-lasteldate;
label variable proxtoelection "months since previous election (when survey started)";


/* calculate the weighted average of economic emphasis of parties in the election */


egen sumvote=sum(votemackie), by(studynum);
gen normvote=votemackie/sumvote;
gen eetemp=normvote*econemph_m;
egen wavgeconemph=sum(eetemp), by(studynum);
drop sumvote;
drop normvote;
drop eetemp;

/* mark the New zealand 99 case */

gen nzcase=0;
replace nzcase=1 if studynum==220501;

/* calculate the economic vote for incumbents as a group */

gen voteinc=rnjwSPsm*incumb;
gen voteincsl=rnjwSPsl*incumb;
gen voteincsu=rnjwSPsu*incumb;
egen rnjwinc=sum(voteinc), by(studynum);
egen rnjwincsl=sum(voteincsl), by(studynum);
egen rnjwincsu=sum(voteincsu), by(studynum);

label variable rnjwinc "sum of rnjwSPsm over incumbents in cab";
label variable rnjwincsl "sum of rnjwSPsl over incumbents in cab";
label variable rnjwincsu "sum of rnjwSPsu over incumbents in cab";
drop voteinc;
drop voteincsl;
drop voteincsu;


/* calculate the economic vote for incumbents as a group using rndwSPsm */

gen voteinc=rndwSPsm*incumb;
egen rndwinc=sum(voteinc), by(studynum);

label variable rndwinc "sum of rndwSPsm over incumbents in cab";

drop voteinc;



/* fix the nameparty varaible for the us */

replace nameparty="us00democrat" if nameparty=="us0democrat";
replace nameparty="us00replublican" if nameparty=="us0republican";

replace nameparty="us80republican" if nameparty=="us802" ;
replace nameparty="us82republican" if nameparty=="us822" ;
replace nameparty="us84republican" if nameparty=="us842" ;
replace nameparty="us86republican" if nameparty=="us862" ;
replace nameparty="us88republican" if nameparty=="us882" ;
replace nameparty="us90republican" if nameparty=="us902" ;
replace nameparty="us92republican" if nameparty=="us922" ;
replace nameparty="us94republican" if nameparty=="us942" ;
replace nameparty="us96republican" if nameparty=="us962" ;
replace nameparty="us98republican" if nameparty=="us982" ;
replace nameparty="us00republican" if nameparty=="us02" ;

replace nameparty="us80democrat" if nameparty=="us801" ;
replace nameparty="us82democrat" if nameparty=="us821" ;
replace nameparty="us84democrat" if nameparty=="us841" ;
replace nameparty="us86democrat" if nameparty=="us861" ;
replace nameparty="us88democrat" if nameparty=="us881" ;
replace nameparty="us90democrat" if nameparty=="us901" ;
replace nameparty="us92democrat" if nameparty=="us921" ;
replace nameparty="us94democrat" if nameparty=="us941" ;
replace nameparty="us96democrat" if nameparty=="us961" ;
replace nameparty="us98democrat" if nameparty=="us981" ;
replace nameparty="us00democrat" if nameparty=="us01" ;




/* reverse the main economic voting variables */
/*
replace rnjwSPsm=rnjwSPsm*-1;
replace rnjwSPsl=rnjwSPsl*-1;
replace rnjwSPsu=rnjwSPsu*-1;

replace rnjwinc=rnjwinc*-1;
replace rnjwincsl=rnjwincsl*-1;
replace rnjwincsu=rnjwincsu*-1;
*/












