drop _all
set memory 1g

******************BASES DE DATOS******************************************************
run  "C:\Users\fgreve\Dropbox\WP9\stata\7.do"
save "C:\Users\fgreve\Dropbox\WP9\stata\7.dta", replace
drop _all

run  "C:\Users\fgreve\Dropbox\WP9\stata\8.do"
save "C:\Users\fgreve\Dropbox\WP9\stata\8.dta", replace
drop _all

*use "C:\Users\fgreve\Dropbox\WP9\stata\7.dta"
*append using "C:\Users\fgreve\Dropbox\WP9\stata\8.dta"

use "C:\Users\fgreve\Dropbox\WP9\stata\8.dta"

count
scalar count_all = r(N)

drop if manufactura_dummy==0 
count
scalar count_manuf = r(N)

************VARIABLES***************************************************************
gen vl          = v/l
gen VL          = V/L
gen gl       	= g/l
gen GL       	= G/L

gen gv       	= g/v
gen GV       	= G/V
gen ev       	= exp/v
gen EV       	= EXP/V
gen el       	= exp/l
gen EL       	= EXP/L
gen ln_ev    	= ln(ev)
gen ln_EV    	= ln(EV)

gen G_mil    	= G/1000 
gen EXP_mil  	= EXP/1000

*gen ln_g       = ln(g)
*gen ln_G       = ln(G)
gen gD         = cond(g>0,1,0)
gen GD  		= cond(G>0,1,0)
*gen gl       	= g/l
*gen GL       	= G/L

gen g1D         = cond(g1>0,1,0)
gen G1D  		= cond(G1>0,1,0)
gen g1l       	= g1/l
gen G1L       	= G1/L

gen ln_g2       = ln(g2)
gen ln_G2       = ln(G2)
gen g2D         = cond(g2>0,1,0)
gen G2D  		= cond(G2>0,1,0)
gen g2l       	= g2/l
gen G2L       	= G2/L

gen ln_g3       = ln(g3)
gen ln_G3       = ln(G3)
gen g3D         = cond(g3>0,1,0)
gen G3D  		= cond(G3>0,1,0)
gen g3l       	= g3/l
gen G3L       	= G3/L


gen sector_1 = CIIU2_15
gen sector_2 = CIIU2_20
gen sector_3 = CIIU2_21
gen sector_4 = CIIU2_24
gen sector_5 = CIIU2_27
gen sector_6 = CIIU2_28
gen sector_7 = CIIU2_31
gen sector_8 = CIIU2_99

gen Subsector_=.
replace Subsector_=1 if sector_1==1
replace Subsector_=2 if sector_2==1
replace Subsector_=3 if sector_3==1
replace Subsector_=4 if sector_4==1
replace Subsector_=5 if sector_5==1
replace Subsector_=6 if sector_6==1 
replace Subsector_=7 if sector_7==1
replace Subsector_=8 if sector_8==1

recode Subsector_ ///
(1 = 1 "1") ///
(2 = 2 "2") ///
(3 = 3 "3") ///
(4 = 4 "4") ///
(5 = 5 "5") ///
(6 = 6 "6") ///
(7 = 7 "7") ///
(8 = 8 "8"), ///
gen(Subsector) 

gen enc_7 = 0
gen enc_8 = 0
replace enc_7=1 if encuesta==7
replace enc_8=1 if encuesta==8

gen gasto = .
replace gasto =  0 if G>0
replace gasto =  1 if G1>0
replace gasto =  2 if G2>0
replace gasto =  3 if G3>0


forv i = 1/15 {
gen region`i' =cond(region==`i',1,0)
}

gen  n_GD       = cond(GD==0,1,0)
gen  n_G1D      = cond(G1D==0,1,0)
gen  n_G2D      = cond(G2D==0,1,0)
gen  n_G3D      = cond(G3D==0,1,0)
gen  n_EXPD     = cond(EXPD==0,1,0)
gen  n_k_ext    = cond(k_ext==0,1,0)

gen exp_innov      = GD*EXPD
gen exp_innov1     = G1D*EXPD
gen exp_innov2     = G2D*EXPD
gen exp_innov3     = G3D*EXPD


gen GD_x100        = GD*100
gen n_GD_x100      = n_GD*100
gen G1D_x100       = G1D*100
gen n_G1D_x100     = n_G1D*100
gen G2D_x100       = G2D*100
gen n_G2D_x100     = n_G2D*100
gen G3D_x100       = G3D*100
gen n_G3D_x100     = n_G3D*100

gen k_ext_x100     = k_ext*100
gen n_k_ext_x100   = n_k_ext*100
gen EXPD_x100      = EXPD*100
gen n_EXPD_x100    = n_EXPD*100
gen INN            = factor
gen exp_innov_x100 = exp_innov*100
gen exp_innov1_x100= exp_innov1*100
gen exp_innov2_x100= exp_innov2*100
gen exp_innov3_x100= exp_innov3*100

gen l1 = cond(l<50,1,0)
gen l2 = cond(l<200,1,0) - l1
gen l3 = cond(200<l,1,0) 

gen l1_x100 = l1*100
gen l2_x100 = l2*100
gen l3_x100 = l3*100

*****LIMPIEZA DE DATOS****************************************************************
count
scalar count_clean0 = r(N)

drop if l==. | L==. | l==0 | L==0
drop if v==. | V==. | v==0 | V==0
drop if exp>v | EXP>V | g>v | g>V 

count
scalar count_clean1 = r(N)

************LABELS*****************************************************************
label variable v             		"Sales"    
label variable V            		"Sales"

label variable g             		"Innov.Exp"    
label variable G            		"Innov.Exp"

label variable exp           		"Export"  
label variable EXP           		"Export"

label variable l                    "Labor" 
label variable L                    "Labor"

label variable GD                   "Innov.Expend^d [general]"  
label variable gD                   "Innov.Expend^d [general]"
label variable G1D                  "Innov.Expend^d [tech]"  
label variable g1D                  "Innov.Expend^d [tech]"
label variable G2D                  "Innov.Expend^d [know]"  
label variable g2D                  "Innov.Expend^d [know]"
label variable G3D                  "Innov.Expend^d [train]"  
label variable g3D                  "Innov.Expend^d [train]"
  
label variable expD                 "Export^d" 
label variable k_ext                "Foreign.Property^d"
label variable EXPD        		    "Export^d"

label variable vl           		"Labor Productivity"
label variable VL           		"Labor Productivity"
label variable G_mil 				"Gasto.Innov"
label variable EXP_mil 				"Export"

label variable GL 					"Innov.Exp.Worker"
label variable gl 					"Innov.Exp.Worker"

label variable GL 					"Innov.Effort [general]"
label variable gl 					"Innov.Effort [general]"
label variable G1L 					"Innov.Effort [tech]"
label variable g1l 					"Innov.Effort [tech]"
label variable G2L 					"Innov.Effort [know]"
label variable g2l 					"Innov.Effort [know]"
label variable G3L 					"Innov.Effort [train]"
label variable g3l 					"Innov.Effort [train]"

label variable EV 					"Export.Intensity"
label variable ev 					"Export.Intensity"
label variable EL 					"Export.worker"
label variable el 					"Export.worker"

global encuesta 					"enc_7 enc_8"
global sector 						"CIIU2_15 CIIU2_20 CIIU2_21 CIIU2_24 CIIU2_27 CIIU2_28 CIIU2_31 "
global region						"region1 region2 region3 region4 region5 region6 region7 region8 region9 region10 region11 region12 region13 region14 " 

label variable GD_x100 		    	"Innov.Expend [general]"
label variable G1D_x100 			"Innov.Expend [tech]"
label variable G2D_x100 			"Innov.Expend [know]"
label variable G3D_x100 			"Innov.Expend [train]"

label variable k_ext_x100 			"Foreign.Property"
label variable EXPD_x100 			"Export."
label variable INN 					"Represented Firms"

label variable exp_innov_x100 		"Innov [general]. and Export."
label variable exp_innov1_x100 		"Innov [tech] and Export."
label variable exp_innov2_x100 		"Innov [know] and Export."
label variable exp_innov3_x100 		"Innov [train] and Export."

label variable l1_x100 				"Small firms"
label variable l2_x100 				"medium firms"
label variable l3_x100 				"large firms"

***************************************************************************************************************************
gen lnV   = log(V)
gen lnEXP = log(EXP)
gen lnG   = log(G)
gen lnL   = log(L)
    
label variable lnV "Sales"
label variable lnG "Innov.Exp"
label variable lnEXP "Export"
label variable lnL "Labor"

global vars "lnV lnEXP lnG lnL"
//EST.DESCRIPTIVA X SECTOR
eststo A: quiet estpost su $vars , detail
eststo N: quiet estpost su $vars if GD== 0, detail
eststo S: quiet estpost su $vars if GD== 1, detail
forv i = 1/3 {
eststo E`i': quiet estpost su $vars if gasto==`i' , detail
}
esttab A N S E1 E2 E3 /// 
using "C:\Users\fgreve\Dropbox\WP9\doc\estdesc0.rtf", ///
mlabel("all-sample" "no-expend" "expend" "tech" "know" "train") ///
title("Summary Stats Mean, by type (logarithmic values)") ///
replace collabels(none)  label nogaps nonumbers /// 
addnotes("Source: Authors elaboration.") ///
cells(mean(fmt(%12.1fc)))

***************************************************************************************************************************
gen lnVL = log(VL) 
gen lnEL = log(EL)
gen lnGL = log(GL)

label variable lnVL "Labor Productivity"
label variable lnEL "Export.worker"
label variable lnGL "Innov.Exp.Worker"

global vars "lnVL lnEL lnGL"
//EST.DESCRIPTIVA X SECTOR
eststo A: quiet estpost su $vars , detail
eststo N: quiet estpost su $vars if GD== 0, detail
eststo S: quiet estpost su $vars if GD== 1, detail
forv i = 1/3 {
eststo E`i': quiet estpost su $vars if gasto==`i' , detail
}
esttab A N S E1 E2 E3 /// 
using "C:\Users\fgreve\Dropbox\WP9\doc\estdesc1.rtf", ///
mlabel("all-sample" "no-expend" "expend" "tech" "know" "train") ///
title("Summary Stats Mean, by type (logarithmic values)") ///
replace collabels(none)  label nogaps nonumbers /// 
addnotes("Source: Authors elaboration.") ///
cells(mean(fmt(%12.1fc)))

***************************************************************************************************************************
gen EV100 = EV*100
gen GV100 = GV*100

label variable EV100 "Export.Intensity"
label variable GV100 "Innov.Intensity"

global vars "EV100 GV100"
//EST.DESCRIPTIVA X SECTOR
eststo A: quiet estpost su $vars , detail
eststo N: quiet estpost su $vars if GD== 0, detail
eststo S: quiet estpost su $vars if GD== 1, detail
forv i = 1/3 {
eststo E`i': quiet estpost su $vars if gasto==`i' , detail
}
esttab A N S E1 E2 E3 /// 
using "C:\Users\fgreve\Dropbox\WP9\doc\estdesc2.rtf", ///
mlabel("all-sample" "no-expend" "expend" "tech" "know" "train") ///
title("Summary Stats Mean, by type (percent values)") ///
replace collabels(none)  label nogaps nonumbers /// 
addnotes("Source: Authors elaboration.") ///
cells(mean(fmt(%12.1fc)))

***************************************************************************************************************************
global vars "EXPD_x100 k_ext_x100 l1_x100 l2_x100 l3_x100"
//EST.DESCRIPTIVA X SECTOR
eststo A: quiet estpost su $vars , detail
eststo N: quiet estpost su $vars if GD== 0, detail
eststo S: quiet estpost su $vars if GD== 1, detail
forv i = 1/3 {
eststo E`i': quiet estpost su $vars if gasto==`i' , detail
}
esttab A N S E1 E2 E3 /// 
using "C:\Users\fgreve\Dropbox\WP9\doc\estdesc3.rtf", ///
mlabel("all-sample" "no-expend" "expend" "tech" "know" "train") ///
title("Summary Stats, by type (%)") ///
replace collabels(none)  label nogaps nonumbers /// 
addnotes("Source: Authors elaboration.") ///
cells(mean(fmt(%12.1fc)))

*****CAUSALIDAD**********************************************************************
*****GASTO EN INNOVACION GENERAL*****************************************************************
global control 
*"l k_ext"
label variable ev          "\$Export.Intensity_{t-1}$"
label variable EV          "\$Export.Intensity_{t}$"

*****CAUSALIDAD EXPORTACIÓN SOBRE VENTAS
gen g_l = gl
gen G_L = GL
label variable G_L          "\$Innov.Effort_{t}$"
label variable g_l          "\$Innov.Effort_{t-1}$"
quiet tobit EV  ev G_L g_l $control  $sector $region, ll(0)
quiet test (_b[g_l]=0) (_b[G_L]=0) 
eststo c , add(Fc_g r(F) p_g r(p) )

drop g_l G_L
gen g_l = g1l
gen G_L = G1L
label variable G_L          "\$Innov.Effort_{t}$"
label variable g_l          "\$Innov.Effort_{t-1}$"
quiet tobit EV  ev G_L g_l g2D g3D $control  $sector $region, ll(0)
quiet test (_b[g_l]=0) (_b[G_L]=0) 
eststo c1 , add(Fc_g r(F) p_g r(p) )

drop g_l G_L
gen g_l = g2l
gen G_L = G2L
label variable G_L          "\$Innov.Effort_{t}$"
label variable g_l          "\$Innov.Effort_{t-1}$"
quiet tobit EV  ev G_L g_l g1D g3D $control  $sector $region, ll(0)
quiet test (_b[g_l]=0) (_b[G_L]=0) 
eststo c2 , add(Fc_g r(F) p_g r(p) )

drop g_l G_L
gen g_l = g3l
gen G_L = G3L
label variable G_L          "\$Innov.Effort_{t}$"
label variable g_l          "\$Innov.Effort_{t-1}$"
quiet tobit EV  ev G_L g_l g1D g2D $control  $sector $region, ll(0)
quiet test (_b[g_l]=0) (_b[G_L]=0) 
eststo c3 , add(Fc_g r(F) p_g r(p) )

esttab c c1 c2 c3 ///
using "C:\Users\fgreve\Dropbox\WP9\doc\GrangerExportacion.rtf", ///
keep(G_L g_l) ///cells(none) suprime coeficientes de la regresion
cells(_sign) ///
nogaps collabels(none) ///
mlabel("general" "tech" "know" "train") /// 
indicate( "FE Other Expend. = g1D g3D" "FE Sector = CIIU2_15" "FE Geog = region1") ///
star type not label nonumbers replace /// 
star(* 0.10 ** 0.05 *** 0.01) ///
substitute(_ _  $  $  %  \% ) ///
title("F-statistics, Granger Causality Test: Export Intensity") ///
stats(Fc_g p_g  N N_unc N_lc cmd, /// 
fmt(%15.2fc %15.2fc %15.0fc %15.0fc %15.0fc ) ///
labels("F-stat." "Prob $>$ F" "Obs." "Obs.Uncensured" "Obs.Censured" "Estimation")) ///              
addnotes("Source: Author's elaboration based on information from the EIT and Enia." ///
"Control Var: Labor, Foreign Property.")










*****CAUSALIDAD GASTO EN INNOVACIÓN
quiet tobit GL gl EV ev $control  $sector $region, ll(0)
quiet test (_b[ev]=0) (_b[EV]=0) 
eststo c , add(Fc_ev r(F) p_ev r(p) )

quiet tobit G1L g1l EV ev g2D g3D $control $sector $region, ll(0)
quiet test (_b[ev]=0) (_b[EV]=0) 
eststo c1 , add(Fc_ev r(F) p_ev r(p) )

quiet tobit G2L g2l EV ev g1D g3D $control $sector $region, ll(0)
quiet test (_b[ev]=0) (_b[EV]=0) 
eststo c2 , add(Fc_ev r(F) p_ev r(p) )

quiet tobit G3L g3l EV ev g1D g2D $control $sector $region, ll(0)
quiet test (_b[ev]=0) (_b[EV]=0) 
eststo c3 , add(Fc_ev r(F) p_ev r(p) )

esttab c c1 c2 c3  ///
using "C:\Users\fgreve\Dropbox\WP9\doc\GrangerGasto.rtf", ///
keep(EV ev) ///cells(none) suprime coeficientes de la regresion
cells(_sign) ///
nogaps collabels(none) /// 
indicate( "FE Other Expend. = g1D g3D" "FE Sector = CIIU2_15" "FE Geog = region1") ///
mlabel("general" "tech" "know" "train") ///  
star type not label nonumbers replace /// 
star(* 0.10 ** 0.05 *** 0.01) ///
substitute(_ _  $  $  %  \% ) ///
title("F-statistics, Granger Causality Test: Innovation Effort") ///
stats(Fc_ev p_ev  N N_unc N_lc cmd, /// 
fmt(%15.2fc %15.2fc %15.0fc %15.0fc %15.0fc ) ///
labels("F-estat." "Prob $>$ F" "Obs." "Obs.Uncensured" "Obs.Censured" "Estimation")) ///             
addnotes("Source: Author's elaboration based on information from the EIT and Enia." ///
"Control Var: Labor, Foreign Property.")

