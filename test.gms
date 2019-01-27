set plots /
'Alter Zoll'
'Nussallee'
'Langer Anton'
/;

set crops /
'Ackerbohnen'
'Kartoffeln'
'Möhren'
/;

* Definition der Monate
set months /JAN,FEB,MRZ,APR,MAI,JUN,JUL,AUG,SEP,OKT,NOV,DEZ/

* Ingesamt verfuegbare Arbeitsstunden
parameter p_availWorkHours(months) /
  JAN 100
  FEB 100
  MRZ 100
  APR 100
  MAI 100
  JUN 100
  JUL 100
  AUG 100
  SEP 100
  OKT 100
  NOV 100
  DEZ 100
/;

* Arbeitszeitbedarf pro Kultur und Jahr
table p_workReqPerCrop(crops,months)
                      JAN         FEB         MRZ         APR         MAI         JUN         JUL         AUG         SEP         OKT         NOV         DEZ
'Ackerbohnen'      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000
'Kartoffeln'       10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000
'Möhren'           10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000      10.000
;

display p_workReqPerCrop;
parameter p_grossMargin(plots,crops) /
'Alter Zoll'.'Ackerbohnen' 106
'Alter Zoll'.'Kartoffeln' 5674
'Alter Zoll'.'Möhren' -4175
'Nussallee'.'Ackerbohnen' 132
'Nussallee'.'Kartoffeln' 6010
'Nussallee'.'Möhren' -4076
'Langer Anton'.'Ackerbohnen' 51
'Langer Anton'.'Kartoffeln' 4956
'Langer Anton'.'Möhren' 9819
/;

Variable v_obje;
Binary Variable v_binCropPlot(crops,plots);


Equations
  e_obje
  e_oneCropPlot(plots)
  e_maxWorkHours(months)
;

e_oneCropPlot(plots)..
  sum(crops, v_binCropPlot(crops,plots))
  =E= 1
;

e_maxWorkHours(months)..
  p_availWorkHours(months) =G=
     sum((plots,crops), v_binCropPlot(crops,plots) * p_workReqPerCrop(crops,months))
;

e_obje..
  v_obje =E=
    sum((plots,crops),
    v_binCropPlot(crops,plots)
    * p_grossMargin(plots,crops));

model Fruchtfolge / all /;
solve Fruchtfolge using MIP maximizing v_obje;
