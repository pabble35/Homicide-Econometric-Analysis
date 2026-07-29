

"Effect of criminal rate on  internarional trade "
"stimation code"

* 1. Generamos el logaritmo del PIB (esto reduce la escala y elimina el error de rango)
gen lgdp_ref = log(GDPpercapita_num)

* 2. Creamos el promedio de ese logaritmo por país para tener un solo valor por nación
bysort country_id: egen lgdp_mean = mean(lgdp_ref)

* 3. Ahora clasificamos usando la media del logaritmo (esto NO dará error)
xtile atlas = lgdp_mean, nq(4)

* 4. Invertimos para que 1 sea el más rico y 4 el más pobre
recode atlas (4=1) (3=2) (2=3) (1=4)

* 5. Ponemos las etiquetas oficiales
label define atlas_lbl 1 "PIA" 2 "PIMA" 3 "PIMB" 4 "PIB"
label values atlas atlas_lbl

* 6. Verificamos
tab atlas

**WDI DATA
"INTERNATIONAL TRADE--EXPORT CONSTANT PRICE "
"HOMICIDES- HOMICIDE INDEX NUMERS OF DEATH DUE TO INSECURITY"
"GPD PER CAPITA- CONSTANT PRICE"
"FDI-PERCENTAJE OF GDP"
"Property rights protection Contract enforcement Reliability of legal system"



Rule of Law measures:

Property rights protection
Contract enforcement
Reliability of legal system

These affect trade because:

👉 Firms export more when contracts are enforceable
👉 Investors trust stable legal systems
👉 Trade costs decrease


-----------------------------------------------------------
"THE EFFECT OF CRIME SHOCKS ON INTERNATIONAL TRADE FLOWS"
--------------------------------------------------------------------------------
1.  *We generate variables
--------------------------------------------------------------------------------

rename Exports_num Trade 
rename homicides_num Homicides
rename lgdp_ref lGDP
rename Foreign_num FDI
rename rulelaw_num  Rules


gen lTrade=log(Trade) 


///Rule of Law measures:
*ssc install outreg2
summ lTrade FDI lGDP Rules Homicides

--------------------------------------------------------------------------------
2. *Panel data
--------------------------------------------------------------------------------

xtset country_id Year
xtdescribe


--------------------------------------------------------------------------------
3. Descriptives Statistics  and correlation matrix  
--------------------------------------------------------------------------------
xtsum lTrade FDI lGDP Rules Homicides

pwcorr lTrade  Homicides FDI lGDP Rules , star(.01) bonferroni





-------------------------------------------------------------------------------
4. Figure 1. Correlation betweeen entre Trade and Homicides rate 
--------------------------------------------------------------------------------


twoway ///
(lfit lTrade Homicides) ///
(scatter lTrade Homicides), ///
title("Trade and Homicides Relationship")


graph bar (count), ///
over(yearly_crime_level) ///
title("Distribution of Observations by Crime Level") ///
ytitle("Number of Observations")


-...............................................................................
5. Static Model (OLS)
--------------------------------------------------------------------------------


xtreg lTrade FDI lGDP Rules ///
c.Homicides##i.yearly_crime_level ///
i.Year, fe vce(cluster country_id)


-------------------------------------------------------------------------------
6. Test de Hausman: Elección entre un modelo de efectos fijos y aleatorios 
--------------------------------------------------------------------------------
xtreg lTrade Homicides lGDP FDI Rules i.yearly_crime_level lGDP FDI Rules , fe
estimates store fixed
xtreg lTrade Homicides lGDP FDI Rules i.yearly_crime_level lGDP FDI Rules, re
estimates store random
hausman fixed random                           
//efectos Fijos 0,000//


-----------------------------------------------------------------------------
7.  Wooldridge Test- Autocorrelation measure 
--------------------------------------------------------------------------------
     ** Testing for serial correlation in linear panel-data models by David M. Drukker, Stata Corporation Support:  ddrukker@stata.com.After installation, type help xtserial///
      

xtserial lTrade Homicides lGDP FDI Rules                    //Preset auto//
 



-------------------------------------------------------------------------------
8. Wald y Breusch-Pagan Test-Detention of heterocedasticity
--------------------------------------------------------------------------------
*ssc install xttest3

xtreg  lTrade Homicides lGDP FDI Rules, fe 
xttest3 
               
//si existe heterocedadticidad// efecto panel
//Present heterocedasticity

gen dlTrade=lTrade-l.lTrade
gen dlGDP = D.lGDP

---------------------------------------------------------------------------------
xtline dlTrade,overlay


---------------------------------------------------------------------------------
9. Final regression correct problem of autocorrelation and heteroscedasticity
--------------------------------------------------------------------------------

xtreg lTrade L.lTrade lGDP FDI Rules ///
c.Homicides##i.yearly_crime_level ///
i.Year, fe vce(cluster country_id)

...............................

..........................


xtreg lTrade ///
FDI ///
lGDP ///
Rules ///
c.Homicides##i.yearly_crime_level ///
i.Year, ///
fe vce(cluster country_id)

outreg2 using tabla_static_dynamic.doc, ///
replace ///
label ///
ctitle(Static FE Model) ///
dec(3)


xtreg lTrade ///
L.lTrade ///
lGDP ///
FDI ///
Rules ///
c.Homicides##i.yearly_crime_level ///
i.Year, ///
fe vce(cluster country_id)

outreg2 using tabla_static_dynamic.doc, ///
append ///
label ///
ctitle(Dynamic FE Model) ///
dec(3)


..........................................................................
.........................................................





xtreg lTrade lGDP FDI Rules ///
c.Homicides##i.yearly_crime_level ///
i.Year, fe vce(cluster country_id)

margins yearly_crime_level, dydx(Homicides)

marginsplot, saving(gp12)



margins yearly_crime_level, predict(xb)
marginsplot, saving(gp22)

gr combine  gp12.gph gp22.gph 

