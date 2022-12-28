** ****************************************************************** **
* 								CODE SAMPLE
*							LABOR MARKET - COLOMBIA  
*						JUAN DIEGO MAYORGA DURAN
*
*							MERGE DO FILE
*
** ******************************************************************* **


		* TITLE: 				merge.do
		
		* PURPOSE: 				This .do file merge the GEIH 2022 data into one dataset. 
		
		* OUTLINE:				1. Description of GEIH 
		*						2. Global and local variables for the merge
		*						3. Merge of the data set
		*						4. Filter of relevant variables
		
		* PROJECT: 				Code Sample - Colombian labor market 
		
		
		* AUTHOR:				Juan Diego Mayorga Duran (juand.mayorga@outlook.com)
		
		
		* DATE:					December 15, 2022
		
		
		* LAST MODIFIED:		December 18, 2022
		
		* NOTES: 				GEIH data is available in the following link: https://microdatos.dane.gov.co//catalog/728/get_microdata. 
		*						For more information on the GEIH please visit the following link: https: 			www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos
		*						To run this .do is important to download all the data sets in the "Maste data" folder.
*******************************************************************************************************************

	* ------------
	* DESCRIPTION OF GEIH 
/*
		
	 "La Gran Encuesta Integrada de Hogares" (GEIH) produces information at the national, urban-rural level and for the thirteen main cities and metropolitan areas. This is a self-weighting, multistage, stratified, unequal cluster, probability sampling survey.

	GEIH survey is divided into nine modules, including sociodemographic characteristics, employment, unemployment, and migration, among others. The master data shared for this code sample only includes three modules (General characteristics, employment, and migration) due to the fact that the data folder is very large. 

	These modules provide rich information about employment status, wages, as well as education level, gender, and other sociodemographic data.
	
	For this specific sample data, I will work with the latest data of GEIH published, October 2022.

*/

	* ------------
	* GLOBAL AND LOCAL VARIABLES  
	
	* These locals and globals are based on the raw data of GEIH that can be found in the "2. Master data" folder. Commonly, the microdata comes by month and module. Therefore, we have to perform a series of loops to merge and append the information together. As the objective of this code is to analyze the labor market of vulnerable populations (migrants and disabled persons).
		
		* Specifically, we are interested in five modules:
		
			* General characteristics, social security in health and education
			* Employment
			* Migration 
			
		* Modules ------
			local modules `" Migration Employment"' // General characteristics module is not included in this local due to the fact that we would use that data set to merge and append the whole information
			
		* Merge varlist ------
			global id_merge DIRECTORIO SECUENCIA_P ORDEN // These variables help identify individuals across datasets and therefore merge them.
		
	* ------------
	* MERGE OF THE DATA 
	
	* Create a new folder to store the new data sets so that anyone who is replicating can have the same folders and therefore, the code is more efficient.
		capture mkdir "$moddata/GEIH"
	
	* Loop: Merge the data by month. 
		* The main .dta corresponds to the "Características generales" dataset, all of the survey respondents answer this module. Therefore, the most efficient way of merging the information is to this module. Take into account that the other modules are not answered by all the respondents, thats why in some cases the merge is not 1:1 (_merge==3). 
			
		use "$mdata/GEIH/GEIH_Octubre_Marco_2018/General characteristics", clear
		foreach l of local modules {
					
			merge 1:1 $id_merge using "$mdata/GEIH/GEIH_Octubre_Marco_2018/`l'"
			drop _merge 
			
				}
				
		rename *, lower // In some cases, GEIH variables come in lower case. With this code we can standarize all variables. 
		compress // GEIH information is very large, so it is important to compress the data
		
	* ------------
	* LIST OF RELEVANT VARIABLES
	
	* As the dataset is large and GEIH modules include some variables we won't use in this analysis, this subsection will filter the information.
	
		* Identification variables ------
			global id directorio secuencia_p orden hogar regis clase mes dpto fex_c18
				* directorio, secuencia_p, orden, hogar, regis: survey id variables for each respondent
				* clase: identifiy if the respondent lives in a urban or rural area (dummy)
				* mes: month of the survey 
				* dpto: administrative division
				* fex_c18: expansion factor 
			
		* Sociodemographic characteristics ------
			global char p3271 p6040 p6050 p6070 p3042
				* p3271: sex
				* p6040: age 
				* p6050: household head
				* p6070: marital status
				* p3042: level of education

		* Employment variables ------
			global emp oci ft p6090 p6920 p6800 p7050 inglabo pt
				* oci: employed (dummy)
				* ft: labor force (dummy)
				* p6090: social security (health)
				* p6920: social security (pension) 
				* p6800: weekly work hours 
				* p7050: type of worker
				* inglabo: labor income
				* pt: Total population
			
		* Specific populations ------
			global groups discapacidad p3373s3
				* p3373s3: nationality
				* discapacidad: disabled persons 
				
	* Keep the variables of interest
		keep $id $char $emp $groups
	
* Save the data set to modified data folder
compress	
save "$moddata/GEIH/geih_filter", replace

* End
