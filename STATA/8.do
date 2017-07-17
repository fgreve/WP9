drop _all

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\ATRIBUTOS_A.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\ATRIBUTOS_A.dta", replace

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\ATRIBUTOS_B.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\ATRIBUTOS_B.dta", replace

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\INNOVACION2013_PARTE1_A.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE1_A.dta", replace

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\INNOVACION2013_PARTE1_B.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE1_B.dta", replace

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\INNOVACION2013_PARTE2_A.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE2_A.dta", replace

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\INNOVACION2013_PARTE2_B.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE2_B.dta", replace

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\INNOVACION2013_PARTE3_A.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE3_A.dta", replace

use "C:\Users\fgreve\Dropbox\WP9\data\8\BD_Formato Stata\INNOVACION2013_PARTE3_B.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE3_B.dta", replace


use C:\Users\fgreve\Dropbox\WP9\data\8\ATRIBUTOS_A.dta
sort ID

merge ID using "C:\Users\fgreve\Dropbox\WP9\data\8\ATRIBUTOS_B.dta"
drop _merge
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE1_A.dta"
drop _merge 
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE1_B.dta"
drop _merge 
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE2_A.dta"
drop _merge 
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE2_B.dta"
drop _merge 
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE3_A.dta"
drop _merge 
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\8\INNOVACION2013_PARTE3_B.dta"
drop _merge 

*drop id

gen factor =  FE_VENTAS
gen encuesta = 8

//AÑO
gen año = P024
gen edad = 2012-año

//REGION
*gen region = REGION
gen region=0
replace region=1 if REGION=="01"
replace region=2 if REGION=="02"
replace region=3 if REGION=="03"
replace region=4 if REGION=="04"
replace region=5 if REGION=="05"
replace region=6 if REGION=="06"
replace region=7 if REGION=="07"
replace region=8 if REGION=="08"
replace region=9 if REGION=="09"
replace region=10 if REGION=="10"
replace region=11 if REGION=="11"
replace region=12 if REGION=="12"
replace region=13 if REGION=="13"
replace region=14 if REGION=="14"
replace region=15 if REGION=="15"
*drop REGION

//PROPIEDAD porcentaje
gen nacional_porcentaje= P026
replace nacional_porcentaje=100 if P025==1
replace nacional_porcentaje=100 if P025==4
replace nacional_porcentaje=0   if P025==2

gen extranjera_porcentaje = P027
replace extranjera_porcentaje=0   if P025==1
replace extranjera_porcentaje=0   if P025==4
replace extranjera_porcentaje=100 if P025==2
count if extranjera_porcentaje==.

//SECTORES
gen categoria = SECTOR_ACTIVIDAD

//TRABAJO
gen empleados_11= P224 
gen empleados_12= P225 

gen profesionales_tecnicos_11 = P224 - (212+213)
gen profesionales_tecnicos_12 = P225 - (218+219)

//VENTAS
gen ventas_11= P200
gen ventas_12= P201

//EXPORTACIONES
gen exportaciones_11= P202 
gen exportaciones_12= P203

gen exportaciones_11_dummy = 0
gen exportaciones_12_dummy = 0

replace exportaciones_11_dummy =1 if exportaciones_11>0
replace exportaciones_12_dummy =1 if exportaciones_12>0


//INVERSION EN LICENCIAS
gen inversion_licencias_11=P3086
gen inversion_licencias_12=P3087
gen inversion_licencias_11_dummy = 0
gen inversion_licencias_12_dummy = 0
replace inversion_licencias_11_dummy =1 if inversion_licencias_11>0
replace inversion_licencias_12_dummy =1 if inversion_licencias_12>0


//PROPIEDAD EXTRANJERA
gen capital_extranjero  = P025
gen capital_extranjero_dummy =1
replace capital_extranjero_dummy  =0 if capital_extranjero ==1 | capital_extranjero ==4


//dummies sectoriales

gen CIIU2_15=0
gen CIIU2_20=0
gen CIIU2_21=0
gen CIIU2_24=0
gen CIIU2_27=0
gen CIIU2_28=0
gen CIIU2_31=0
gen CIIU2_99=0

replace CIIU2_15=1 if DIVISION_ACTIVIDAD=="15"
replace CIIU2_20=1 if DIVISION_ACTIVIDAD=="20"
replace CIIU2_21=1 if DIVISION_ACTIVIDAD=="21"
replace CIIU2_24=1 if DIVISION_ACTIVIDAD=="24"
replace CIIU2_27=1 if DIVISION_ACTIVIDAD=="27"
replace CIIU2_28=1 if DIVISION_ACTIVIDAD=="28"
replace CIIU2_31=1 if DIVISION_ACTIVIDAD=="31"
replace CIIU2_99=1 if DIVISION_ACTIVIDAD=="99"

gen manufactura_dummy = 0
replace manufactura_dummy = 1 if CIIU2_15 + CIIU2_20 + CIIU2_21 + CIIU2_24 + CIIU2_27 + CIIU2_28 + CIIU2_31 + CIIU2_99 ==1

//GASTO EN INNOVACIÓN

gen id_11=.
gen id_12=.

gen patentes_11     = cond(P3086==.,0,P3086)
gen capacitacion_11 = cond(P3088==.,0,P3088)
gen otras_11        = cond(P3092==.,0,P3092)
gen introduccion_11 = cond(P3090==.,0,P3090)
gen maquinaria_11   = cond(P3084==.,0,P3084)

gen patentes_12     = cond(P3087==.,0,P3087)
gen capacitacion_12 = cond(P3089==.,0,P3089)
gen otras_12        = cond(P3093==.,0,P3093)
gen introduccion_12 = cond(P3091==.,0,P3091)
gen maquinaria_12   = cond(P3085==.,0,P3085)

gen inn_11=  patentes_11 + capacitacion_11 + otras_11 + introduccion_11 + maquinaria_11
gen inn_12=  patentes_12 + capacitacion_12 + otras_12 + introduccion_12 + maquinaria_12

gen total_11 = inn_11   
gen total_12 = inn_12


//INFLACIÓN
*drop inn
*gen inn_=cond(P3000+P3002>0,1,0)
*gen inn_=cond(P3004>0,1,0)
gen inn_=1

gen inf_11 = 1.048
gen inf_12 = 1.062

gen l = empleados_11
gen L = empleados_12

gen expD = exportaciones_11_dummy
gen EXPD = exportaciones_12_dummy

gen exp    = exportaciones_11/inf_11
gen EXP    = exportaciones_12/inf_12

gen k_ext= capital_extranjero_dummy  

gen licD   = inversion_licencias_11_dummy

gen lic = inversion_licencias_11/inf_11
gen LIC = inversion_licencias_12/inf_12

*gen g = total_11/inf_11
*gen G = total_12/inf_12

gen g1 = inn_*(maquinaria_11+otras_11)/inf_11
gen G1 = inn_*(maquinaria_12+otras_12)/inf_12 

gen g2 = inn_*(patentes_11)/inf_11
gen G2 = inn_*(patentes_12)/inf_12

gen g3 = inn_*(capacitacion_11)/inf_11
gen G3 = inn_*(capacitacion_12)/inf_12

gen g = g1 + g2 + g3
gen G = G1 + G2 + G3

gen v = ventas_11/inf_11
gen V = ventas_12/inf_12

gen patentes 	     = patentes_11/inf_11
gen capacitacion_inn = capacitacion_11/inf_11  
gen otras_inn	     = otras_11/inf_11        
gen introduccion_inn = introduccion_11/inf_11  
gen maquinaria_inn   = maquinaria_11/inf_11   

gen PATENTES 	     = patentes_12/inf_12
gen CAPACITACION_INN = capacitacion_12/inf_12  
gen OTRAS_INN	     = otras_12/inf_12        
gen INTRODUCCION_INN = introduccion_12/inf_12  
gen MAQUINARIA_INN   = maquinaria_12/inf_12

gen profesionales_tecnicos = profesionales_tecnicos_11
gen PROFESIONALES_TECNICOS = profesionales_tecnicos_12

drop DV_ID DIVISION_ACTIVIDAD
