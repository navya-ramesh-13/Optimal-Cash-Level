*This program merges the Industry sigma calculated for each year
Then I am merging this data with the main data using sic2 and nyear to get 
the corresponding gvkey2. This way in the final dataset merging, I can merge
Industry sigma with others using nyear and gvkey2;

libname tmp1 '\\apporto.com\dfs\SEA\Users\s116_sea\Desktop\FinANa\SAAS';
run;

data a1; set tmp1.sigma2020;run;
data a2; set tmp1.sigma1985 tmp1.sigma1986 tmp1.sigma1987 tmp1.sigma1988 tmp1.sigma1989
tmp1.sigma1990 tmp1.sigma1991 tmp1.sigma1992 tmp1.sigma1993 tmp1.sigma1994
tmp1.sigma1995 tmp1.sigma1996 tmp1.sigma1997 tmp1.sigma1998 tmp1.sigma1999
tmp1.sigma2000 tmp1.sigma2001 tmp1.sigma2002 tmp1.sigma2003 tmp1.sigma2004
tmp1.sigma2005 tmp1.sigma2006 tmp1.sigma2007 tmp1.sigma2008 tmp1.sigma2009
tmp1.sigma2010 tmp1.sigma2011 tmp1.sigma2012 tmp1.sigma2013 tmp1.sigma2014
tmp1.sigma2015 tmp1.sigma2016 tmp1.sigma2017 tmp1.sigma2018 tmp1.sigma2019
tmp1.sigma2020 tmp1.sigma2021 tmp1.sigma2022;run;

data a3; set a2;
if not missing(sigmacash);
proc sort; by nyear sic2;
proc print; run;
proc means; run;

data tmp1.m_sigma1975_2022; set a3;run;

data a4; set tmp1.industry_sigma_gvkey_dataset;
nyear = year(datadate);
if nyear>=1985;
gvkey2 = gvkey*1;
if gvkey2 ne ".";
sic2 = int(sic/100);
keep gvkey2 nyear sic2;
proc sort; by sic2 nyear;run; 
data a5; set tmp1.m_sigma1975_2022;
proc sort; by sic2 nyear; run;
data a6;
merge a4 a5;
by sic2 nyear;
if gvkey2 ne "."; run;
proc print data = a6 (obs=100); run;
data tmp1.industrysigmafinal1; set a6;
data tmp1.industrysigmafinal2; set a6;
data tmp1.industrysigmafinal3; set a6;
data tmp1.industrysigmafinal4; set a6;
proc means; run;

