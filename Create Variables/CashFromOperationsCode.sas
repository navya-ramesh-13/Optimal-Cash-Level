*this program creates cash from operations;
libname tmp1 '\\apporto.com\dfs\SEA\Users\s116_sea\Desktop\FinANa\SAAS';
run;
data a1; set tmp1.cashfromoperationsdataset;
gvkey2=gvkey*1;
nyear = year(datadate);
if oancf="." then delete;
if che="." then delete;
if at="." then delete;
if (at-che)=0 then delete;
data a2; set a1;
CashFromOperations = oancf/(at-che);
data a3; set a2;
if CashFromOperations ne ".";
if nyear>=1975;
keep gvkey2 nyear CashFromOperations;
proc sort nodupkey; by gvkey2 nyear; 
data a4; set a3;
*proc print data=a4 (obs=100); *run;
data tmp1.CashFromOperations1; set a4;
data tmp1.CashFromOperations2; set a4;
data tmp1.CashFromOperations3; set a4;
data tmp1.CashFromOperations4; set a4;
proc means; run;


