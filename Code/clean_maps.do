** ****************************************************************** **
* 								CODE SAMPLE
*							LABOR MARKET - COLOMBIA  
*						JUAN DIEGO MAYORGA DURAN
*
*						CLEAN DATA MAPS DO FILE
*
** ******************************************************************* **


		* TITLE: 				clean_maps.do
		
		* PURPOSE: 				This .do file create maps for the descriptive anlyisis. 
		
		* OUTLINE:				Preparation of spatial data
		
		
		* PROJECT: 				Code Sample - Colombian labor market 
		
		
		* AUTHOR:				Juan Diego Mayorga Duran (juand.mayorga@outlook.com)
		
		
		* DATE:					December 15, 2022
		
		
		* LAST MODIFIED:		December 18, 2022
		
		* NOTES: 				GEIH data is available in the following link: https://microdatos.dane.gov.co//catalog/728/get_microdata. 
		*						For more information on the GEIH please visit the following link: https: 			www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos
		* 						For details on the lab of variables in GEIH please read the documentation stored in the "Documentation" folder.
*******************************************************************************************************************

	* ------------
	* PREPARATION OF THE SPATIAL DATA

	* The shape files for colombia can be downlodead in the following path: https://sites.google.com/site/seriescol/shapes
	* First, we must transform the shp data to dta. 
	
	* Create a new folder in the modified data to save the modified shape data 
		capture mkdir "$moddata/Shape"

	* Transform the shape files into dta
		shp2dta using "$mdata/Maps/depto", database("$moddata/Shape/dta_dpto.dta") coordinates("$moddata/Shape/coor_dpto.dta") genid(id) genc(c) replace
		
	* Transform the data sets to perform a merge with the main dataset.
		cd "$moddata/Shape"
		local folder : dir "$moddata/Shape" files "*.dta*"
		
			foreach file in `folder' {
				
				use `file', clear
				rename *, lower 
				save `file', replace
			}
			
* End
			
