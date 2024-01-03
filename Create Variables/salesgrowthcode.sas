*this program creates the sales growth;
libname tmp1 '\\apporto.com\dfs\SEA\Users\s116_sea\Desktop\FinANa\SAAS';
run;
data a1; set tmp1.salesgrowthdataset;
gvkey2=gvkey*1;
nyear=year(datadate);
if not missing(nyear);
if not missing(gvkey2);
if not missing(sale);
keep gvkey2 nyear sale;
proc sort nodupkey; by gvkey2 nyear; 
data a2; set a1; by gvkey2;
first_gvkey = first.gvkey2;
lag_sale = lag(SALE);
*new_gvkey=lag(gvkey2);
*first.gvkey2 condition is added to ensure that the variable does not pick the
lag value from a different gvkey2. The prior sale is set to lag(sale) only if it is
the previous sale of the same gvkey2, else it is set to 0;
if first_gvkey =0 then prior_sale = lag_sale;
if first_gvkey =1 then prior_sale = 0;
data a3; set a2;
*proc print data=a3 (obs=50); *run;
drop lag_sale;
if prior_sale ne 0;
Sales_Growth = (sale-prior_sale)/prior_sale;run;
data a4; set a3;
*proc print data=a4 (obs=200); *run;
if Sales_Growth ne ".";
if nyear>=1975;
proc sort nodupkey; by gvkey2 nyear;
data a5; set a4;
proc print data=a5 (obs=100); run;
data tmp1.Sales_Growth1; set a5;
data tmp1.Sales_Growth2; set a5;
data tmp1.Sales_Growth3; set a5;
data tmp1.Sales_Growth4; set a5;
proc means; run;

