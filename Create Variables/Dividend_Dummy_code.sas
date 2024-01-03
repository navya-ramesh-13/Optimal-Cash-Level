*this program creates the Dididend Dummy;
libname tmp1 '\\apporto.com\dfs\SEA\Users\s116_sea\Desktop\FinANa\SAAS';
run;
data a1; set tmp1.dividenddummydataset;
gvkey2=gvkey*1;
nyear=year(datadate);
if not missing(nyear);
if not missing(gvkey2);
if dvc = "." then dvc=0;
keep gvkey2 dvc nyear ;
proc sort nodupkey; by gvkey2 nyear; 
data a2; set a1; by gvkey2;
Dividend_Dummy = 0;
*first.gvkey2 condition is added to ensure that the variable does not pick the
lag value from a different gvkey2. The dummy is set to 1 only if the previous DVC
of the same gvkey2 has a value;
if lag(DVC) ne 0 and first.gvkey2 = 0 then Dividend_Dummy = 1;
if first.gvkey2 = 1 then Dividend_Dummy = 0;
data a3; set a2;
*proc print data=a3 (obs=200); *run;
if nyear>=1975;
*proc print data=a3 (obs=200); *run;
proc sort nodupkey; by gvkey2 nyear;
data a4; set a3;
keep gvkey2 nyear Dividend_Dummy ;
proc print data=a4 (obs=500); run;
data tmp1.Dividend_Dummy1; set a4;
data tmp1.Dividend_Dummy2; set a4;
data tmp1.Dividend_Dummy3; set a4;
data tmp1.Dividend_Dummy4; set a4;
proc means; run;

