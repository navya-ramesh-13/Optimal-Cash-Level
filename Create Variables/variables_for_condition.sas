*this program is used to get non missing che, positive- (at, sale),
non missing seq, SIC to exclude utilities and financial firms, prcc_c >= $2 
as per the suggestion in the paper.
However, here we are just picking the columns and the corresponding conditions
are added in the merge file;
libname tmp1 '\\apporto.com\dfs\SEA\Users\s116_sea\Desktop\FinANa\SAAS';
run;

data a1; set tmp1.newvariable;

nyear = year(datadate);
gvkey2 = gvkey*1;
data a2; set a1;
drop datadate fyear;
proc means; run;
