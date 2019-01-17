<template>
  <div class="">
    <button type="button" name="button" @click="solve">Test</button>
  </div>
</template>
<script>
import model from '~/assets/js/createModel.js'
console.log(model)

export default {
  data() {
    return {}
  },
  methods: {
    solve() {
      console.log(model)
      const include = model.createInclude(this.$store)
      const staticModel = `* create gross margins per plot
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
putclose;`
      const string = include.concat(staticModel)
      console.log({a: string})
      //const { data } = await axios.post('createModel', this.$store)
    }
  }
}
</script>
<style>

</style>
