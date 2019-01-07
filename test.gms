* -------------------------------
* Fruchtfolge Model - Include file
* Institute for Food an Resource Economics
* University of Bonn 
* (c) Christoph Pahmeyer, 2019
* -------------------------------

* Static data
set grossMarginAttr / price,yield,directCosts,varCosts /;
set plotAttr / size,distance,quality /;
set cropAttr / pause,maxShare,minSoilQuality,efaFactor/;
set symbol / lt,gt /;
set halfMonths / feb1,feb2,mar1,mar2,apr1,apr2,may1,may2,jun1,jun2,jul1,jul2,aug1,aug2,sep1,sep2,oct1,oct2,nov1,nov2 /;

set years / 2001*2019 /;
set curYear(years) / 2019 /;
set soilTypes / 
'Tonschluffe (tu)'
/;

set plots / 
'2019-01-07T17:04:54.631Z'
/;

parameter p_plotData(plots,plotAttr) /
'2019-01-07T17:04:54.631Z'.size 8.78
 '2019-01-07T17:04:54.631Z'.distance 0.4764
 '2019-01-07T17:04:54.631Z'.quality 70.5
/;

set plots_soilTypes(plots,soilTypes) /
'2019-01-07T17:04:54.631Z'.'Tonschluffe (tu)'
/;

set plots_rootCropCap(plots) /
'2019-01-07T17:04:54.631Z' YES
/;

set plots_permPast(plots) /
'2019-01-07T17:04:54.631Z' NO
/;
