*this program merges all the data
I am also creating the year dummies and Industry dummies in this code 
after merging all the other variable datasets;
libname tmp1 '\\apporto.com\dfs\SEA\Users\s116_sea\Desktop\FinANa\SAAS';
run;

data a1; set tmp1.size1;
proc sort nodupkey; by gvkey2 nyear;
data a2; set tmp1.nwcall1;
proc sort nodupkey; by gvkey2 nyear;
data a3; set tmp1.capxall1;
proc sort nodupkey; by gvkey2 nyear;
data a4; set tmp1.industrysigmafinal1;
proc sort nodupkey; by gvkey2 nyear;
data a5; set tmp1.randd1;
proc sort nodupkey; by gvkey2 nyear;
data a6; set tmp1.dividend_dummy1;
proc sort nodupkey; by gvkey2 nyear;
data a7; set tmp1.sales_growth1;
proc sort nodupkey; by gvkey2 nyear;
data a8; set tmp1.cashfromoperations1;
proc sort nodupkey; by gvkey2 nyear;
data a9; set tmp1.firmage1;
proc sort nodupkey; by gvkey2 nyear;
data a10; set tmp1.taxburdenonfinc1;
proc sort nodupkey; by gvkey2 nyear;
data a11; set tmp1.cashall1;
proc sort nodupkey; by gvkey2 nyear;
data a12; set tmp1.dmarank1;
proc sort nodupkey; by gvkey2 nyear;
data a23; set tmp1.newvar1;
proc sort nodupkey; by gvkey2 nyear;


data a13;
merge a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a23;
by gvkey2 nyear;
*proc means; *run;
data a14; set a13;
drop AT XRD prior_sale first_gvkey SALE firstyear; 
if size ne ".";
if nwc ne ".";
if capx2 ne ".";
if sigmacash ne ".";
if RandD ne ".";
if Dividend_Dummy ne ".";
if Sales_Growth ne ".";
if CashFromOperations ne ".";
if firmage ne ".";
if TaxBurdenOnFInc ne ".";
if dma ne ".";
if che2 ne ".";
if at > 0;
if sale > 0;
if seq ne ".";
if prcc_c >= 2;
if sic2 ne 40;
if sic2 ne 41;
if sic2 ne 42;
if sic2 ne 44;
if sic2 ne 45;
if sic2 ne 46;
if sic2 ne 47;
if sic2 ne 48;
if sic2 ne 49;
if sic2 ne 60;
if sic2 ne 61;
if sic2 ne 62;
if sic2 ne 63;
if sic2 ne 64;
if sic2 ne 65;
if sic2 ne 67;
*proc print data=a14 (obs=100); *run;
*proc means; run;
data a15; set a14;
proc sort; by nyear; 

*Handle the outliers;
proc means data=a15 p1 p99; 
var size nwc capx2 sigmacash RandD Sales_Growth CashFromOperations firmage 
	TaxBurdenOnFInc che2;
by nyear;
output out=winbreak1 p1=sizep1 nwcp1 capx2p1 sigmacashp1 RandDp1 Sales_Growthp1 CashFromOperationsp1 firmagep1 
	TaxBurdenOnFIncp1 che2p1
p99=sizep99 nwcp99 capx2p99 sigmacashp99 RandDp99 Sales_Growthp99 CashFromOperationsp99 firmagep99 
	TaxBurdenOnFIncp99 che2p99;
run;
data a16; set winbreak1;
proc sort; by nyear; 
data a17;
merge a16 a15;
by nyear;
*proc print data=a17 (obs=100); *run;
data a18; set a17;

if size<sizep1 then size=sizep1;
if size>sizep99 then size=sizep99;
if nwc<nwcp1 then nwc=nwcp1;
if nwc>nwcp99 then nwc=nwcp99;
if capx2<capx2p1 then capx2=capx2p1;
if capx2>capx2p99 then capx2=capx2p99;
if sigmacash<sigmacashp1 then sigmacash=sigmacashp1;
if sigmacash>sigmacashp99 then sigmacash=sigmacashp99;
if RandD<RandDp1 then RandD=RandDp1;
if RandD>RandDp99 then RandD=RandDp99;
if Sales_Growth<Sales_Growthp1 then Sales_Growth=Sales_Growthp1;
if Sales_Growth>Sales_Growthp99 then Sales_Growth=Sales_Growthp99;
if CashFromOperations<CashFromOperationsp1 then CashFromOperations=CashFromOperationsp1;
if CashFromOperations>CashFromOperationsp99 then CashFromOperations=CashFromOperationsp99;
if firmage<firmagep1 then firmage=firmagep1;
if firmage>firmagep99 then firmage=firmagep99;
if TaxBurdenOnFInc<TaxBurdenOnFIncp1 then TaxBurdenOnFInc=TaxBurdenOnFIncp1;
if TaxBurdenOnFInc>TaxBurdenOnFIncp99 then TaxBurdenOnFInc=TaxBurdenOnFIncp99;
if che2<che2p1 then che2=che2p1;
if che2>che2p99 then che2=che2p99;

drop sizep1 nwcp1 capx2p1 sigmacashp1 RandDp1 Sales_Growthp1 CashFromOperationsp1 firmagep1 
	TaxBurdenOnFIncp1 che2p1
 sizep99 nwcp99 capx2p99 sigmacashp99 RandDp99 Sales_Growthp99 CashFromOperationsp99 firmagep99 
	TaxBurdenOnFIncp99 che2p99
 _type_ _freq_;
*proc means; *run;




/* find out the distinct sic2 codes */
 

data a19; set a18;
keep gvkey2 nyear sic2;
proc sort nodupkey;  by sic2;
*proc print data=a19 (obs=500); run;

data a20; set a18;

/*create year dummies
removing one nyear to avoid multicollinearity or redundancy*/

if nyear = 1988 then year1988 = 1; else year1988 = 0;
if nyear = 1989 then year1989 = 1; else year1989 = 0;
if nyear = 1990 then year1990 = 1; else year1990 = 0;
if nyear = 1991 then year1991 = 1; else year1991 = 0;
if nyear = 1992 then year1992 = 1; else year1992 = 0;
if nyear = 1993 then year1993 = 1; else year1993 = 0;
if nyear = 1994 then year1994 = 1; else year1994 = 0;
if nyear = 1995 then year1995 = 1; else year1995 = 0;
if nyear = 1996 then year1996 = 1; else year1996 = 0;
if nyear = 1997 then year1997 = 1; else year1997 = 0;
if nyear = 1998 then year1998 = 1; else year1998 = 0;
if nyear = 1999 then year1999 = 1; else year1999 = 0;
if nyear = 2000 then year2000 = 1; else year2000 = 0;
if nyear = 2001 then year2001 = 1; else year2001 = 0;
if nyear = 2002 then year2002 = 1; else year2002 = 0;
if nyear = 2003 then year2003 = 1; else year2003 = 0;
if nyear = 2004 then year2004 = 1; else year2004 = 0;
if nyear = 2005 then year2005 = 1; else year2005 = 0;
if nyear = 2006 then year2006 = 1; else year2006 = 0;
if nyear = 2007 then year2007 = 1; else year2007 = 0;
if nyear = 2008 then year2008 = 1; else year2008 = 0;
if nyear = 2009 then year2009 = 1; else year2009 = 0;
if nyear = 2010 then year2010 = 1; else year2010 = 0;
if nyear = 2011 then year2011 = 1; else year2011 = 0;
if nyear = 2012 then year2012 = 1; else year2012 = 0;
if nyear = 2013 then year2013 = 1; else year2013 = 0;
if nyear = 2014 then year2014 = 1; else year2014 = 0;
if nyear = 2015 then year2015 = 1; else year2015 = 0;
if nyear = 2016 then year2016 = 1; else year2016 = 0;
if nyear = 2017 then year2017 = 1; else year2017 = 0;
if nyear = 2018 then year2018 = 1; else year2018 = 0;
if nyear = 2019 then year2019 = 1; else year2019 = 0;
if nyear = 2020 then year2020 = 1; else year2020 = 0;
if nyear = 2021 then year2021 = 1; else year2021 = 0;
if nyear = 2022 then year2022 = 1; else year2022 = 0;
*proc means; *run;


/* create industry dummies based on sic2 codes
removing one sic2 to avoid multicolinearity or redundancy*/
if sic2=2 then dsic2 = 1; else dsic2 = 0;
if sic2=7 then dsic7 = 1; else dsic7 = 0;
if sic2=8 then dsic8 = 1; else dsic8 = 0;
if sic2=9 then dsic9 = 1; else dsic9 = 0;
if sic2=10 then dsic10 = 1; else dsic10 = 0;
if sic2=12 then dsic12 = 1; else dsic12 = 0;
if sic2=13 then dsic13 = 1; else dsic13 = 0;
if sic2=14 then dsic14 = 1; else dsic14 = 0;
if sic2=15 then dsic15 = 1; else dsic15 = 0;
if sic2=16 then dsic16 = 1; else dsic16 = 0;
if sic2=17 then dsic17 = 1; else dsic17 = 0;
if sic2=20 then dsic20 = 1; else dsic20 = 0;
if sic2=21 then dsic21 = 1; else dsic21 = 0;
if sic2=22 then dsic22 = 1; else dsic22 = 0;
if sic2=23 then dsic23 = 1; else dsic23 = 0;
if sic2=24 then dsic24 = 1; else dsic24 = 0;
if sic2=25 then dsic25 = 1; else dsic25 = 0;
if sic2=26 then dsic26 = 1; else dsic26 = 0;
if sic2=27 then dsic27 = 1; else dsic27 = 0;
if sic2=28 then dsic28 = 1; else dsic28 = 0;
if sic2=29 then dsic29 = 1; else dsic29 = 0;
if sic2=30 then dsic30 = 1; else dsic30 = 0;
if sic2=31 then dsic31 = 1; else dsic31 = 0;
if sic2=32 then dsic32 = 1; else dsic32 = 0;
if sic2=33 then dsic33 = 1; else dsic33 = 0;
if sic2=34 then dsic34 = 1; else dsic34 = 0;
if sic2=35 then dsic35 = 1; else dsic35 = 0;
if sic2=36 then dsic36 = 1; else dsic36 = 0;
if sic2=37 then dsic37 = 1; else dsic37 = 0;
if sic2=38 then dsic38 = 1; else dsic38 = 0;
if sic2=39 then dsic39 = 1; else dsic39 = 0;
if sic2=50 then dsic50 = 1; else dsic50 = 0;
if sic2=51 then dsic51 = 1; else dsic51 = 0;
if sic2=52 then dsic52 = 1; else dsic52 = 0;
if sic2=53 then dsic53 = 1; else dsic53 = 0;
if sic2=54 then dsic54 = 1; else dsic54 = 0;
if sic2=55 then dsic55 = 1; else dsic55 = 0;
if sic2=56 then dsic56 = 1; else dsic56 = 0;
if sic2=57 then dsic57 = 1; else dsic57 = 0;
if sic2=58 then dsic58 = 1; else dsic58 = 0;
if sic2=59 then dsic59 = 1; else dsic59 = 0;
if sic2=70 then dsic70 = 1; else dsic70 = 0;
if sic2=72 then dsic72 = 1; else dsic72 = 0;
if sic2=73 then dsic73 = 1; else dsic73 = 0;
if sic2=75 then dsic75 = 1; else dsic75 = 0;
if sic2=76 then dsic76 = 1; else dsic76 = 0;
if sic2=78 then dsic78 = 1; else dsic78 = 0;
if sic2=79 then dsic79 = 1; else dsic79 = 0;
if sic2=80 then dsic80 = 1; else dsic80 = 0;
if sic2=81 then dsic81 = 1; else dsic81 = 0;
if sic2=82 then dsic82 = 1; else dsic82 = 0;
if sic2=83 then dsic83 = 1; else dsic83 = 0;
if sic2=86 then dsic86 = 1; else dsic86 = 0;
if sic2=87 then dsic87 = 1; else dsic87 = 0;
if sic2=89 then dsic89 = 1; else dsic89 = 0;
if sic2=99 then dsic99 = 1; else dsic99 = 0;

proc means; run;


data a21; set a20; run;
proc means data=a21 n mean std median p25 p50 p75;
   var size nwc capx2 sigmacash RandD Dividend_Dummy Sales_Growth CashFromOperations firmage
	TaxBurdenOnFInc che2 dma;
run;

proc reg data=a21;
  model che2 = size nwc capx2 sigmacash RandD Dividend_Dummy Sales_Growth 
	CashFromOperations firmage TaxBurdenOnFInc dma
	year1988 year1989 year1990 year1991 year1992 year1993 year1994 year1995 year1996
	year1997 year1998 year1999 year2000 year2001 year2002 year2003 year2004 year2005
	year2006 year2007 year2008 year2009 year2010 year2011 year2012 year2013 year2014
	year2015 year2016 year2017 year2018 year2019 year2020 
	dsic2 dsic7 dsic8 dsic9 dsic10 dsic12 dsic13 dsic14 dsic15 dsic16 dsic17 dsic20
	dsic21 dsic22 dsic23 dsic24 dsic25 dsic26 dsic27 dsic28 dsic29 dsic30 dsic31
	dsic32 dsic33 dsic34 dsic35 dsic36 dsic37 dsic38 dsic39 dsic50 dsic51 dsic52 dsic53 dsic54
	dsic55 dsic56 dsic57 dsic58 dsic59 dsic70 dsic72 dsic73 dsic75 dsic76 dsic78 dsic79 dsic80 dsic81 dsic82
	dsic83 dsic86 dsic87 dsic89 dsic99;
run;


data a22; set a20;
proc corr; 
var che2 size nwc capx2 sigmacash RandD Dividend_Dummy Sales_Growth 
	CashFromOperations firmage TaxBurdenOnFInc;
run;

