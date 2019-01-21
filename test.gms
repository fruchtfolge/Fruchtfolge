* -------------------------------
* Fruchtfolge Model - Include file
* Institute for Food an Resource Economics
* University of Bonn
* (c) Christoph Pahmeyer, 2019
* -------------------------------

* Static data
set grossMarginAttr / price,yield,directCosts,variableCosts,fixCosts,grossMargin,revenue,distanceCosts,croppingFactor,yieldCap /;
set plotAttr / size,distance,quality /;
set cropAttr / rotBreak,maxShare,minSoilQuality,efaFactor/;
set symbol / lt,gt /;
set halfMonths / jan1,jan2,feb1,feb2,MRZ1,MRZ2,apr1,apr2,mai1,mai2,jun1,jun2,jul1,jul2,aug1,aug2,sep1,sep2,okt1,okt2,nov1,nov2,dez1,dez2 /;

set years / 2001*2018 /;
set curYear(years) / 2018 /;
set soilTypes /
'Tonschluffe (tu)'
'Tonlehme (tl)'
/;

set plots /
 '37'
 '372'
 '1002'
 '1007'
 '1005'
 '115'
 '62'
 '2'
 '201'
 '137'
 '1011'
 '1050'
 '112'
 '119'
 '1010'
 '1016'
 '77'
 '1006'
 '121'
 '371'
 '1371'
 '571'
 '130'
 '901'
 '9'
 '39'
 '48'
 '113'
 '574'
 '1015'
 '573'
 '1181'
 '6'
 '462'
 '1004'
 '43'
 '122'
 '123'
 '1019'
 '41'
 '1012'
 '1008'
 '1003'
 '1013'
 '120'
 '1'
 '1018'
 '88'
 '86'
 '881'
 '75'
 '54'
 '56'
 '67'
 '38'
 '114'
 '126'
 '131'
 '127'
 '128'
 '136'
 '125'
 '481'
 '138'
 '118'
 '46'
 '461'
 '117'
 '132'
 '111'
 '95'
 '1014'
 '73'
 '1009'
 '140'
 '133'
 '1251'
 '135'
 '463'
 '464'
 '1252'
 '134'
 '465'
 '1171'
 '1131'
 '116'
 '66'
 '96'
 '55'
 '671'
 '10'
 '69'
 '74'
 '1001'
 '1141'
 '61'
/;

set curPlots(plots) /
 '372'
 '37'
 '1002'
 '1007'
 '1005'
 '115'
 '62'
 '137'
 '1011'
 '1050'
 '119'
 '1016'
 '1006'
 '371'
 '201'
 '2'
 '1371'
 '112'
 '1010'
 '121'
 '130'
 '901'
 '113'
 '1015'
 '1181'
 '462'
 '1019'
 '41'
 '75'
 '88'
 '86'
 '56'
 '67'
 '571'
 '126'
 '131'
 '127'
 '128'
 '125'
 '136'
 '9'
 '39'
 '481'
 '48'
 '138'
 '574'
 '573'
 '118'
 '6'
 '117'
 '46'
 '132'
 '1004'
 '95'
 '43'
 '1014'
 '1012'
 '73'
 '1008'
 '1003'
 '1009'
 '1013'
 '140'
 '120'
 '135'
 '133'
 '134'
 '1'
 '1018'
 '66'
 '96'
 '54'
 '55'
 '671'
 '10'
 '69'
 '38'
 '74'
 '1001'
 '114'
 '1141'
 '61'
/;

parameter p_plotData(curPlots,plotAttr) /
 '372'.size 0.27
 '372'.distance 1
 '372'.quality 70.5
 '37'.size 0.32
 '37'.distance 1
 '37'.quality 70.5
 '1002'.size 1.43
 '1002'.distance 1
 '1002'.quality 73.5
 '1007'.size 5.61
 '1007'.distance 1
 '1007'.quality 76.5
 '1005'.size 3.27
 '1005'.distance 1
 '1005'.quality 76.5
 '115'.size 2.62
 '115'.distance 1
 '115'.quality 73.5
 '62'.size 0.36
 '62'.distance 1
 '62'.quality 70.5
 '137'.size 2.33
 '137'.distance 1
 '137'.quality 76.5
 '1011'.size 1.53
 '1011'.distance 1
 '1011'.quality 70.5
 '1050'.size 3.45
 '1050'.distance 1
 '1050'.quality 70.5
 '119'.size 6.22
 '119'.distance 1
 '119'.quality 70.5
 '1016'.size 1.33
 '1016'.distance 1
 '1016'.quality 0
 '1006'.size 5.71
 '1006'.distance 1
 '1006'.quality 73.5
 '371'.size 0.57
 '371'.distance 1
 '371'.quality 70.5
 '201'.size 3.13
 '201'.distance 1
 '201'.quality 70.5
 '2'.size 9.81
 '2'.distance 1
 '2'.quality 70.5
 '1371'.size 6.08
 '1371'.distance 1
 '1371'.quality 70.5
 '112'.size 1.15
 '112'.distance 1
 '112'.quality 67.5
 '1010'.size 3.13
 '1010'.distance 1
 '1010'.quality 73.5
 '121'.size 7.66
 '121'.distance 1
 '121'.quality 76.5
 '130'.size 2.78
 '130'.distance 1
 '130'.quality 70.5
 '901'.size 5.99
 '901'.distance 1
 '901'.quality 70.5
 '113'.size 3
 '113'.distance 1
 '113'.quality 73.5
 '1015'.size 3.42
 '1015'.distance 1
 '1015'.quality 76.5
 '1181'.size 2.84
 '1181'.distance 1
 '1181'.quality 70.5
 '462'.size 4.25
 '462'.distance 1
 '462'.quality 70.5
 '1019'.size 2.49
 '1019'.distance 1
 '1019'.quality 70.5
 '41'.size 2.92
 '41'.distance 1
 '41'.quality 70.5
 '75'.size 0.79
 '75'.distance 1
 '75'.quality 66
 '88'.size 2.33
 '88'.distance 1
 '88'.quality 69
 '86'.size 0.88
 '86'.distance 1
 '86'.quality 69
 '56'.size 3.69
 '56'.distance 1
 '56'.quality 70.5
 '67'.size 1.98
 '67'.distance 1
 '67'.quality 67.5
 '571'.size 7.5
 '571'.distance 1
 '571'.quality 70.5
 '126'.size 0.84
 '126'.distance 1
 '126'.quality 0
 '131'.size 1.59
 '131'.distance 1
 '131'.quality 70.5
 '127'.size 0.93
 '127'.distance 1
 '127'.quality 73.5
 '128'.size 3.2
 '128'.distance 1
 '128'.quality 70.5
 '125'.size 8.41
 '125'.distance 1
 '125'.quality 67.5
 '136'.size 1.03
 '136'.distance 1
 '136'.quality 64.5
 '9'.size 10.29
 '9'.distance 1
 '9'.quality 70.5
 '39'.size 1.44
 '39'.distance 1
 '39'.quality 70.5
 '481'.size 1.96
 '481'.distance 1
 '481'.quality 70.5
 '48'.size 3.85
 '48'.distance 1
 '48'.quality 76.5
 '138'.size 6.69
 '138'.distance 1
 '138'.quality 70.5
 '574'.size 1.36
 '574'.distance 1
 '574'.quality 70.5
 '573'.size 1.74
 '573'.distance 1
 '573'.quality 70.5
 '118'.size 0.2
 '118'.distance 1
 '118'.quality 70.5
 '6'.size 2.55
 '6'.distance 1
 '6'.quality 73.5
 '117'.size 1.26
 '117'.distance 1
 '117'.quality 70.5
 '46'.size 2.8
 '46'.distance 1
 '46'.quality 70.5
 '132'.size 0.41
 '132'.distance 1
 '132'.quality 67.5
 '1004'.size 1.71
 '1004'.distance 1
 '1004'.quality 76.5
 '95'.size 5.16
 '95'.distance 1
 '95'.quality 70.5
 '43'.size 5.41
 '43'.distance 1
 '43'.quality 70.5
 '1014'.size 2.13
 '1014'.distance 1
 '1014'.quality 70.5
 '1012'.size 5.75
 '1012'.distance 1
 '1012'.quality 70.5
 '73'.size 1.51
 '73'.distance 1
 '73'.quality 64.5
 '1008'.size 4
 '1008'.distance 1
 '1008'.quality 76.5
 '1003'.size 2.6
 '1003'.distance 1
 '1003'.quality 76.5
 '1009'.size 0.83
 '1009'.distance 1
 '1009'.quality 70.5
 '1013'.size 2.74
 '1013'.distance 1
 '1013'.quality 70.5
 '140'.size 1.64
 '140'.distance 1
 '140'.quality 70.5
 '120'.size 1.97
 '120'.distance 1
 '120'.quality 76.5
 '135'.size 0.03
 '135'.distance 1
 '135'.quality 67.5
 '133'.size 1.56
 '133'.distance 1
 '133'.quality 67.5
 '134'.size 0.1
 '134'.distance 1
 '134'.quality 0
 '1'.size 3.93
 '1'.distance 1
 '1'.quality 70.5
 '1018'.size 3.77
 '1018'.distance 1
 '1018'.quality 73.5
 '66'.size 3.66
 '66'.distance 1
 '66'.quality 64.5
 '96'.size 0.56
 '96'.distance 1
 '96'.quality 67.5
 '54'.size 5.06
 '54'.distance 1
 '54'.quality 70.5
 '55'.size 3.74
 '55'.distance 1
 '55'.quality 70.5
 '671'.size 3.59
 '671'.distance 1
 '671'.quality 67.5
 '10'.size 0.7
 '10'.distance 1
 '10'.quality 73.5
 '69'.size 0.94
 '69'.distance 1
 '69'.quality 73.5
 '38'.size 1.26
 '38'.distance 1
 '38'.quality 70.5
 '74'.size 3.15
 '74'.distance 1
 '74'.quality 70.5
 '1001'.size 1.41
 '1001'.distance 1
 '1001'.quality 70.5
 '114'.size 0.59
 '114'.distance 1
 '114'.quality 70.5
 '1141'.size 1.71
 '1141'.distance 1
 '1141'.quality 70.5
 '61'.size 0.26
 '61'.distance 1
 '61'.quality 70.5
/;

set plots_soilTypes(curPlots,soilTypes) /
 '372'.'Tonschluffe (tu)'
 '37'.'Tonschluffe (tu)'
 '1002'.'Tonschluffe (tu)'
 '1007'.'Tonschluffe (tu)'
 '1005'.'Tonschluffe (tu)'
 '115'.'Tonschluffe (tu)'
 '62'.'Tonschluffe (tu)'
 '137'.'Tonschluffe (tu)'
 '1011'.'Tonschluffe (tu)'
 '1050'.'Tonschluffe (tu)'
 '119'.'Tonschluffe (tu)'
 '1016'.'Tonschluffe (tu)'
 '1006'.'Tonschluffe (tu)'
 '371'.'Tonschluffe (tu)'
 '201'.'Tonschluffe (tu)'
 '2'.'Tonschluffe (tu)'
 '1371'.'Tonschluffe (tu)'
 '112'.'Tonschluffe (tu)'
 '1010'.'Tonschluffe (tu)'
 '121'.'Tonschluffe (tu)'
 '130'.'Tonschluffe (tu)'
 '901'.'Tonschluffe (tu)'
 '113'.'Tonschluffe (tu)'
 '1015'.'Tonschluffe (tu)'
 '1181'.'Tonschluffe (tu)'
 '462'.'Tonschluffe (tu)'
 '1019'.'Tonschluffe (tu)'
 '41'.'Tonschluffe (tu)'
 '75'.'Tonlehme (tl)'
 '88'.'Tonlehme (tl)'
 '86'.'Tonlehme (tl)'
 '56'.'Tonschluffe (tu)'
 '67'.'Tonschluffe (tu)'
 '571'.'Tonschluffe (tu)'
 '126'.'Tonschluffe (tu)'
 '131'.'Tonschluffe (tu)'
 '127'.'Tonschluffe (tu)'
 '128'.'Tonschluffe (tu)'
 '125'.'Tonschluffe (tu)'
 '136'.'Tonschluffe (tu)'
 '9'.'Tonschluffe (tu)'
 '39'.'Tonschluffe (tu)'
 '481'.'Tonschluffe (tu)'
 '48'.'Tonschluffe (tu)'
 '138'.'Tonschluffe (tu)'
 '574'.'Tonschluffe (tu)'
 '573'.'Tonschluffe (tu)'
 '118'.'Tonschluffe (tu)'
 '6'.'Tonschluffe (tu)'
 '117'.'Tonschluffe (tu)'
 '46'.'Tonschluffe (tu)'
 '132'.'Tonschluffe (tu)'
 '1004'.'Tonschluffe (tu)'
 '95'.'Tonschluffe (tu)'
 '43'.'Tonschluffe (tu)'
 '1014'.'Tonschluffe (tu)'
 '1012'.'Tonschluffe (tu)'
 '73'.'Tonschluffe (tu)'
 '1008'.'Tonschluffe (tu)'
 '1003'.'Tonschluffe (tu)'
 '1009'.'Tonschluffe (tu)'
 '1013'.'Tonschluffe (tu)'
 '140'.'Tonschluffe (tu)'
 '120'.'Tonschluffe (tu)'
 '135'.'Tonschluffe (tu)'
 '133'.'Tonschluffe (tu)'
 '134'.'Tonschluffe (tu)'
 '1'.'Tonschluffe (tu)'
 '1018'.'Tonschluffe (tu)'
 '66'.'Tonschluffe (tu)'
 '96'.'Tonschluffe (tu)'
 '54'.'Tonschluffe (tu)'
 '55'.'Tonschluffe (tu)'
 '671'.'Tonschluffe (tu)'
 '10'.'Tonschluffe (tu)'
 '69'.'Tonschluffe (tu)'
 '38'.'Tonschluffe (tu)'
 '74'.'Tonschluffe (tu)'
 '1001'.'Tonschluffe (tu)'
 '114'.'Tonschluffe (tu)'
 '1141'.'Tonschluffe (tu)'
 '61'.'Tonschluffe (tu)'
/;

set plots_rootCropCap(curPlots) /
 '372' 'YES'
 '37' 'YES'
 '1002' 'YES'
 '1007' 'YES'
 '1005' 'YES'
 '115' 'YES'
 '62' 'YES'
 '137' 'YES'
 '1011' 'YES'
 '1050' 'YES'
 '119' 'YES'
 '1016' 'YES'
 '1006' 'YES'
 '371' 'YES'
 '201' 'YES'
 '2' 'YES'
 '1371' 'YES'
 '112' 'YES'
 '1010' 'YES'
 '121' 'YES'
 '130' 'YES'
 '901' 'YES'
 '113' 'YES'
 '1015' 'YES'
 '1181' 'YES'
 '462' 'YES'
 '1019' 'YES'
 '41' 'YES'
 '75' 'YES'
 '88' 'YES'
 '86' 'YES'
 '56' 'YES'
 '67' 'YES'
 '571' 'YES'
 '126' 'YES'
 '131' 'YES'
 '127' 'YES'
 '128' 'YES'
 '125' 'YES'
 '136' 'YES'
 '9' 'YES'
 '39' 'YES'
 '481' 'YES'
 '48' 'YES'
 '138' 'YES'
 '574' 'YES'
 '573' 'YES'
 '118' 'YES'
 '6' 'YES'
 '117' 'YES'
 '46' 'YES'
 '132' 'YES'
 '1004' 'YES'
 '95' 'YES'
 '43' 'YES'
 '1014' 'YES'
 '1012' 'YES'
 '73' 'YES'
 '1008' 'YES'
 '1003' 'YES'
 '1009' 'YES'
 '1013' 'YES'
 '140' 'YES'
 '120' 'YES'
 '135' 'YES'
 '133' 'YES'
 '134' 'YES'
 '1' 'YES'
 '1018' 'YES'
 '66' 'YES'
 '96' 'YES'
 '54' 'YES'
 '55' 'YES'
 '671' 'YES'
 '10' 'YES'
 '69' 'YES'
 '38' 'YES'
 '74' 'YES'
 '1001' 'YES'
 '114' 'YES'
 '1141' 'YES'
 '61' 'YES'
/;

set plots_permPast(curPlots) /
 '62' 'YES'
 '132' 'YES'
 '135' 'YES'
 '133' 'YES'
 '134' 'YES'
 '66' 'YES'
 '96' 'YES'
 '10' 'YES'
 '74' 'YES'
 '61' 'YES'
/;

set crops /
 ''
 'Acker-/Puff-/Pferdebohne'
 'Erbsen zur Körnergewinnung'
 'Kartoffeln'
 'Möhre (auch Futtermöhre)'
 'Silomais (als Hauptfutter)'
 'Wintergerste'
 'Winterweichweizen'
 'Zuckerrüben'
 'Zwiebeln/Lauch'
/;

set curCrops(crops) /
 ''
 'Acker-/Puff-/Pferdebohne'
 'Kartoffeln'
 'Möhre (auch Futtermöhre)'
 'Silomais (als Hauptfutter)'
 'Winterweichweizen'
 'Zuckerrüben'
 'Zwiebeln/Lauch'
/;

set cropGroup /
 ''
 'Gattung: Vicia (Wicken)'
 'Art: Solanum tuberosum (Kartoffel)'
 'Gattung: Daucus (Möhren)'
 'Gattung: Zea (Mais)'
 'Winterweizen'
 'Gattung: Beta (Rüben)'
 'Gattung: Allium (Lauch)'
/;

set crops_cropGroup(curCrops,cropGroup) /
 ''.''
 'Acker-/Puff-/Pferdebohne'.'Gattung: Vicia (Wicken)'
 'Kartoffeln'.'Art: Solanum tuberosum (Kartoffel)'
 'Möhre (auch Futtermöhre)'.'Gattung: Daucus (Möhren)'
 'Silomais (als Hauptfutter)'.'Gattung: Zea (Mais)'
 'Winterweichweizen'.'Winterweizen'
 'Zuckerrüben'.'Gattung: Beta (Rüben)'
 'Zwiebeln/Lauch'.'Gattung: Allium (Lauch)'
/;

parameter p_cropData(curCrops,cropAttr) /
 'Acker-/Puff-/Pferdebohne'.rotBreak 2
 'Acker-/Puff-/Pferdebohne'.maxShare 50
 'Acker-/Puff-/Pferdebohne'.minSoilQuality 20
 'Acker-/Puff-/Pferdebohne'.efaFactor 0
 'Kartoffeln'.rotBreak 2
 'Kartoffeln'.maxShare 50
 'Kartoffeln'.minSoilQuality 20
 'Kartoffeln'.efaFactor 0
 'Möhre (auch Futtermöhre)'.rotBreak 2
 'Möhre (auch Futtermöhre)'.maxShare 50
 'Möhre (auch Futtermöhre)'.minSoilQuality 20
 'Möhre (auch Futtermöhre)'.efaFactor 0
 'Silomais (als Hauptfutter)'.rotBreak 2
 'Silomais (als Hauptfutter)'.maxShare 50
 'Silomais (als Hauptfutter)'.minSoilQuality 20
 'Silomais (als Hauptfutter)'.efaFactor 0
 'Winterweichweizen'.rotBreak 2
 'Winterweichweizen'.maxShare 50
 'Winterweichweizen'.minSoilQuality 20
 'Winterweichweizen'.efaFactor 0
 'Zuckerrüben'.rotBreak 2
 'Zuckerrüben'.maxShare 50
 'Zuckerrüben'.minSoilQuality 20
 'Zuckerrüben'.efaFactor 0
 'Zwiebeln/Lauch'.rotBreak 2
 'Zwiebeln/Lauch'.maxShare 50
 'Zwiebeln/Lauch'.minSoilQuality 20
 'Zwiebeln/Lauch'.efaFactor 0
/;

parameter p_croppingFactor(curCrops,curCrops) /
 'Acker-/Puff-/Pferdebohne'.'Acker-/Puff-/Pferdebohne' 2
 'Acker-/Puff-/Pferdebohne'.'Kartoffeln' 10
 'Acker-/Puff-/Pferdebohne'.'Möhre (auch Futtermöhre)' 4
 'Acker-/Puff-/Pferdebohne'.'Silomais (als Hauptfutter)' 10
 'Acker-/Puff-/Pferdebohne'.'Winterweichweizen' 10
 'Acker-/Puff-/Pferdebohne'.'Zuckerrüben' 10
 'Acker-/Puff-/Pferdebohne'.'Zwiebeln/Lauch' 4
 'Kartoffeln'.'Acker-/Puff-/Pferdebohne' 8
 'Kartoffeln'.'Kartoffeln' 2
 'Kartoffeln'.'Möhre (auch Futtermöhre)' 4
 'Kartoffeln'.'Silomais (als Hauptfutter)' 8
 'Kartoffeln'.'Winterweichweizen' 10
 'Kartoffeln'.'Zuckerrüben' 10
 'Kartoffeln'.'Zwiebeln/Lauch' 4
 'Möhre (auch Futtermöhre)'.'Acker-/Puff-/Pferdebohne' 4
 'Möhre (auch Futtermöhre)'.'Kartoffeln' 6
 'Möhre (auch Futtermöhre)'.'Möhre (auch Futtermöhre)' 4
 'Möhre (auch Futtermöhre)'.'Silomais (als Hauptfutter)' 10
 'Möhre (auch Futtermöhre)'.'Winterweichweizen' 8
 'Möhre (auch Futtermöhre)'.'Zuckerrüben' 3
 'Möhre (auch Futtermöhre)'.'Zwiebeln/Lauch' 4
 'Silomais (als Hauptfutter)'.'Acker-/Puff-/Pferdebohne' 10
 'Silomais (als Hauptfutter)'.'Kartoffeln' 10
 'Silomais (als Hauptfutter)'.'Möhre (auch Futtermöhre)' 4
 'Silomais (als Hauptfutter)'.'Silomais (als Hauptfutter)' 8
 'Silomais (als Hauptfutter)'.'Winterweichweizen' 8
 'Silomais (als Hauptfutter)'.'Zuckerrüben' 4
 'Silomais (als Hauptfutter)'.'Zwiebeln/Lauch' 4
 'Winterweichweizen'.'Acker-/Puff-/Pferdebohne' 10
 'Winterweichweizen'.'Kartoffeln' 10
 'Winterweichweizen'.'Möhre (auch Futtermöhre)' 10
 'Winterweichweizen'.'Silomais (als Hauptfutter)' 10
 'Winterweichweizen'.'Winterweichweizen' 4
 'Winterweichweizen'.'Zuckerrüben' 10
 'Winterweichweizen'.'Zwiebeln/Lauch' 10
 'Zuckerrüben'.'Acker-/Puff-/Pferdebohne' 6
 'Zuckerrüben'.'Kartoffeln' 8
 'Zuckerrüben'.'Möhre (auch Futtermöhre)' 4
 'Zuckerrüben'.'Silomais (als Hauptfutter)' 8
 'Zuckerrüben'.'Winterweichweizen' 8
 'Zuckerrüben'.'Zuckerrüben' 2
 'Zuckerrüben'.'Zwiebeln/Lauch' 4
 'Zwiebeln/Lauch'.'Acker-/Puff-/Pferdebohne' 4
 'Zwiebeln/Lauch'.'Kartoffeln' 6
 'Zwiebeln/Lauch'.'Möhre (auch Futtermöhre)' 4
 'Zwiebeln/Lauch'.'Silomais (als Hauptfutter)' 10
 'Zwiebeln/Lauch'.'Winterweichweizen' 8
 'Zwiebeln/Lauch'.'Zuckerrüben' 3
 'Zwiebeln/Lauch'.'Zwiebeln/Lauch' 4
/;

set plots_years_crops(plots,years,crops) /
 '37'.2016.'Wintergerste' 'YES'
 '37'.2017.'Zuckerrüben' 'YES'
 '372'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '37'.2018.'Silomais (als Hauptfutter)' 'YES'
 '1002'.2016.'Silomais (als Hauptfutter)' 'YES'
 '1002'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '1002'.2018.'Silomais (als Hauptfutter)' 'YES'
 '1007'.2016.'Wintergerste' 'YES'
 '1007'.2018.'Winterweichweizen' 'YES'
 '1005'.2017.'Winterweichweizen' 'YES'
 '1005'.2018.'Zuckerrüben' 'YES'
 '115'.2017.'Wintergerste' 'YES'
 '115'.2018.'Silomais (als Hauptfutter)' 'YES'
 '2'.2016.'Silomais (als Hauptfutter)' 'YES'
 '201'.2016.'Silomais (als Hauptfutter)' 'YES'
 '2'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '201'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '137'.2017.'Winterweichweizen' 'YES'
 '137'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '1011'.2016.'Wintergerste' 'YES'
 '1011'.2018.'Silomais (als Hauptfutter)' 'YES'
 '1050'.2018.'Winterweichweizen' 'YES'
 '112'.2016.'Wintergerste' 'YES'
 '112'.2017.'Silomais (als Hauptfutter)' 'YES'
 '119'.2017.'Winterweichweizen' 'YES'
 '119'.2018.'Zuckerrüben' 'YES'
 '1016'.2017.'Winterweichweizen' 'YES'
 '1016'.2018.'Silomais (als Hauptfutter)' 'YES'
 '77'.2017.'Winterweichweizen' 'YES'
 '1006'.2016.'Zuckerrüben' 'YES'
 '1006'.2018.'Winterweichweizen' 'YES'
 '121'.2017.'Winterweichweizen' 'YES'
 '371'.2018.'Zwiebeln/Lauch' 'YES'
 '1007'.2017.'Kartoffeln' 'YES'
 '1005'.2016.'Kartoffeln' 'YES'
 '115'.2016.'Kartoffeln' 'YES'
 '201'.2018.'Kartoffeln' 'YES'
 '2'.2018.'Kartoffeln' 'YES'
 '137'.2016.'Kartoffeln' 'YES'
 '1371'.2018.'Zwiebeln/Lauch' 'YES'
 '1011'.2017.'Kartoffeln' 'YES'
 '112'.2018.'Kartoffeln' 'YES'
 '119'.2016.'Kartoffeln' 'YES'
 '1010'.2017.'Zwiebeln/Lauch' 'YES'
 '1010'.2018.'Kartoffeln' 'YES'
 '1016'.2016.'Kartoffeln' 'YES'
 '77'.2016.'Erbsen zur Körnergewinnung' 'YES'
 '1006'.2017.'Kartoffeln' 'YES'
 '121'.2016.'Erbsen zur Körnergewinnung' 'YES'
 '121'.2018.'Kartoffeln' 'YES'
 '571'.2017.'Kartoffeln' 'YES'
 '130'.2018.'Zwiebeln/Lauch' 'YES'
 '901'.2018.'Möhre (auch Futtermöhre)' 'YES'
 '9'.2017.'Zwiebeln/Lauch' 'YES'
 '39'.2017.'Kartoffeln' 'YES'
 '48'.2016.'Kartoffeln' 'YES'
 '113'.2018.'Kartoffeln' 'YES'
 '574'.2016.'Kartoffeln' 'YES'
 '1015'.2018.'Kartoffeln' 'YES'
 '573'.2016.'Kartoffeln' 'YES'
 '1181'.2018.'Zwiebeln/Lauch' 'YES'
 '6'.2017.'Zwiebeln/Lauch' 'YES'
 '462'.2017.'Zwiebeln/Lauch' 'YES'
 '462'.2018.'Kartoffeln' 'YES'
 '1004'.2017.'Kartoffeln' 'YES'
 '43'.2017.'Kartoffeln' 'YES'
 '122'.2016.'Kartoffeln' 'YES'
 '123'.2016.'Kartoffeln' 'YES'
 '1019'.2018.'Kartoffeln' 'YES'
 '41'.2018.'Kartoffeln' 'YES'
 '1012'.2017.'Kartoffeln' 'YES'
 '1008'.2017.'Kartoffeln' 'YES'
 '1003'.2016.'Zwiebeln/Lauch' 'YES'
 '1013'.2016.'Zwiebeln/Lauch' 'YES'
 '120'.2017.'Kartoffeln' 'YES'
 '1'.2017.'Kartoffeln' 'YES'
 '1018'.2017.'Kartoffeln' 'YES'
 '88'.2016.'Zwiebeln/Lauch' 'YES'
 '86'.2016.'Erbsen zur Körnergewinnung' 'YES'
 '881'.2016.'Erbsen zur Körnergewinnung' 'YES'
 '75'.2016.'Erbsen zur Körnergewinnung' 'YES'
 '75'.2018.'Kartoffeln' 'YES'
 '88'.2018.'Kartoffeln' 'YES'
 '86'.2018.'Kartoffeln' 'YES'
 '54'.2017.'Möhre (auch Futtermöhre)' 'YES'
 '56'.2018.'Möhre (auch Futtermöhre)' 'YES'
 '67'.2018.'Möhre (auch Futtermöhre)' 'YES'
 '38'.2016.'Kartoffeln' 'YES'
 '114'.2017.'Kartoffeln' 'YES'
 '571'.2018.'Winterweichweizen' 'YES'
 '126'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '126'.2018.'Silomais (als Hauptfutter)' 'YES'
 '130'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '131'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '131'.2018.'Silomais (als Hauptfutter)' 'YES'
 '127'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '127'.2018.'Silomais (als Hauptfutter)' 'YES'
 '128'.2017.'Wintergerste' 'YES'
 '128'.2018.'Zuckerrüben' 'YES'
 '125'.2016.'Winterweichweizen' 'YES'
 '125'.2017.'Wintergerste' 'YES'
 '125'.2018.'Silomais (als Hauptfutter)' 'YES'
 '136'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '136'.2018.'Silomais (als Hauptfutter)' 'YES'
 '571'.2016.'Wintergerste' 'YES'
 '9'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '39'.2016.'Zuckerrüben' 'YES'
 '39'.2018.'Winterweichweizen' 'YES'
 '48'.2017.'Winterweichweizen' 'YES'
 '481'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '48'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '113'.2016.'Wintergerste' 'YES'
 '113'.2017.'Zuckerrüben' 'YES'
 '138'.2017.'Wintergerste' 'YES'
 '138'.2018.'Silomais (als Hauptfutter)' 'YES'
 '574'.2017.'Winterweichweizen' 'YES'
 '574'.2018.'Silomais (als Hauptfutter)' 'YES'
 '1015'.2016.'Winterweichweizen' 'YES'
 '1015'.2017.'Wintergerste' 'YES'
 '573'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '573'.2018.'Silomais (als Hauptfutter)' 'YES'
 '118'.2016.'Winterweichweizen' 'YES'
 '118'.2017.'Zuckerrüben' 'YES'
 '118'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '6'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '462'.2016.'Wintergerste' 'YES'
 '46'.2016.'Winterweichweizen' 'YES'
 '46'.2017.'Wintergerste' 'YES'
 '461'.2017.'Wintergerste' 'YES'
 '117'.2017.'Silomais (als Hauptfutter)' 'YES'
 '117'.2018.'Silomais (als Hauptfutter)' 'YES'
 '46'.2018.'Silomais (als Hauptfutter)' 'YES'
 '1004'.2016.'Zuckerrüben' 'YES'
 '1004'.2018.'Silomais (als Hauptfutter)' 'YES'
 '111'.2016.'Winterweichweizen' 'YES'
 '95'.2017.'Wintergerste' 'YES'
 '95'.2018.'Silomais (als Hauptfutter)' 'YES'
 '43'.2016.'Winterweichweizen' 'YES'
 '43'.2018.'Winterweichweizen' 'YES'
 '122'.2017.'Silomais (als Hauptfutter)' 'YES'
 '123'.2017.'Silomais (als Hauptfutter)' 'YES'
 '1014'.2016.'Winterweichweizen' 'YES'
 '1014'.2017.'Silomais (als Hauptfutter)' 'YES'
 '1019'.2017.'Zuckerrüben' 'YES'
 '1014'.2018.'Silomais (als Hauptfutter)' 'YES'
 '41'.2016.'Winterweichweizen' 'YES'
 '41'.2017.'Silomais (als Hauptfutter)' 'YES'
 '1012'.2016.'Zuckerrüben' 'YES'
 '1012'.2018.'Silomais (als Hauptfutter)' 'YES'
 '73'.2016.'Wintergerste' 'YES'
 '73'.2017.'Silomais (als Hauptfutter)' 'YES'
 '73'.2018.'Winterweichweizen' 'YES'
 '1008'.2016.'Zuckerrüben' 'YES'
 '1008'.2018.'Winterweichweizen' 'YES'
 '1003'.2017.'Silomais (als Hauptfutter)' 'YES'
 '1003'.2018.'Zuckerrüben' 'YES'
 '1009'.2016.'Zuckerrüben' 'YES'
 '1009'.2017.'Silomais (als Hauptfutter)' 'YES'
 '1009'.2018.'Silomais (als Hauptfutter)' 'YES'
 '1013'.2017.'Silomais (als Hauptfutter)' 'YES'
 '1013'.2018.'Zuckerrüben' 'YES'
 '140'.2017.'Winterweichweizen' 'YES'
 '140'.2018.'Silomais (als Hauptfutter)' 'YES'
 '120'.2016.'Wintergerste' 'YES'
 '120'.2018.'Winterweichweizen' 'YES'
 '130'.2016.'Winterweichweizen' 'YES'
 '131'.2016.'Winterweichweizen' 'YES'
 '127'.2016.'Winterweichweizen' 'YES'
 '1131'.2017.'Zuckerrüben' 'YES'
 '1'.2016.'Zuckerrüben' 'YES'
 '1'.2018.'Silomais (als Hauptfutter)' 'YES'
 '116'.2016.'Wintergerste' 'YES'
 '116'.2017.'Zuckerrüben' 'YES'
 '1018'.2016.'Zuckerrüben' 'YES'
 '1018'.2018.'Silomais (als Hauptfutter)' 'YES'
 '88'.2017.'Winterweichweizen' 'YES'
 '86'.2017.'Winterweichweizen' 'YES'
 '75'.2017.'Winterweichweizen' 'YES'
 '54'.2018.'Winterweichweizen' 'YES'
 '55'.2016.'Winterweichweizen' 'YES'
 '55'.2017.'Zuckerrüben' 'YES'
 '55'.2018.'Winterweichweizen' 'YES'
 '56'.2016.'Winterweichweizen' 'YES'
 '56'.2017.'Silomais (als Hauptfutter)' 'YES'
 '54'.2016.'Winterweichweizen' 'YES'
 '67'.2016.'Winterweichweizen' 'YES'
 '67'.2017.'Silomais (als Hauptfutter)' 'YES'
 '671'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '69'.2016.'Wintergerste' 'YES'
 '69'.2017.'Silomais (als Hauptfutter)' 'YES'
 '69'.2018.'Silomais (als Hauptfutter)' 'YES'
 '1001'.2016.'Silomais (als Hauptfutter)' 'YES'
 '1001'.2017.'Acker-/Puff-/Pferdebohne' 'YES'
 '1001'.2018.'Zuckerrüben' 'YES'
 '114'.2016.'Wintergerste' 'YES'
 '114'.2018.'Acker-/Puff-/Pferdebohne' 'YES'
 '1141'.2018.'Winterweichweizen' 'YES'
/;

parameter p_grossMarginData(crops,years,grossMarginAttr) /
 'Acker-/Puff-/Pferdebohne'.2013.yield 3.22
 'Acker-/Puff-/Pferdebohne'.2013.price 243.2
 'Acker-/Puff-/Pferdebohne'.2013.directCosts 372.99
 'Acker-/Puff-/Pferdebohne'.2013.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2013.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2006.yield 3.22
 'Acker-/Puff-/Pferdebohne'.2006.price 104.1
 'Acker-/Puff-/Pferdebohne'.2006.directCosts 298.99
 'Acker-/Puff-/Pferdebohne'.2006.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2006.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2004.yield 2.9
 'Acker-/Puff-/Pferdebohne'.2004.price 131.9
 'Acker-/Puff-/Pferdebohne'.2004.directCosts 262.01
 'Acker-/Puff-/Pferdebohne'.2004.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2004.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2015.yield 3.8
 'Acker-/Puff-/Pferdebohne'.2015.price 193
 'Acker-/Puff-/Pferdebohne'.2015.directCosts 398
 'Acker-/Puff-/Pferdebohne'.2015.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2015.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2007.yield 3.15
 'Acker-/Puff-/Pferdebohne'.2007.price 120.3
 'Acker-/Puff-/Pferdebohne'.2007.directCosts 302.01
 'Acker-/Puff-/Pferdebohne'.2007.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2007.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2018.yield 3.94
 'Acker-/Puff-/Pferdebohne'.2018.price 159
 'Acker-/Puff-/Pferdebohne'.2018.directCosts 367.37
 'Acker-/Puff-/Pferdebohne'.2018.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2018.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2009.yield 3.01
 'Acker-/Puff-/Pferdebohne'.2009.price 178.5
 'Acker-/Puff-/Pferdebohne'.2009.directCosts 381
 'Acker-/Puff-/Pferdebohne'.2009.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2009.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2002.yield 3.47
 'Acker-/Puff-/Pferdebohne'.2002.price 125.5
 'Acker-/Puff-/Pferdebohne'.2002.directCosts 281.01
 'Acker-/Puff-/Pferdebohne'.2002.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2002.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2011.yield 3.01
 'Acker-/Puff-/Pferdebohne'.2011.price 177.2
 'Acker-/Puff-/Pferdebohne'.2011.directCosts 335.98
 'Acker-/Puff-/Pferdebohne'.2011.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2011.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2014.yield 3.44
 'Acker-/Puff-/Pferdebohne'.2014.price 208.2
 'Acker-/Puff-/Pferdebohne'.2014.directCosts 369
 'Acker-/Puff-/Pferdebohne'.2014.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2014.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2010.yield 3.51
 'Acker-/Puff-/Pferdebohne'.2010.price 127.3
 'Acker-/Puff-/Pferdebohne'.2010.directCosts 360.99
 'Acker-/Puff-/Pferdebohne'.2010.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2010.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2016.yield 3.51
 'Acker-/Puff-/Pferdebohne'.2016.price 171.6
 'Acker-/Puff-/Pferdebohne'.2016.directCosts 384.99
 'Acker-/Puff-/Pferdebohne'.2016.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2016.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2012.yield 2.89
 'Acker-/Puff-/Pferdebohne'.2012.price 194.9
 'Acker-/Puff-/Pferdebohne'.2012.directCosts 351.01
 'Acker-/Puff-/Pferdebohne'.2012.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2012.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2017.yield 3.41
 'Acker-/Puff-/Pferdebohne'.2017.price 177.9
 'Acker-/Puff-/Pferdebohne'.2017.directCosts 338
 'Acker-/Puff-/Pferdebohne'.2017.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2017.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2001.yield 2.96
 'Acker-/Puff-/Pferdebohne'.2001.price 125
 'Acker-/Puff-/Pferdebohne'.2001.directCosts 308.01
 'Acker-/Puff-/Pferdebohne'.2001.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2001.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2005.yield 3.86
 'Acker-/Puff-/Pferdebohne'.2005.price 105.1
 'Acker-/Puff-/Pferdebohne'.2005.directCosts 321
 'Acker-/Puff-/Pferdebohne'.2005.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2005.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2003.yield 2.87
 'Acker-/Puff-/Pferdebohne'.2003.price 116
 'Acker-/Puff-/Pferdebohne'.2003.directCosts 256.01
 'Acker-/Puff-/Pferdebohne'.2003.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2003.fixCosts 408.93
 'Acker-/Puff-/Pferdebohne'.2008.yield 2.73
 'Acker-/Puff-/Pferdebohne'.2008.price 194.3
 'Acker-/Puff-/Pferdebohne'.2008.directCosts 293.01
 'Acker-/Puff-/Pferdebohne'.2008.variableCosts 180.15
 'Acker-/Puff-/Pferdebohne'.2008.fixCosts 408.93
 'Erbsen zur Körnergewinnung'.2008.yield 2.73
 'Erbsen zur Körnergewinnung'.2008.price 194.3
 'Erbsen zur Körnergewinnung'.2008.directCosts 292.99
 'Erbsen zur Körnergewinnung'.2008.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2008.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2016.yield 3.51
 'Erbsen zur Körnergewinnung'.2016.price 171.6
 'Erbsen zur Körnergewinnung'.2016.directCosts 385.01
 'Erbsen zur Körnergewinnung'.2016.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2016.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2014.yield 3.44
 'Erbsen zur Körnergewinnung'.2014.price 208.2
 'Erbsen zur Körnergewinnung'.2014.directCosts 369
 'Erbsen zur Körnergewinnung'.2014.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2014.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2002.yield 3.47
 'Erbsen zur Körnergewinnung'.2002.price 125.5
 'Erbsen zur Körnergewinnung'.2002.directCosts 281.02
 'Erbsen zur Körnergewinnung'.2002.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2002.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2001.yield 2.96
 'Erbsen zur Körnergewinnung'.2001.price 125
 'Erbsen zur Körnergewinnung'.2001.directCosts 307.99
 'Erbsen zur Körnergewinnung'.2001.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2001.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2012.yield 2.89
 'Erbsen zur Körnergewinnung'.2012.price 194.9
 'Erbsen zur Körnergewinnung'.2012.directCosts 351
 'Erbsen zur Körnergewinnung'.2012.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2012.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2015.yield 3.8
 'Erbsen zur Körnergewinnung'.2015.price 193
 'Erbsen zur Körnergewinnung'.2015.directCosts 398.01
 'Erbsen zur Körnergewinnung'.2015.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2015.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2010.yield 3.51
 'Erbsen zur Körnergewinnung'.2010.price 127.3
 'Erbsen zur Körnergewinnung'.2010.directCosts 361
 'Erbsen zur Körnergewinnung'.2010.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2010.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2006.yield 3.22
 'Erbsen zur Körnergewinnung'.2006.price 104.1
 'Erbsen zur Körnergewinnung'.2006.directCosts 299.01
 'Erbsen zur Körnergewinnung'.2006.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2006.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2013.yield 3.22
 'Erbsen zur Körnergewinnung'.2013.price 243.2
 'Erbsen zur Körnergewinnung'.2013.directCosts 373
 'Erbsen zur Körnergewinnung'.2013.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2013.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2004.yield 2.9
 'Erbsen zur Körnergewinnung'.2004.price 131.9
 'Erbsen zur Körnergewinnung'.2004.directCosts 262
 'Erbsen zur Körnergewinnung'.2004.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2004.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2009.yield 3.01
 'Erbsen zur Körnergewinnung'.2009.price 178.5
 'Erbsen zur Körnergewinnung'.2009.directCosts 381
 'Erbsen zur Körnergewinnung'.2009.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2009.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2007.yield 3.15
 'Erbsen zur Körnergewinnung'.2007.price 120.3
 'Erbsen zur Körnergewinnung'.2007.directCosts 302
 'Erbsen zur Körnergewinnung'.2007.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2007.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2011.yield 3.01
 'Erbsen zur Körnergewinnung'.2011.price 177.2
 'Erbsen zur Körnergewinnung'.2011.directCosts 336
 'Erbsen zur Körnergewinnung'.2011.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2011.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2003.yield 2.87
 'Erbsen zur Körnergewinnung'.2003.price 116
 'Erbsen zur Körnergewinnung'.2003.directCosts 255.99
 'Erbsen zur Körnergewinnung'.2003.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2003.fixCosts 444.57
 'Erbsen zur Körnergewinnung'.2005.yield 3.86
 'Erbsen zur Körnergewinnung'.2005.price 105.1
 'Erbsen zur Körnergewinnung'.2005.directCosts 321
 'Erbsen zur Körnergewinnung'.2005.variableCosts 183.87
 'Erbsen zur Körnergewinnung'.2005.fixCosts 444.57
 'Kartoffeln'.2003.yield 39.12
 'Kartoffeln'.2003.price 65
 'Kartoffeln'.2003.directCosts 861.99
 'Kartoffeln'.2003.variableCosts 578.63
 'Kartoffeln'.2003.fixCosts 2925.63
 'Kartoffeln'.2002.yield 36.17
 'Kartoffeln'.2002.price 101.4
 'Kartoffeln'.2002.directCosts 984
 'Kartoffeln'.2002.variableCosts 578.63
 'Kartoffeln'.2002.fixCosts 2925.63
 'Kartoffeln'.2004.yield 28.88
 'Kartoffeln'.2004.price 101.2
 'Kartoffeln'.2004.directCosts 917.01
 'Kartoffeln'.2004.variableCosts 578.63
 'Kartoffeln'.2004.fixCosts 2925.63
 'Kartoffeln'.2009.yield 43.74
 'Kartoffeln'.2009.price 115.1
 'Kartoffeln'.2009.directCosts 1104.99
 'Kartoffeln'.2009.variableCosts 578.63
 'Kartoffeln'.2009.fixCosts 2925.63
 'Kartoffeln'.2011.yield 39.88
 'Kartoffeln'.2011.price 226.3
 'Kartoffeln'.2011.directCosts 1343.01
 'Kartoffeln'.2011.variableCosts 578.63
 'Kartoffeln'.2011.fixCosts 2925.63
 'Kartoffeln'.2013.yield 44.75
 'Kartoffeln'.2013.price 195.3
 'Kartoffeln'.2013.directCosts 1407.02
 'Kartoffeln'.2013.variableCosts 578.63
 'Kartoffeln'.2013.fixCosts 2925.63
 'Kartoffeln'.2001.yield 38.64
 'Kartoffeln'.2001.price 50.7
 'Kartoffeln'.2001.directCosts 773.98
 'Kartoffeln'.2001.variableCosts 578.63
 'Kartoffeln'.2001.fixCosts 2925.63
 'Kartoffeln'.2005.yield 32.95
 'Kartoffeln'.2005.price 45.7
 'Kartoffeln'.2005.directCosts 844.01
 'Kartoffeln'.2005.variableCosts 578.63
 'Kartoffeln'.2005.fixCosts 2925.63
 'Kartoffeln'.2006.yield 41.93
 'Kartoffeln'.2006.price 101
 'Kartoffeln'.2006.directCosts 917.99
 'Kartoffeln'.2006.variableCosts 578.63
 'Kartoffeln'.2006.fixCosts 2925.63
 'Kartoffeln'.2015.yield 47.42
 'Kartoffeln'.2015.price 77.2
 'Kartoffeln'.2015.directCosts 1043.01
 'Kartoffeln'.2015.variableCosts 578.63
 'Kartoffeln'.2015.fixCosts 2925.63
 'Kartoffeln'.2018.yield 45
 'Kartoffeln'.2018.price 182
 'Kartoffeln'.2018.directCosts 2289.8
 'Kartoffeln'.2018.variableCosts 578.63
 'Kartoffeln'.2018.fixCosts 2925.63
 'Kartoffeln'.2017.yield 44.42
 'Kartoffeln'.2017.price 190.2
 'Kartoffeln'.2017.directCosts 1566.98
 'Kartoffeln'.2017.variableCosts 578.63
 'Kartoffeln'.2017.fixCosts 2925.63
 'Kartoffeln'.2008.yield 32.4
 'Kartoffeln'.2008.price 294.6
 'Kartoffeln'.2008.directCosts 2216.01
 'Kartoffeln'.2008.variableCosts 578.63
 'Kartoffeln'.2008.fixCosts 2925.63
 'Kartoffeln'.2014.yield 39.83
 'Kartoffeln'.2014.price 240.1
 'Kartoffeln'.2014.directCosts 1526.01
 'Kartoffeln'.2014.variableCosts 578.63
 'Kartoffeln'.2014.fixCosts 2925.63
 'Kartoffeln'.2012.yield 45.76
 'Kartoffeln'.2012.price 110.2
 'Kartoffeln'.2012.directCosts 1145.01
 'Kartoffeln'.2012.variableCosts 578.63
 'Kartoffeln'.2012.fixCosts 2925.63
 'Kartoffeln'.2010.yield 44.26
 'Kartoffeln'.2010.price 114.2
 'Kartoffeln'.2010.directCosts 1036
 'Kartoffeln'.2010.variableCosts 578.63
 'Kartoffeln'.2010.fixCosts 2925.63
 'Kartoffeln'.2016.yield 43.81
 'Kartoffeln'.2016.price 163.5
 'Kartoffeln'.2016.directCosts 1280.01
 'Kartoffeln'.2016.variableCosts 578.63
 'Kartoffeln'.2016.fixCosts 2925.63
 'Kartoffeln'.2007.yield 36.53
 'Kartoffeln'.2007.price 222.1
 'Kartoffeln'.2007.directCosts 1396
 'Kartoffeln'.2007.variableCosts 578.63
 'Kartoffeln'.2007.fixCosts 2925.63
 'Möhre (auch Futtermöhre)'.2014.yield 60000
 'Möhre (auch Futtermöhre)'.2014.price 0.31
 'Möhre (auch Futtermöhre)'.2014.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2014.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2014.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2007.yield 60000
 'Möhre (auch Futtermöhre)'.2007.price 0.31
 'Möhre (auch Futtermöhre)'.2007.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2007.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2007.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2012.yield 60000
 'Möhre (auch Futtermöhre)'.2012.price 0.31
 'Möhre (auch Futtermöhre)'.2012.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2012.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2012.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2001.yield 60000
 'Möhre (auch Futtermöhre)'.2001.price 0.31
 'Möhre (auch Futtermöhre)'.2001.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2001.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2001.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2009.yield 60000
 'Möhre (auch Futtermöhre)'.2009.price 0.31
 'Möhre (auch Futtermöhre)'.2009.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2009.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2009.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2003.yield 60000
 'Möhre (auch Futtermöhre)'.2003.price 0.31
 'Möhre (auch Futtermöhre)'.2003.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2003.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2003.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2017.yield 60000
 'Möhre (auch Futtermöhre)'.2017.price 0.31
 'Möhre (auch Futtermöhre)'.2017.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2017.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2017.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2006.yield 60000
 'Möhre (auch Futtermöhre)'.2006.price 0.31
 'Möhre (auch Futtermöhre)'.2006.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2006.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2006.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2011.yield 60000
 'Möhre (auch Futtermöhre)'.2011.price 0.31
 'Möhre (auch Futtermöhre)'.2011.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2011.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2011.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2002.yield 60000
 'Möhre (auch Futtermöhre)'.2002.price 0.31
 'Möhre (auch Futtermöhre)'.2002.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2002.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2002.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2013.yield 60000
 'Möhre (auch Futtermöhre)'.2013.price 0.31
 'Möhre (auch Futtermöhre)'.2013.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2013.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2013.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2016.yield 60000
 'Möhre (auch Futtermöhre)'.2016.price 0.31
 'Möhre (auch Futtermöhre)'.2016.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2016.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2016.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2010.yield 60000
 'Möhre (auch Futtermöhre)'.2010.price 0.31
 'Möhre (auch Futtermöhre)'.2010.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2010.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2010.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2008.yield 60000
 'Möhre (auch Futtermöhre)'.2008.price 0.31
 'Möhre (auch Futtermöhre)'.2008.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2008.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2008.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2004.yield 60000
 'Möhre (auch Futtermöhre)'.2004.price 0.31
 'Möhre (auch Futtermöhre)'.2004.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2004.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2004.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2018.yield 60000
 'Möhre (auch Futtermöhre)'.2018.price 0.31
 'Möhre (auch Futtermöhre)'.2018.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2018.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2018.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2005.yield 60000
 'Möhre (auch Futtermöhre)'.2005.price 0.31
 'Möhre (auch Futtermöhre)'.2005.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2005.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2005.fixCosts 8447.43
 'Möhre (auch Futtermöhre)'.2015.yield 60000
 'Möhre (auch Futtermöhre)'.2015.price 0.31
 'Möhre (auch Futtermöhre)'.2015.directCosts 4048.79
 'Möhre (auch Futtermöhre)'.2015.variableCosts 3778.61
 'Möhre (auch Futtermöhre)'.2015.fixCosts 8447.43
 'Silomais (als Hauptfutter)'.2015.yield 47.33
 'Silomais (als Hauptfutter)'.2015.price 28
 'Silomais (als Hauptfutter)'.2015.directCosts 570
 'Silomais (als Hauptfutter)'.2015.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2015.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2006.yield 45.43
 'Silomais (als Hauptfutter)'.2006.price 28
 'Silomais (als Hauptfutter)'.2006.directCosts 378
 'Silomais (als Hauptfutter)'.2006.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2006.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2014.yield 38.97
 'Silomais (als Hauptfutter)'.2014.price 28
 'Silomais (als Hauptfutter)'.2014.directCosts 524
 'Silomais (als Hauptfutter)'.2014.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2014.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2005.yield 43.84
 'Silomais (als Hauptfutter)'.2005.price 21
 'Silomais (als Hauptfutter)'.2005.directCosts 365
 'Silomais (als Hauptfutter)'.2005.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2005.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2003.yield 45.43
 'Silomais (als Hauptfutter)'.2003.price 21
 'Silomais (als Hauptfutter)'.2003.directCosts 362.99
 'Silomais (als Hauptfutter)'.2003.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2003.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2004.yield 37.85
 'Silomais (als Hauptfutter)'.2004.price 42
 'Silomais (als Hauptfutter)'.2004.directCosts 342
 'Silomais (als Hauptfutter)'.2004.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2004.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2018.yield 44
 'Silomais (als Hauptfutter)'.2018.price 41
 'Silomais (als Hauptfutter)'.2018.directCosts 590.77
 'Silomais (als Hauptfutter)'.2018.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2018.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2012.yield 47.61
 'Silomais (als Hauptfutter)'.2012.price 28
 'Silomais (als Hauptfutter)'.2012.directCosts 561.01
 'Silomais (als Hauptfutter)'.2012.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2012.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2017.yield 43.08
 'Silomais (als Hauptfutter)'.2017.price 28
 'Silomais (als Hauptfutter)'.2017.directCosts 534
 'Silomais (als Hauptfutter)'.2017.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2017.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2016.yield 41.36
 'Silomais (als Hauptfutter)'.2016.price 28
 'Silomais (als Hauptfutter)'.2016.directCosts 535
 'Silomais (als Hauptfutter)'.2016.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2016.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2013.yield 46.43
 'Silomais (als Hauptfutter)'.2013.price 28
 'Silomais (als Hauptfutter)'.2013.directCosts 554.99
 'Silomais (als Hauptfutter)'.2013.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2013.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2011.yield 39.38
 'Silomais (als Hauptfutter)'.2011.price 28
 'Silomais (als Hauptfutter)'.2011.directCosts 471
 'Silomais (als Hauptfutter)'.2011.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2011.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2007.yield 39.4
 'Silomais (als Hauptfutter)'.2007.price 31
 'Silomais (als Hauptfutter)'.2007.directCosts 394.99
 'Silomais (als Hauptfutter)'.2007.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2007.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2009.yield 45.14
 'Silomais (als Hauptfutter)'.2009.price 28
 'Silomais (als Hauptfutter)'.2009.directCosts 548
 'Silomais (als Hauptfutter)'.2009.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2009.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2008.yield 46.98
 'Silomais (als Hauptfutter)'.2008.price 31
 'Silomais (als Hauptfutter)'.2008.directCosts 442
 'Silomais (als Hauptfutter)'.2008.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2008.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2002.yield 44.33
 'Silomais (als Hauptfutter)'.2002.price 19
 'Silomais (als Hauptfutter)'.2002.directCosts 349
 'Silomais (als Hauptfutter)'.2002.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2002.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2010.yield 44.5
 'Silomais (als Hauptfutter)'.2010.price 28
 'Silomais (als Hauptfutter)'.2010.directCosts 476.01
 'Silomais (als Hauptfutter)'.2010.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2010.fixCosts 718.98
 'Silomais (als Hauptfutter)'.2001.yield 44.97
 'Silomais (als Hauptfutter)'.2001.price 19
 'Silomais (als Hauptfutter)'.2001.directCosts 366
 'Silomais (als Hauptfutter)'.2001.variableCosts 634.88
 'Silomais (als Hauptfutter)'.2001.fixCosts 718.98
 'Wintergerste'.2002.yield 6.23
 'Wintergerste'.2002.price 105.8
 'Wintergerste'.2002.directCosts 267
 'Wintergerste'.2002.variableCosts 200.37
 'Wintergerste'.2002.fixCosts 490.87
 'Wintergerste'.2015.yield 7.28
 'Wintergerste'.2015.price 147.4
 'Wintergerste'.2015.directCosts 430
 'Wintergerste'.2015.variableCosts 200.37
 'Wintergerste'.2015.fixCosts 490.87
 'Wintergerste'.2011.yield 6.21
 'Wintergerste'.2011.price 181.2
 'Wintergerste'.2011.directCosts 364.01
 'Wintergerste'.2011.variableCosts 200.37
 'Wintergerste'.2011.fixCosts 490.87
 'Wintergerste'.2014.yield 6.54
 'Wintergerste'.2014.price 167.2
 'Wintergerste'.2014.directCosts 404.01
 'Wintergerste'.2014.variableCosts 200.37
 'Wintergerste'.2014.fixCosts 490.87
 'Wintergerste'.2006.yield 5.83
 'Wintergerste'.2006.price 98.2
 'Wintergerste'.2006.directCosts 272.99
 'Wintergerste'.2006.variableCosts 200.37
 'Wintergerste'.2006.fixCosts 490.87
 'Wintergerste'.2001.yield 5.72
 'Wintergerste'.2001.price 110.8
 'Wintergerste'.2001.directCosts 237.99
 'Wintergerste'.2001.variableCosts 200.37
 'Wintergerste'.2001.fixCosts 490.87
 'Wintergerste'.2003.yield 5.42
 'Wintergerste'.2003.price 96.8
 'Wintergerste'.2003.directCosts 251.01
 'Wintergerste'.2003.variableCosts 200.37
 'Wintergerste'.2003.fixCosts 490.87
 'Wintergerste'.2016.yield 7.11
 'Wintergerste'.2016.price 139.3
 'Wintergerste'.2016.directCosts 418
 'Wintergerste'.2016.variableCosts 200.37
 'Wintergerste'.2016.fixCosts 490.87
 'Wintergerste'.2012.yield 5.47
 'Wintergerste'.2012.price 191.5
 'Wintergerste'.2012.directCosts 385.99
 'Wintergerste'.2012.variableCosts 200.37
 'Wintergerste'.2012.fixCosts 490.87
 'Wintergerste'.2007.yield 5.71
 'Wintergerste'.2007.price 134.1
 'Wintergerste'.2007.directCosts 273.99
 'Wintergerste'.2007.variableCosts 200.37
 'Wintergerste'.2007.fixCosts 490.87
 'Wintergerste'.2005.yield 6.46
 'Wintergerste'.2005.price 94.8
 'Wintergerste'.2005.directCosts 272.99
 'Wintergerste'.2005.variableCosts 200.37
 'Wintergerste'.2005.fixCosts 490.87
 'Wintergerste'.2010.yield 6.49
 'Wintergerste'.2010.price 94.4
 'Wintergerste'.2010.directCosts 344.01
 'Wintergerste'.2010.variableCosts 200.37
 'Wintergerste'.2010.fixCosts 490.87
 'Wintergerste'.2009.yield 6.14
 'Wintergerste'.2009.price 144.1
 'Wintergerste'.2009.directCosts 419.01
 'Wintergerste'.2009.variableCosts 200.37
 'Wintergerste'.2009.fixCosts 490.87
 'Wintergerste'.2008.yield 5.22
 'Wintergerste'.2008.price 218.1
 'Wintergerste'.2008.directCosts 296
 'Wintergerste'.2008.variableCosts 200.37
 'Wintergerste'.2008.fixCosts 490.87
 'Wintergerste'.2004.yield 5.1
 'Wintergerste'.2004.price 116.4
 'Wintergerste'.2004.directCosts 249.99
 'Wintergerste'.2004.variableCosts 200.37
 'Wintergerste'.2004.fixCosts 490.87
 'Wintergerste'.2013.yield 6.27
 'Wintergerste'.2013.price 209.1
 'Wintergerste'.2013.directCosts 395.99
 'Wintergerste'.2013.variableCosts 200.37
 'Wintergerste'.2013.fixCosts 490.87
 'Wintergerste'.2017.yield 6.6
 'Wintergerste'.2017.price 135.9
 'Wintergerste'.2017.directCosts 377
 'Wintergerste'.2017.variableCosts 200.37
 'Wintergerste'.2017.fixCosts 490.87
 'Winterweichweizen'.2006.yield 7.39
 'Winterweichweizen'.2006.price 95.2
 'Winterweichweizen'.2006.directCosts 355.01
 'Winterweichweizen'.2006.variableCosts 206.16
 'Winterweichweizen'.2006.fixCosts 505.48
 'Winterweichweizen'.2005.yield 8.1
 'Winterweichweizen'.2005.price 93
 'Winterweichweizen'.2005.directCosts 341.01
 'Winterweichweizen'.2005.variableCosts 206.16
 'Winterweichweizen'.2005.fixCosts 505.48
 'Winterweichweizen'.2002.yield 7.8
 'Winterweichweizen'.2002.price 107
 'Winterweichweizen'.2002.directCosts 342
 'Winterweichweizen'.2002.variableCosts 206.16
 'Winterweichweizen'.2002.fixCosts 505.48
 'Winterweichweizen'.2016.yield 8.12
 'Winterweichweizen'.2016.price 144.5
 'Winterweichweizen'.2016.directCosts 482.99
 'Winterweichweizen'.2016.variableCosts 206.16
 'Winterweichweizen'.2016.fixCosts 505.48
 'Winterweichweizen'.2007.yield 7.13
 'Winterweichweizen'.2007.price 128
 'Winterweichweizen'.2007.directCosts 351.01
 'Winterweichweizen'.2007.variableCosts 206.16
 'Winterweichweizen'.2007.fixCosts 505.48
 'Winterweichweizen'.2009.yield 8.06
 'Winterweichweizen'.2009.price 147
 'Winterweichweizen'.2009.directCosts 530.99
 'Winterweichweizen'.2009.variableCosts 206.16
 'Winterweichweizen'.2009.fixCosts 505.48
 'Winterweichweizen'.2001.yield 7.23
 'Winterweichweizen'.2001.price 113.8
 'Winterweichweizen'.2001.directCosts 313.99
 'Winterweichweizen'.2001.variableCosts 206.16
 'Winterweichweizen'.2001.fixCosts 505.48
 'Winterweichweizen'.2012.yield 7.04
 'Winterweichweizen'.2012.price 185.7
 'Winterweichweizen'.2012.directCosts 505.01
 'Winterweichweizen'.2012.variableCosts 206.16
 'Winterweichweizen'.2012.fixCosts 505.48
 'Winterweichweizen'.2011.yield 7.23
 'Winterweichweizen'.2011.price 206.7
 'Winterweichweizen'.2011.directCosts 447
 'Winterweichweizen'.2011.variableCosts 206.16
 'Winterweichweizen'.2011.fixCosts 505.48
 'Winterweichweizen'.2015.yield 8.65
 'Winterweichweizen'.2015.price 158.1
 'Winterweichweizen'.2015.directCosts 502.01
 'Winterweichweizen'.2015.variableCosts 206.16
 'Winterweichweizen'.2015.fixCosts 505.48
 'Winterweichweizen'.2017.yield 7.67
 'Winterweichweizen'.2017.price 145.1
 'Winterweichweizen'.2017.directCosts 423.01
 'Winterweichweizen'.2017.variableCosts 206.16
 'Winterweichweizen'.2017.fixCosts 505.48
 'Winterweichweizen'.2018.yield 7.89
 'Winterweichweizen'.2018.price 151
 'Winterweichweizen'.2018.directCosts 531.84
 'Winterweichweizen'.2018.variableCosts 206.16
 'Winterweichweizen'.2018.fixCosts 505.48
 'Winterweichweizen'.2010.yield 7.79
 'Winterweichweizen'.2010.price 107.5
 'Winterweichweizen'.2010.directCosts 440.01
 'Winterweichweizen'.2010.variableCosts 206.16
 'Winterweichweizen'.2010.fixCosts 505.48
 'Winterweichweizen'.2014.yield 8.01
 'Winterweichweizen'.2014.price 175.3
 'Winterweichweizen'.2014.directCosts 490
 'Winterweichweizen'.2014.variableCosts 206.16
 'Winterweichweizen'.2014.fixCosts 505.48
 'Winterweichweizen'.2008.yield 6.88
 'Winterweichweizen'.2008.price 214.1
 'Winterweichweizen'.2008.directCosts 386
 'Winterweichweizen'.2008.variableCosts 206.16
 'Winterweichweizen'.2008.fixCosts 505.48
 'Winterweichweizen'.2003.yield 6.84
 'Winterweichweizen'.2003.price 105.1
 'Winterweichweizen'.2003.directCosts 319.01
 'Winterweichweizen'.2003.variableCosts 206.16
 'Winterweichweizen'.2003.fixCosts 505.48
 'Winterweichweizen'.2004.yield 6.49
 'Winterweichweizen'.2004.price 127.3
 'Winterweichweizen'.2004.directCosts 326.99
 'Winterweichweizen'.2004.variableCosts 206.16
 'Winterweichweizen'.2004.fixCosts 505.48
 'Winterweichweizen'.2013.yield 7.39
 'Winterweichweizen'.2013.price 230.1
 'Winterweichweizen'.2013.directCosts 484
 'Winterweichweizen'.2013.variableCosts 206.16
 'Winterweichweizen'.2013.fixCosts 505.48
 'Zuckerrüben'.2018.yield 60
 'Zuckerrüben'.2018.price 35
 'Zuckerrüben'.2018.directCosts 918.67
 'Zuckerrüben'.2018.variableCosts 233
 'Zuckerrüben'.2018.fixCosts 461.69
 'Zuckerrüben'.2006.yield 60.18
 'Zuckerrüben'.2006.price 49
 'Zuckerrüben'.2006.directCosts 619
 'Zuckerrüben'.2006.variableCosts 233
 'Zuckerrüben'.2006.fixCosts 461.69
 'Zuckerrüben'.2001.yield 60.5
 'Zuckerrüben'.2001.price 44.1
 'Zuckerrüben'.2001.directCosts 602.99
 'Zuckerrüben'.2001.variableCosts 233
 'Zuckerrüben'.2001.fixCosts 461.69
 'Zuckerrüben'.2005.yield 61.65
 'Zuckerrüben'.2005.price 49
 'Zuckerrüben'.2005.directCosts 612.01
 'Zuckerrüben'.2005.variableCosts 233
 'Zuckerrüben'.2005.fixCosts 461.69
 'Zuckerrüben'.2013.yield 68.85
 'Zuckerrüben'.2013.price 43.5
 'Zuckerrüben'.2013.directCosts 981.99
 'Zuckerrüben'.2013.variableCosts 233
 'Zuckerrüben'.2013.fixCosts 461.69
 'Zuckerrüben'.2009.yield 62.29
 'Zuckerrüben'.2009.price 27.8
 'Zuckerrüben'.2009.directCosts 855
 'Zuckerrüben'.2009.variableCosts 233
 'Zuckerrüben'.2009.fixCosts 461.69
 'Zuckerrüben'.2014.yield 63.88
 'Zuckerrüben'.2014.price 43.5
 'Zuckerrüben'.2014.directCosts 846
 'Zuckerrüben'.2014.variableCosts 233
 'Zuckerrüben'.2014.fixCosts 461.69
 'Zuckerrüben'.2007.yield 57.73
 'Zuckerrüben'.2007.price 32.9
 'Zuckerrüben'.2007.directCosts 641.98
 'Zuckerrüben'.2007.variableCosts 233
 'Zuckerrüben'.2007.fixCosts 461.69
 'Zuckerrüben'.2015.yield 79.86
 'Zuckerrüben'.2015.price 34.5
 'Zuckerrüben'.2015.directCosts 959.99
 'Zuckerrüben'.2015.variableCosts 233
 'Zuckerrüben'.2015.fixCosts 461.69
 'Zuckerrüben'.2017.yield 76.23
 'Zuckerrüben'.2017.price 36
 'Zuckerrüben'.2017.directCosts 846.99
 'Zuckerrüben'.2017.variableCosts 233
 'Zuckerrüben'.2017.fixCosts 461.69
 'Zuckerrüben'.2011.yield 61.63
 'Zuckerrüben'.2011.price 29.8
 'Zuckerrüben'.2011.directCosts 782.99
 'Zuckerrüben'.2011.variableCosts 233
 'Zuckerrüben'.2011.fixCosts 461.69
 'Zuckerrüben'.2010.yield 67.56
 'Zuckerrüben'.2010.price 29.8
 'Zuckerrüben'.2010.directCosts 782.99
 'Zuckerrüben'.2010.variableCosts 233
 'Zuckerrüben'.2010.fixCosts 461.69
 'Zuckerrüben'.2002.yield 55.01
 'Zuckerrüben'.2002.price 45.7
 'Zuckerrüben'.2002.directCosts 605.01
 'Zuckerrüben'.2002.variableCosts 233
 'Zuckerrüben'.2002.fixCosts 461.69
 'Zuckerrüben'.2004.yield 53.22
 'Zuckerrüben'.2004.price 49.1
 'Zuckerrüben'.2004.directCosts 612.01
 'Zuckerrüben'.2004.variableCosts 233
 'Zuckerrüben'.2004.fixCosts 461.69
 'Zuckerrüben'.2003.yield 60.56
 'Zuckerrüben'.2003.price 46.8
 'Zuckerrüben'.2003.directCosts 628.01
 'Zuckerrüben'.2003.variableCosts 233
 'Zuckerrüben'.2003.fixCosts 461.69
 'Zuckerrüben'.2008.yield 62.43
 'Zuckerrüben'.2008.price 29.8
 'Zuckerrüben'.2008.directCosts 699
 'Zuckerrüben'.2008.variableCosts 233
 'Zuckerrüben'.2008.fixCosts 461.69
 'Zuckerrüben'.2012.yield 62.87
 'Zuckerrüben'.2012.price 37
 'Zuckerrüben'.2012.directCosts 880
 'Zuckerrüben'.2012.variableCosts 233
 'Zuckerrüben'.2012.fixCosts 461.69
 'Zuckerrüben'.2016.yield 72.17
 'Zuckerrüben'.2016.price 33
 'Zuckerrüben'.2016.directCosts 930.99
 'Zuckerrüben'.2016.variableCosts 233
 'Zuckerrüben'.2016.fixCosts 461.69
 'Zwiebeln/Lauch'.2006.yield 34
 'Zwiebeln/Lauch'.2006.price 1200
 'Zwiebeln/Lauch'.2006.directCosts 7411.72
 'Zwiebeln/Lauch'.2006.variableCosts 1719.32
 'Zwiebeln/Lauch'.2006.fixCosts 1820.69
 'Zwiebeln/Lauch'.2009.yield 34
 'Zwiebeln/Lauch'.2009.price 1200
 'Zwiebeln/Lauch'.2009.directCosts 7411.72
 'Zwiebeln/Lauch'.2009.variableCosts 1719.32
 'Zwiebeln/Lauch'.2009.fixCosts 1820.69
 'Zwiebeln/Lauch'.2015.yield 34
 'Zwiebeln/Lauch'.2015.price 1200
 'Zwiebeln/Lauch'.2015.directCosts 7411.72
 'Zwiebeln/Lauch'.2015.variableCosts 1719.32
 'Zwiebeln/Lauch'.2015.fixCosts 1820.69
 'Zwiebeln/Lauch'.2010.yield 34
 'Zwiebeln/Lauch'.2010.price 1200
 'Zwiebeln/Lauch'.2010.directCosts 7411.72
 'Zwiebeln/Lauch'.2010.variableCosts 1719.32
 'Zwiebeln/Lauch'.2010.fixCosts 1820.69
 'Zwiebeln/Lauch'.2002.yield 34
 'Zwiebeln/Lauch'.2002.price 1200
 'Zwiebeln/Lauch'.2002.directCosts 7411.72
 'Zwiebeln/Lauch'.2002.variableCosts 1719.32
 'Zwiebeln/Lauch'.2002.fixCosts 1820.69
 'Zwiebeln/Lauch'.2003.yield 34
 'Zwiebeln/Lauch'.2003.price 1200
 'Zwiebeln/Lauch'.2003.directCosts 7411.72
 'Zwiebeln/Lauch'.2003.variableCosts 1719.32
 'Zwiebeln/Lauch'.2003.fixCosts 1820.69
 'Zwiebeln/Lauch'.2013.yield 34
 'Zwiebeln/Lauch'.2013.price 1200
 'Zwiebeln/Lauch'.2013.directCosts 7411.72
 'Zwiebeln/Lauch'.2013.variableCosts 1719.32
 'Zwiebeln/Lauch'.2013.fixCosts 1820.69
 'Zwiebeln/Lauch'.2008.yield 34
 'Zwiebeln/Lauch'.2008.price 1200
 'Zwiebeln/Lauch'.2008.directCosts 7411.72
 'Zwiebeln/Lauch'.2008.variableCosts 1719.32
 'Zwiebeln/Lauch'.2008.fixCosts 1820.69
 'Zwiebeln/Lauch'.2016.yield 34
 'Zwiebeln/Lauch'.2016.price 1200
 'Zwiebeln/Lauch'.2016.directCosts 7411.72
 'Zwiebeln/Lauch'.2016.variableCosts 1719.32
 'Zwiebeln/Lauch'.2016.fixCosts 1820.69
 'Zwiebeln/Lauch'.2014.yield 34
 'Zwiebeln/Lauch'.2014.price 1200
 'Zwiebeln/Lauch'.2014.directCosts 7411.72
 'Zwiebeln/Lauch'.2014.variableCosts 1719.32
 'Zwiebeln/Lauch'.2014.fixCosts 1820.69
 'Zwiebeln/Lauch'.2017.yield 34
 'Zwiebeln/Lauch'.2017.price 1200
 'Zwiebeln/Lauch'.2017.directCosts 7411.72
 'Zwiebeln/Lauch'.2017.variableCosts 1719.32
 'Zwiebeln/Lauch'.2017.fixCosts 1820.69
 'Zwiebeln/Lauch'.2018.yield 34
 'Zwiebeln/Lauch'.2018.price 1200
 'Zwiebeln/Lauch'.2018.directCosts 7411.72
 'Zwiebeln/Lauch'.2018.variableCosts 1719.32
 'Zwiebeln/Lauch'.2018.fixCosts 1820.69
 'Zwiebeln/Lauch'.2004.yield 34
 'Zwiebeln/Lauch'.2004.price 1200
 'Zwiebeln/Lauch'.2004.directCosts 7411.72
 'Zwiebeln/Lauch'.2004.variableCosts 1719.32
 'Zwiebeln/Lauch'.2004.fixCosts 1820.69
 'Zwiebeln/Lauch'.2005.yield 34
 'Zwiebeln/Lauch'.2005.price 1200
 'Zwiebeln/Lauch'.2005.directCosts 7411.72
 'Zwiebeln/Lauch'.2005.variableCosts 1719.32
 'Zwiebeln/Lauch'.2005.fixCosts 1820.69
 'Zwiebeln/Lauch'.2001.yield 34
 'Zwiebeln/Lauch'.2001.price 1200
 'Zwiebeln/Lauch'.2001.directCosts 7411.72
 'Zwiebeln/Lauch'.2001.variableCosts 1719.32
 'Zwiebeln/Lauch'.2001.fixCosts 1820.69
 'Zwiebeln/Lauch'.2011.yield 34
 'Zwiebeln/Lauch'.2011.price 1200
 'Zwiebeln/Lauch'.2011.directCosts 7411.72
 'Zwiebeln/Lauch'.2011.variableCosts 1719.32
 'Zwiebeln/Lauch'.2011.fixCosts 1820.69
 'Zwiebeln/Lauch'.2012.yield 34
 'Zwiebeln/Lauch'.2012.price 1200
 'Zwiebeln/Lauch'.2012.directCosts 7411.72
 'Zwiebeln/Lauch'.2012.variableCosts 1719.32
 'Zwiebeln/Lauch'.2012.fixCosts 1820.69
 'Zwiebeln/Lauch'.2007.yield 34
 'Zwiebeln/Lauch'.2007.price 1200
 'Zwiebeln/Lauch'.2007.directCosts 7411.72
 'Zwiebeln/Lauch'.2007.variableCosts 1719.32
 'Zwiebeln/Lauch'.2007.fixCosts 1820.69
/;

parameter p_laborReq(crops,halfMonths) /
 'Acker-/Puff-/Pferdebohne'.MRZ1 1.81
 'Acker-/Puff-/Pferdebohne'.MAI2 0.27
 'Acker-/Puff-/Pferdebohne'.AUG2 1.9
 'Acker-/Puff-/Pferdebohne'.SEP1 1
 'Acker-/Puff-/Pferdebohne'.SEP2 0.04
 'Acker-/Puff-/Pferdebohne'.OKT1 1.16
 'Acker-/Puff-/Pferdebohne'.OKT2 1.88
 'Kartoffeln'.MRZ1 1.07
 'Kartoffeln'.MRZ2 0.29
 'Kartoffeln'.APR1 1.42
 'Kartoffeln'.APR2 0.69
 'Kartoffeln'.MAI1 0.38
 'Kartoffeln'.JUN2 0.68
 'Kartoffeln'.JUL1 0.68
 'Kartoffeln'.JUL2 0.34
 'Kartoffeln'.AUG1 0.82
 'Kartoffeln'.AUG2 2.08
 'Kartoffeln'.SEP2 31.44
 'Kartoffeln'.OKT1 0.15
 'Kartoffeln'.NOV1 3.27
 'Möhre (auch Futtermöhre)'.MRZ2 4.23
 'Möhre (auch Futtermöhre)'.APR2 1.54
 'Möhre (auch Futtermöhre)'.MAI1 1.89
 'Möhre (auch Futtermöhre)'.MAI2 0.21
 'Möhre (auch Futtermöhre)'.JUN1 0.2
 'Möhre (auch Futtermöhre)'.JUL1 0.21
 'Möhre (auch Futtermöhre)'.AUG1 0.24
 'Möhre (auch Futtermöhre)'.SEP1 0.24
 'Möhre (auch Futtermöhre)'.SEP2 19.13
 'Möhre (auch Futtermöhre)'.OKT1 1.08
 'Silomais (als Hauptfutter)'.MRZ2 1.24
 'Silomais (als Hauptfutter)'.APR1 3.07
 'Silomais (als Hauptfutter)'.APR2 1.07
 'Silomais (als Hauptfutter)'.MAI1 0.43
 'Silomais (als Hauptfutter)'.MAI2 0.37
 'Silomais (als Hauptfutter)'.SEP2 4.2
 'Silomais (als Hauptfutter)'.OKT1 1.27
 'Silomais (als Hauptfutter)'.OKT2 1.88
 'Winterweichweizen'.FEB1 0.5
 'Winterweichweizen'.FEB2 0.31
 'Winterweichweizen'.MRZ2 0.12
 'Winterweichweizen'.APR1 0.47
 'Winterweichweizen'.APR2 0.27
 'Winterweichweizen'.MAI1 0.12
 'Winterweichweizen'.JUN1 0.44
 'Winterweichweizen'.AUG1 2.4
 'Winterweichweizen'.AUG2 1
 'Winterweichweizen'.SEP1 0.29
 'Winterweichweizen'.SEP2 2.8
 'Winterweichweizen'.OKT1 0.57
 'Winterweichweizen'.OKT2 1.24
 'Zuckerrüben'.FEB2 0.5
 'Zuckerrüben'.MRZ1 0.82
 'Zuckerrüben'.MRZ2 1.41
 'Zuckerrüben'.MAI2 0.27
 'Zuckerrüben'.JUL2 0.12
 'Zuckerrüben'.AUG1 0.27
 'Zuckerrüben'.SEP2 4.45
 'Zuckerrüben'.OKT1 1.31
 'Zuckerrüben'.OKT2 1.88
 'Zwiebeln/Lauch'.APR1 30.98
 'Zwiebeln/Lauch'.APR2 2.91
 'Zwiebeln/Lauch'.MAI1 2.11
 'Zwiebeln/Lauch'.MAI2 0.8
 'Zwiebeln/Lauch'.JUN1 34.18
 'Zwiebeln/Lauch'.JUL1 2.18
 'Zwiebeln/Lauch'.AUG1 5.26
 'Zwiebeln/Lauch'.AUG2 56.9
 'Zwiebeln/Lauch'.SEP1 1.08
/;

* create gross margins per plot
* *** INCLUDE    /Users/toffi1/UniCloud/Programmieren/Fruchtfolge_Modell/coefficients/grossMargin.gms
alias(curCrops,curCrops1)
Parameter p_grossMarginPlot(curPlots,years,curCrops,grossMarginAttr);

p_grossMarginPlot(curPlots,years,curCrops,"yield")
  = p_grossMarginData(curCrops,years,"yield")
;

p_grossMarginPlot(curPlots,years,curCrops,'yieldCap')
  = 1
;

p_grossMarginPlot(curPlots,years,curCrops,'croppingFactor')
  =
* correct for crop rotational effect, if any
   sum(curCrops1 $ plots_years_crops(plots,years - 1,curCrops1), p_croppingFactor(curCrops1,curCrops)) / 10
;

p_grossMarginPlot(curPlots,years,curCrops,'variableCosts')
  = p_grossMarginData(curCrops,years,"variableCosts")
  * p_plotData(curPlots,'size')
;

p_grossMarginPlot(curPlots,years,curCrops,'distanceCosts')
  = p_grossMarginPlot(curPlots,years,curCrops,'yield')
* Regression of costs according to LfL 2007
* https://www.lfl.bayern.de/mam/cms07/publikationen/daten/informationen/p_28561.pdf
  * (0.2915 * abs(p_plotData(curPlots,'distance') - 2) + 1.4287)
  * p_plotData(curPlots,'size')
  * (- 1) $ (p_plotData(curPlots,'distance') < 2)
;

p_grossMarginPlot(curPlots,years,curCrops,'directCosts')
  = p_grossMarginData(curCrops,years,"directCosts")
  * p_plotData(curPlots,'size')
;

p_grossMarginPlot(curPlots,years,curCrops,'price')
  = p_grossMarginData(curCrops,years,"price")
;

p_grossMarginPlot(curPlots,years,curCrops,'revenue')
  = p_grossMarginPlot(curPlots,years,curCrops,'price')
  * p_grossMarginPlot(curPlots,years,curCrops,'yield')
  * p_plotData(curPlots,'size')
;

p_grossMarginPlot(curPlots,years,curCrops,'grossMargin')
  = [p_grossMarginData(curCrops,years,"price")
  * (p_grossMarginPlot(curPlots,years,curCrops,'yield')
     * p_grossMarginPlot(curPlots,years,curCrops,'croppingFactor')
     * p_grossMarginPlot(curPlots,years,curCrops,'yieldCap'))
  * p_plotData(curPlots,'size')]
  - p_grossMarginPlot(curPlots,years,curCrops,'directCosts')
  - p_grossMarginPlot(curPlots,years,curCrops,'distanceCosts')
  - p_grossMarginPlot(curPlots,years,curCrops,'variableCosts')
;

* define all model variables
variable v_obje;

binary variables
  v_binCropPlot(curCrops,curPlots)
;

Equations
  e_obje
;

* load model equations
* *** INCLUDE    /Users/toffi1/UniCloud/Programmieren/Fruchtfolge_Modell/model/cropRotation.gms
Equations
    e_oneCropPlot(plots)
    e_minimumShares(constraints,curCrops,curCrops1)
    e_maximumShares(constraints,curCrops,curCrops1)
;

e_oneCropPlot(curPlots)..
  sum(curCrops, v_binCropPlot(curCrops,curPlots))
  =L= 1
;

e_minimumShares(constraints,curCrops,curCrops1)
       $ (p_constraint(constraints,curCrops,curCrops1)
       $ (not (constraints_lt(constraints,'lt'))))..
  sum(curPlots, v_binCropPlot(curCrops,curPlots) * p_plotData(curPlots,'size') +
    v_binCropPlot(curCrops1,curPlots) + p_plotData(curPlots,'size'))
    =G= p_constraint(constraints,curCrops,curCrops1)
;

e_maximumShares(constraints,curCrops,curCrops1)
       $ (p_constraint(constraints,curCrops,curCrops1)
       $ (constraints_lt(constraints,'lt')))..
  sum(curPlots, v_binCropPlot(curCrops,curPlots) * p_plotData(curPlots,'size') +
    v_binCropPlot(curCrops1,curPlots) + p_plotData(curPlots,'size'))
    =L= p_constraint(constraints,curCrops,curCrops1)
;

e_obje..
  v_obje =E=
    sum((curPlots,curCrops,curYear),
    v_binCropPlot(curCrops,curPlots)
    * p_grossMarginPlot(curPlots,curYear,curCrops,"grossMargin"))

model Fruchtfolge "Entire Fruchtfolge model" /
  e_obje
  e_oneCropPlot
  e_minimumShares
  e_maximumShares
 /;

solve Fruchtfolge using MIP maximizing v_obje;

$ontext
File results / results.txt /;
results.pc = 5;
put results;
put "model_status",  Fruchtfolge.modelstat /;
put "solver_status", Fruchtfolge.solvestat /;
put "objective", v_obje.l /;
loop((curCrops,curPlots),
  put$(v_binCropPlot.l(curCrops,curPlots) > 0) "recommendations", curPlots.tl, curCrops.tl /
);
loop((curPlots,curCrops,years,grossMarginAttr),
  put "grossMargins", curPlots.tl,curCrops.tl, years.tl, grossMarginAttr.tl, p_grossMarginPlot(curPlots,years,curCrops,grossMarginAttr) /
);
putclose;
$offText

File results / results.json /;
*results.pc = 5;
results.lw = 40;
put results;
put "{"
put '"model_status":',  Fruchtfolge.modelstat, "," /;
put '"solver_status":', Fruchtfolge.solvestat, "," /;
put '"objective":', v_obje.l, "," /;
put '"recommendation":', "{"/;
loop((curPlots),
  put '"', curPlots.tl, '": {' /
  loop(curCrops,
     put$(ord(curCrops) < card(curCrops)) '"', curCrops.tl, '":' , v_binCropPlot.l(curCrops,curPlots), "," /
     put$(ord(curCrops) = card(curCrops)) '"', curCrops.tl, '":' , v_binCropPlot.l(curCrops,curPlots) /
*    put$(v_binCropPlot.l(curCrops,curPlots) > 0) '"', curPlots.tl, '":', '"', curCrops.tl, '"' /

  )
  put$(ord(curPlots) < card(curPlots)) "}," /
  put$(ord(curPlots) = card(curPlots)) "}" /
);
put "}," /;
put '"grossMargins":', "{"/;
loop(curPlots,
  put '"', curPlots.tl, '": {' /
  loop(years,
    put '"', years.tl, '": {' /
    loop(curCrops,
      put '"', curCrops.tl, '": {' /
      loop(grossMarginAttr,
        put$(ord(grossMarginAttr) < card(grossMarginAttr)) '"', grossMarginAttr.tl, '":', p_grossMarginPlot(curPlots,years,curCrops,grossMarginAttr), ',' /
        put$(ord(grossMarginAttr) = card(grossMarginAttr)) '"', grossMarginAttr.tl, '":', p_grossMarginPlot(curPlots,years,curCrops,grossMarginAttr) /
      )
      put$(ord(curCrops) < card(curCrops)) "}," /
      put$(ord(curCrops) = card(curCrops)) "}" /
    )
    put$(ord(years) < card(years)) "}," /
    put$(ord(years) = card(years)) "}" /
  )
  put$(ord(curPlots) < card(curPlots)) "}," /
  put$(ord(curPlots) = card(curPlots)) "}" /
);
put "}" /;
put "}" /;
putclose;
