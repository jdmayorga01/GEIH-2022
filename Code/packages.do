** ****************************************************************** **
* 								CODE SAMPLE
*							LABOR MARKET - COLOMBIA  
*						JUAN DIEGO MAYORGA DURAN
*
*							SSC PACKAGES DO FILE
*
** ******************************************************************* **


		* TITLE: 				packages.do
		
		* PURPOSE: 				This .do file cleans the data set. 
		
		* OUTLINE:				1. List of relevant packages from SSC
		
		
		* PROJECT: 				Code Sample - Colombian labor market 
		
		
		* AUTHOR:				Juan Diego Mayorga Duran (juand.mayorga@outlook.com)
		
		
		* DATE:					December 15, 2022
		
		
		* LAST MODIFIED:		December 18, 2022
		
		* NOTES: 				GEIH data is available in the following link: https://microdatos.dane.gov.co//catalog/728/get_microdata. 
		*						For more information on the GEIH please visit the following link: https: 			www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos
		* 						For details on the lab of variables in GEIH please read the documentation stored in the "Documentation" folder.
*******************************************************************************************************************

	* ------------
	* LIST OF RELEVANT PACKAGES
	
		* codebook
			ssc install wordcb, replace
			
		* Tables
			ssc install outreg2, replace
			ssc install estout, replace
			
		* Spatial anylsis 
			ssc install shp2dta, replace
			ssc install spmap, replace
			ssc install spgrid, replace
			ssc install spkde, replace
			ssc install sppack, replace
			
* End
