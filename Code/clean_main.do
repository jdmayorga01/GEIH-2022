** ****************************************************************** **
* 								CODE SAMPLE
*					WORLD BANK RA POSITION APPLICATION  
*						JUAN DIEGO MAYORGA DURAN
*
*							CLEAN DO FILE
*
** ******************************************************************* **


		* TITLE: 				clean_main.do
		
		* PURPOSE: 				This .do file cleans the data set. 
		
		* OUTLINE:				1. Generation, rename and labs of relavant variables
		*						2. Codebook
		*						3. Final data set
		
		
		* PROJECT: 				Code Sample - RA Application
		
		
		* AUTHOR:				Juan Diego Mayorga Duran (juand.mayorga@outlook.com)
		
		
		* DATE:					December 15, 2022
		
		
		* LAST MODIFIED:		December 18, 2022
		
		* NOTES: 				GEIH data is available in the following link: https://microdatos.dane.gov.co//catalog/728/get_microdata. 
		*						For more information on the GEIH please visit the following link: https: 			www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos
		* 						For details on the lab of variables in GEIH please read the documentation stored in the "Documentation" folder.
*******************************************************************************************************************

* Data set ----
	use "$moddata/GEIH/geih_filter", clear
	
	* ------------
	* GENERATION, RENAME AND LABELS OF RELEVANT VARIABLES
	
	* This section has the purpose of creating and changing the variables so that they are organized for the analysis
		
		* Identification variables ------
			
			* Area 
				g urban = 1 if clase == "1"
				replace urban = 0 if clase == "2"
				lab var urban "Urban area"
				lab def urban 1 "Urban" 0 "Rural" , replace
				lab val urban urban
				
			* Month 
				rename mes month
				lab var month "Month"
				
			* Expansion factor 
				lab var fex_c18 "Expansion factor"
			
		* Sociodemographic characteristics ------
			
			* Sex 
				rename p3271 sex 
				replace sex = 0 if sex == 2
				lab var sex "Sex"
				lab def sex 1 "Male" 0 "Female" , replace
				lab val sex sex
			
			* Age 
				rename p6040 age 
				lab var age "Age (years)"
				
			* Age ranges
				g agegrp = 1 if age >= 15 & age <= 24 
				replace agegrp = 2 if age >= 25 & age <= 54
				replace agegrp = 3 if age >= 55
				lab var agegrp "Age range"
				lab def agegrp 1 "15 to 24 years" 2 "25 to 54 years" 3 "More than 55 years" , replace
				lab val agegrp agegrp
			
			* Head of household: if p6050 == 1 the respondent is the household head.
				g hh_head = 1 if p6050 == 1 
				replace hh_head = 0 if hh_head == .
				lab var hh_head "Head of the household"
				lab def hh_head 1 "Head" 0 "Other" , replace
				lab val hh_head hh_head
				
			* Maritial status: 1 if the respondent is in a relation (any type), 2   , 0 if single
				g maritial = 1 if inlist(p6070, 1,2,3)
				replace maritial = 0 if inlist(p6070, 4,5,6)
				lab var maritial "Maritial status"
				lab def maritial 1 "Has a relationship" 0 "Single" , replace
				lab val maritial maritial
				
			* Level of education: We would divide the education levels in four. Primary, secondary, tertiary and none education. 
				g edu = 9 if inlist(p3042, 1, 99) // No education
				replace edu = 1 if inlist(p3042, 2,3) // Primary: preeschool and primary
				replace edu = 2 if inlist(p3042, 4,5,6,7) // Secondary
				replace edu = 3 if inlist(p3042, 8,9,10,11,12,13) // Tertiary: technological, bachelor's, specialization, master, doctorate				
				lab var edu "Level of education"
				lab def edu 1 "Primary" 2 "Secondary" 3 "Tertiary" 9 "No education" , replace
				lab val edu edu
				
		* Employment variables ------
		
			* Labor force: DANE definition considers the labor force of those older than 15 years.
				g lab_force = 1 if age >= 15 
				replace lab_force = 0 if lab_force == . 
				lab var lab_force "Labor force participation"
		
			* Employment
				rename oci emp
				replace emp = 0 if emp == . & lab_force == 1 // to calculate the employment rate (employed/labor force)
				lab var emp "Employment rate"
				lab def emp 1 "Employed" , replace
				lab val emp emp
				
			* Total population
				egen total_pop = sum(pt*fex_c18) 
				lab var total_pop "Total population"
				
				
			* Informality: We would follow the definition of informality that considers those workers who pay social security; health and pension. 
				g informal = 1 if (p6090 == 1 & p6920 == 1) 
				replace informal = 0 if informal == . & emp == 1 // Guarantee that the calculations of informality are only for employed respondents
				lab var informal "Informality rate"
				lab def informal 1 "Informal" 0 "Formal" , replace
				lab val informal informal
				
			* Hours work (weekly)
				rename p6800 h_hork
				lab var h_hork "Weekly hours worked"
				
			* Income 
				rename inglabo lab_income
				lab var lab_income "Labor income"
				format lab_income %12.0f // Change form cientific notation
				
				*Log of the income; would be used in the regression analysis
					g ln_income = ln(lab_income)
					lab var lab_income "Labor income (ln)"
				
			* Type of worker 
				g type_worker = 1 if inlist(p7050, 1,2) // Wage worker
				replace type_worker = 2 if inlist(p7050, 4, 6, 7) // Self employed
				replace type_worker = 3 if p7050 == 5 // Employer
				replace type_worker = 4 if p7050 == 8 // Day workers
				replace type_worker = 5 if p7050 == 9 // Temporal workers
				lab var type_worker "Type of worker"
				lab def type_worker 1 "Wage worker" 2 "Self-employed" 3 "Employer" 4 "Day worker" 5 "Temporal worker" , replace
				lab val type_worker type_worker
				
		* Specific populations ------
		
			* Migrant: p3373s3 has different nationalities, therefore we would create a dummy variable that groups all of them. 
				g mig = 1 if p3373s3 != . 
				replace mig = 0 if p3373s3 == . // Colombian respondents do not answer this question 
				lab var mig "Migrant"
				lab def mig 1 "Migrant" 0 "Native" , replace
				lab val mig mig
				
			* Disable person
				rename discapacidad dis_person 
				replace dis_person = 0 if dis_person == .
				lab var dis_person "Disable person"
				lab def dis_person 1 "Disable" 0 "Nondisabled" , replace
				lab val dis_person dis_person
				
				
		* Drop variables that were transformed
			drop p3042 p3373s3 p6050 p6070 p6090 p6920 p7050 clase
			
	* ------------
	* CODEBOOK
		wordcb using "$outs/codebook", replace
		
	* ------------
	* FINAL DATA SET
		compress
		save "$cdata/codesample_JDM", replace

* End