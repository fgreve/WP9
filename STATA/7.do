**VERIFICAR QUE LAS BASES ESTÉN ORDENADAS POR ID (default)
drop _all

use "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE1.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE1v0.dta", replace
use "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE2.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE2v0.dta", replace
use "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE3.dta"
sort ID
save "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE3v0.dta", replace
use C:\Users\fgreve\Dropbox\WP9\data\7\ATRIBUTOS.dta
sort ID

merge ID using "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE1v0.dta"
drop _merge
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE2v0.dta"
drop _merge 
sort ID
merge ID using "C:\Users\fgreve\Dropbox\WP9\data\7\INNOVACIÓN2011_PARTE3v0.dta"
drop _merge 

save "C:\Users\fgreve\Dropbox\WP9\data\7\7v0.dta", replace

gen factor =  FE_VENTAS
gen encuesta = 7

//AÑO
gen año = P024
gen edad = 2010-año

//REGION
*gen region = REGION
gen region=.
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
drop REGION

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
gen empleados_09= P210 
gen empleados_10= P211 

gen profesionales_tecnicos_09 = P208
gen profesionales_tecnicos_10 = P209

//VENTAS
gen ventas_09= P200
gen ventas_10= P201

//VENTAS INNOVADORAS (porcentaje)
gen ventas_inn_porcentaje_09 = (P3014+P3016)/100 
gen ventas_inn_porcentaje_10 = (P3015+P3017)/100
replace ventas_inn_porcentaje_09=0 if ventas_inn_porcentaje_09==.
replace ventas_inn_porcentaje_10=0 if ventas_inn_porcentaje_10==.

//EXPORTACIONES
gen exportaciones_09= P202 
gen exportaciones_10= P203
gen exportaciones_09_dummy = 0
gen exportaciones_10_dummy = 0
replace exportaciones_09_dummy =1 if exportaciones_09>0
replace exportaciones_10_dummy =1 if exportaciones_10>0

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

replace CIIU2_15=1 if DIVISION_ACTIVIDAD==15
replace CIIU2_20=1 if DIVISION_ACTIVIDAD==20
replace CIIU2_21=1 if DIVISION_ACTIVIDAD==21
replace CIIU2_24=1 if DIVISION_ACTIVIDAD==24
replace CIIU2_27=1 if DIVISION_ACTIVIDAD==27
replace CIIU2_28=1 if DIVISION_ACTIVIDAD==28
replace CIIU2_31=1 if DIVISION_ACTIVIDAD==31
replace CIIU2_99=1 if DIVISION_ACTIVIDAD==99

gen manufactura_dummy = 0
replace manufactura_dummy = 1 if CIIU2_15 + CIIU2_20 + CIIU2_21 + CIIU2_24 + CIIU2_27 + CIIU2_28 + CIIU2_31 + CIIU2_99 ==1

//GASTO EN INNOVACION
gen id_09=.
gen id_10=.

gen patentes_09     = cond(P3086==.,0,P3086)
gen capacitacion_09 = cond(P3088==.,0,P3088)
gen otras_09        = cond(P3092==.,0,P3092)
gen introduccion_09 = cond(P3090==.,0,P3090)
gen maquinaria_09   = cond(P3084==.,0,P3084)

gen patentes_10     = cond(P3087==.,0,P3087)
gen capacitacion_10 = cond(P3089==.,0,P3089)
gen otras_10        = cond(P3093==.,0,P3093)
gen introduccion_10 = cond(P3091==.,0,P3091)
gen maquinaria_10   = cond(P3085==.,0,P3085)

gen inn_09=  patentes_09 + capacitacion_09 + otras_09 + introduccion_09 + maquinaria_09
gen inn_10=  patentes_10 + capacitacion_10 + otras_10 + introduccion_10 + maquinaria_10

gen total_09 = inn_09   
gen total_10 = inn_10 

//INNOVACION PRODUCTO NUEVO PARA EL MERCADO  
gen inn_producto= P3004
replace inn_producto= 0 if inn_producto==. 
gen inn_producto_dummy= inn_producto

//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
gen inn_proceso= P3024
replace inn_proceso= 0 if inn_proceso==. 
gen inn_proceso_dummy= inn_proceso

//innovacion de producto y/o proceso
gen inn_producto_o_proceso = inn_proceso_dummy + inn_producto_dummy 
gen inn_producto_o_proceso_dummy = 1
replace inn_producto_o_proceso_dummy =0 if inn_producto_o_proceso == 0

//INFLACIÓN
gen inf_09 = 1.0000
gen inf_10 = 1.0141

gen l = empleados_09
gen L = empleados_10

gen expD = exportaciones_09_dummy
gen EXPD = exportaciones_10_dummy

gen exp    = exportaciones_09/inf_09
gen EXP    = exportaciones_10/inf_10

gen k_ext= capital_extranjero_dummy  

*gen g = total_09/inf_09
*gen G = total_10/inf_10

gen g1 = (maquinaria_09)/inf_09
gen G1 = (maquinaria_10)/inf_10 

gen g2 = (patentes_09)/inf_09
gen G2 = (patentes_10)/inf_10

gen g3 = (capacitacion_09)/inf_09
gen G3 = (capacitacion_10)/inf_10

gen g = g1 + g2 + g3
gen G = G1 + G2 + G3

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

*gen fin = financ_publico_inn 

gen v = ventas_09/inf_09
gen V = ventas_10/inf_10

gen patentes 	     = patentes_09/inf_09
gen capacitacion_inn = capacitacion_09/inf_09  
gen otras_inn	     = otras_09/inf_09        
gen introduccion_inn = introduccion_09/inf_09  
gen maquinaria_inn   = maquinaria_09/inf_09   

gen PATENTES 	     = patentes_10/inf_10
gen CAPACITACION_INN = capacitacion_10/inf_10  
gen OTRAS_INN	     = otras_10/inf_10        
gen INTRODUCCION_INN = introduccion_10/inf_10  
gen MAQUINARIA_INN   = maquinaria_10/inf_10

gen profesionales_tecnicos = profesionales_tecnicos_09
gen PROFESIONALES_TECNICOS = profesionales_tecnicos_10
