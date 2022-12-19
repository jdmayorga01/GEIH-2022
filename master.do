** ******************************************************************* **
*
* 								CODE SAMPLE
*					WORLD BANK RA POSITION - APPLICATION  
*						JUAN DIEGO MAYORGA DURAN
*
*							MASTER DO FILE
*
** ******************************************************************* **


		* TITLE: 				master.do
		
		* PURPOSE: 				This .do file completes the data clean. The output of is data ready to be used in analysis.
		
		* OUTLINE:				1. Folder path globals
		*						2. Run do files
		
		* PROJECT: 				Code Sample - RA Application
		
		
		* AUTHOR:				Juan Diego Mayorga Duran (juand.mayorga@outlook.com)
		
		
		* DATE:					December 15, 2022
		
		
		* LAST MODIFIED:		December 19, 2022
		
		* NOTES: 				GEIH data is available in the following link: https://microdatos.dane.gov.co//catalog/728/get_microdata. 
		*						For more information on the GEIH please visit the following link: https: 			www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos
		
		*						If this is the FIRST TIME running the code, please leave the preset settings (all locals equal to 1)
		
/*
* Project description -----

The objective of this project is to analyze the labor market of specific vulnerable populations (migrants and disabled persons) using administrative data from the Colombian labor market survey "La Gran Encuesta Integrada de Hogares" (GEIH) in October 2022. 

GEIH produces information at the national, urban-rural level and for the thirteen main cities and metropolitan areas. This is a self-weighting, multistage, stratified, unequal cluster, probability sampling survey. GEIH survey is divided into nine modules, including sociodemographic characteristics, employment, unemployment, and migration, among others. The master data shared for this code sample only includes three modules (General characteristics, employment, and migration) to reduce the size of the data folder. These modules provide rich information about employment status, wages, as well as education level, gender, and other sociodemographic data.	

The purpose of studying the labor market of these specific populations is due to their vulnerability and the barriers they have to access formal and quality employment. In relation to the migrants, in the last few years, Colombia has hosted around 1.8 million migrants from Venezuela. The magnitude of the migration influx has exerted a burden on the labor market and has created vulnerabilities in the migrant population (discrimination, xenophobia, etc.). On the other hand, disabled people in Colombia have different inclusion problems, specifically in terms of the labor market and education. Around 30% of the persons with a disability are permanently unable to work and if they work, they have lower chances of getting a job. Moreover, there is a significant educational gap between the population with and without a disability; an averge 10 p.p difference in all levels of education (primary, secondary and tertiary). 
*/	
* **************************************************************************** *

clear all
set more off

* ************************** *
* 	1. FOLDER PATH GLOBALS 
* ************************** *

	* ------------
	* Users 
		* User number:
		* Juan Diego            1  
		* Other 				2
			
			* User currently working 
			 global user  1
		 
	* ------------
	* Path	
			
		if $user == 1 {
		   global projectfolder "C:\Users\juand\Documents\JUAN DIEGO\Proyectos personales\Code Sample\RA World Bank 2022"
	   }
		* Use the path where the master.do is saved
		if $user == 2 {
		   global projectfolder "PATH"  // Other users
	   }
			
	* ------------
	* Folder globals
		
		* Folder organization: create the folders that are going to be used in the project. This makes the project reproducible.
		* The main folders that are preset in the .zip would be *"Master data, code, and documentation"*. The other folder are generated in the master.do file. 

		* 1. Master data: GEIH and shape data of Colombia.
		* 2. Modified data: Intermediate results of the GEIH processing.
		* 3. Clean data: Final data set used in the analysis (codesample_JDM.dta).
		* 4. Code: This folder should include 5 .do elements (analysis, clean_main, clean_maps, merge and packages). The explanation of each .do can be found below.
		* 5. Outputs: Main tables and graphs created for the analysis.
		* 6. Documentation: GEIH documentation where the description of variables can be found.
 
		
		local project_folders 1
		
			if `project_folders' == 1 {
				capture mkdir "$projectfolder/Modified data"
				capture mkdir "$projectfolder/Clean data"
				capture mkdir "$projectfolder/Outputs"
				
			}
	
		* Do files -----
			global do 			"$projectfolder/Code"
	
		* Master data -----
			global mdata 		"$projectfolder/Master data"
		
		* Modified data -----
			global moddata 		"$projectfolder/Modified data"
			
		* Clean data -----
			global cdata 		"$projectfolder/Clean data"
			
		* Outputs -----
			global outs 		"$projectfolder/Outputs"
	
* ************************** *
* 	2. RUN DO FILES
* ************************** *

* If this is the FIRST TIME running the code, please leave the preset settings (all locals equal to 1)

	* ------------
	* 0. PACKAGES 
	
		* 1 to install ssc packages for this project, 0 otherwise.
		local ssc 1
			
			if `ssc' == 1 {
				qui do "$do/packages.do"
				
			}
		
	* ------------
	* 1. CLEANING 
	* It is recomended just to run this section one time. 
		
		* 1 to execute the merge of the original GEIH datasets process of the data, 0 otherwise
		local merge 1 
		
			if `merge' == 1 {
				* Merge data sets by modules
					qui do "$do/merge.do"

		   }
		   
		* 1 to execute the cleaninig process of the data, 0 otherwise.
		local clean 1
		
			if `clean' == 1 {
				* Data cleaninig of shape file data
					qui do "$do/clean_maps.do"	
				
				* Data cleaninig of master data
					qui do "$do/clean_main.do"	

		   }
		
	* ------------
	* 2. ANALYSIS
	
	* To run this .do you only need the codesample_JDM dataset 
	
		* 1 to execute the analysis .do, 0 otherwise.
		local analysis 1
		
			if `analysis' == 1 {
				
				* Analysis of the data
					qui do "$do/analysis.do"
				
			}

* End