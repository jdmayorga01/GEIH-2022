** ****************************************************************** **
* 								CODE SAMPLE
*							LABOR MARKET - COLOMBIA  
*						JUAN DIEGO MAYORGA DURAN
*
*							ANALYSIS DO FILE
*
** ******************************************************************* **


		* TITLE: 				analysis.do
		
		* PURPOSE: 				This .do file runs a descriptive analysis of the codesample_JDM data set based on GEIH 
		
		* OUTLINE:				1. Descriptive tables 
		*						2. Descriptive spatial maps
		*						3. Regression analysis
		
		* PROJECT: 				Code Sample - Colombian labor market 
		
		
		* AUTHOR:				Juan Diego Mayorga Duran (juand.mayorga@outlook.com)
		
		
		* DATE:					December 15, 2022
		
		
		* LAST MODIFIED:		December 18, 2022
		
		* NOTES: 				GEIH data is available in the following link: https://microdatos.dane.gov.co//catalog/728/get_microdata. 
		*						For more information on the GEIH please visit the following link: https: 			www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos
*******************************************************************************************************************

* Data set ----
	use "$cdata/codesample_JDM", clear
				
	* ------------
	* DESCRIPTIVE TABLES
	
		* 0. General descriptive table  
		
			* Global variables divided into groups
			* Take into acount that factor variables are treated different in the table and collect command in STATA
			global emp lab_force h_hork emp lab_income informal
			global general_fac type_worker edu agegrp
			global general age sex maritial hh_head urban
			global pob mig dis_person 
			
			* Total population --------
			
			* General stadistics table
				table (var) [iw=fex_c18], statistic(mean $emp) statistic(fvpercent $general_fac) statistic(mean $general) statistic(mean $pob) // In the weights the expansion factor is not divided as we only analysis one month
				
				* Using the collect function we can edit the table
				collect recode result fvpercent = column1  mean = column1 // Same column for factor and numeric variables
				collect layout (var) (result[column1 column2]) // Same column for factor and numeric variables 
				collect style row stack, nobinder spacer // Space bewteen groups of variables (numeric and factor)
				collect style cell border_block, border(right, pattern(nil)) // Space bewteen groups of variables (numeric and factor)
				collect preview 
				
				* Save the table
				collect export "$outs/Summary statistics.xlsx", as(xlsx) sheet(General) noisily replace
				
			* Migrant --------
			
			* General stadistics table
				table (var) [iw=fex_c18] if mig == 1, statistic(mean $emp) statistic(fvpercent $general_fac) statistic(mean $general) statistic(mean $pob) // In the weights the expansion factor is not divided as we only analysis one month
				
				* Using the collect function we can edit the table
				collect recode result fvpercent = column1  mean = column1 // Same column for factor and numeric variables
				collect layout (var) (result[column1 column2]) // Same column for factor and numeric variables 
				collect style row stack, nobinder spacer // Space bewteen groups of variables (numeric and factor)
				collect style cell border_block, border(right, pattern(nil)) // Space bewteen groups of variables (numeric and factor)
				collect preview 
				
				* Save the table
				collect export "$outs/Summary statistics.xlsx", as(xlsx) sheet(General) cell(C1) noisily modify // cell option allow us to place the table wherever we want in the excel. 
				
				* Main Results: 
					* More weekly hours worked in comparison to the general population.
					* Lower labor incomes
				
			* Disabled --------
			
			* General stadistics table
				table (var) [iw=fex_c18] if dis_person == 1, statistic(mean $emp) statistic(fvpercent $general_fac) statistic(mean $general) statistic(mean $pob) // In the weights the expansion factor is not divided as we only analysis one month
				
				* Using the collect function we can edit the table
				collect recode result fvpercent = column1  mean = column1 // Same column for factor and numeric variables
				collect layout (var) (result[column1 column2]) // Same column for factor and numeric variables 
				collect style row stack, nobinder spacer // Space bewteen groups of variables (numeric and factor)
				collect style cell border_block, border(right, pattern(nil)) // Space bewteen groups of variables (numeric and factor)
				collect preview 
				
				* Save the table
				collect export "$outs/Summary statistics.xlsx", as(xlsx) sheet(General) cell(E1) noisily modify // cell option allow us to place the table wherever we want in the excel. 
				
				* Main results
					* Less weekly hours worked in comparison to the general population.
					* Lower labor incomes
					* Most of the disabled persons work as Self-Employed
					* Low education levels
		
	
		* 1. Labor market differences for population groups	(difference-in-means tables)
			* The following tables aim to show differences bewteen specific groups of the population in labor market outcomes. 
			* This part of the code is an adaptation from the following STATA blog https://blog.stata.com/2021/08/24/customizable-tables-in-stata-17-part-4-table-of-statistical-tests/
			
		
			* Migration 
				
				* This local helps to copy a formula that would be use several times in the construction of the diff table
				local myresults "Native = r(mu_1) Migrant = r(mu_2) Diff = (r(mu_2)-r(mu_1))  pvalue =  r(p)"
				
				* This table is constructed based on a t-test. 
				table (command) (result), /// 
					command(`myresults' : ttest lab_force, by(mig)) ///
					command(`myresults' : ttest emp, by(mig)) ///   
					command(`myresults' : ttest informal, by(mig)) ///    
					command(`myresults' : ttest lab_income, by(mig)) /// 
					command(`myresults' : ttest h_hork, by(mig)) ///     
					nformat(%6.2f  Native Migrant Diff) ///         
					nformat(%6.0f  pvalue) 
				
				* Labels: the labels of variables are not correctly labeled, therefore, we have to change the names manually. To do this, we have to use the collect function to see the position of each variable in the table.
					collect label list command, all
					
					/*
					Collection: Table
					   Dimension: command
						   Label: Command option index
					Level labels:
							   1  ttest lab_force, by(mig)
							   2  ttest emp, by(mig)
							   3  ttest informal, by(mig)
							   4  ttest lab_income, by(mig)
							   5  ttest h_hork, by(mig)
					*/
					
					* After identifying each level, we can rename the table rows.
					collect label levels command 1  "Labor force participation" 2 "Employment rate" 3 "Informality rate" 4 "Labor income" 5 "Weekly hours worked", modify 
					
					* Changes in the format 
					collect style cell result[Native Migrant Diff], nformat(%8.2f) 
					collect style cell result[pvalue], nformat(%6.4f)
					collect style cell border_block, border(right, pattern(nil))

					collect preview
					
					* Save 
					collect export "$outs/Summary statistics.xlsx", as(xlsx) sheet(Mig diff) noisily modify

			* Disable persons
			* For this part of the code we just have to change the labels and variables used
				
				* This local helps to copy a formula that would be use several times in the construction of the diff table
				local myresults "Nondisabled = r(mu_1) Disabled = r(mu_2) Diff = (r(mu_2)-r(mu_1))  pvalue =  r(p)"
				
				* This table is constructed based on a t-test. 
				table (command) (result), /// 
					command(`myresults' : ttest lab_force, by(dis_person)) ///
					command(`myresults' : ttest emp, by(dis_person)) ///   
					command(`myresults' : ttest informal, by(dis_person)) ///    
					command(`myresults' : ttest lab_income, by(dis_person)) /// 
					command(`myresults' : ttest h_hork, by(dis_person)) ///     
					nformat(%6.2f  Nondisabled Disable Diff) ///         
					nformat(%6.0f  pvalue) 
				
				* Labels: the labels of variables are not correctly labeled, therefore, we have to change the names manually. To do this, we have to use the collect function to see the position of each variable in the table.
					collect label list command, all
					
					/*
					Collection: Table
					   Dimension: command
						   Label: Command option index
					Level labels:
							   1  ttest lab_force, by(mig)
							   2  ttest emp, by(mig)
							   3  ttest informal, by(mig)
							   4  ttest lab_income, by(mig)
							   5  ttest h_hork, by(mig)
					*/
					
					* After identifying each level, we can rename the table rows.
					collect label levels command 1  "Labor force participation" 2 "Employment rate" 3 "Informality rate" 4 "Labor income" 5 "Weekly hours worked", modify 
					
					* Changes in the format 
					collect style cell result[Nondisabled Diff], nformat(%8.2f) 
					collect style cell result[pvalue], nformat(%6.4f)
					collect style cell border_block, border(right, pattern(nil))

					collect preview
					
					* Save 
					collect export "$outs/Summary statistics.xlsx", as(xlsx) sheet(Disabled diff) noisily modify
					
			* Main results:
				* Both populations have significant differences from the general population.
				* Inclusion in the labor market is limited.
	
	* ------------
	* DESCRIPTIVE MAPS
	
		* 1. Geolocation of migrants and average labor maket outcomes
	
		* The map will show the spatial distribution of migrants by department level and the occupation rate 
		* We need the aggregate number of migrants by department, for this we run a collapse

		preserve
		collapse (sum) emp mig lab_force if mig == 1 [iw=fex_c18], by(dpto) // In the weights Fex is not divided as we only analysis one month
		
		* Generation of additional variables for the map 
			* Migration rate per department
				egen total_mig = sum(mig) // Around 2.600.000 migrants in Colombia in 2022 
				g mig_rate = (mig/total_mig)*100 // Migration rate
				format mig_rate %9.2f
				lab var mig_rate "% of migrants per department"
				
			* Employment rate per department
				g emp_rate = (emp/lab_force)*100
				format emp_rate %9.2f
				lab var emp_rate "Employment rate (%)"
				
			* Merge with shp data 
				merge 1:1 dpto using "$moddata/Shape/dta_dpto"
				drop _merge
				
		* Map using spmap package
		
			spmap mig_rate using "$moddata/Shape/coor_dpto.dta", id(id) fcolor(GnBu) ocolor(white ..)  osize(thin ..) legend(position(7)) title("Distribution of migrants and their employment rate", size(*0.65)) subtitle("(per department)", size(*0.63)) legtitle("Migrants (%)") label(xcoord(x_c) ycoord(y_c) label(emp_rate) length (40) size(1.7) color (black)) 
			
			* Export the graph 
			graph save "$outs/dist_migrants.gph", replace
			graph export "$outs/dist_migrants.png", as(png) replace 
			
		restore
		
		* 2. Geolocation of disabled persons and average labor maket outcomes
	
		* The map will show the spatial distribution of disabled persons by department level and the occupation rate 
		* We need the aggregate number of disabled persons by department, for this we run a collapse

		preserve
		collapse (mean) total_pop (sum) emp dis_person lab_force if dis_person == 1 [iw=fex_c18], by(dpto) // In the weights Fex is not divided as we only analysis one month
		
		* Generation of additional variables for the map 
			* Proportion of disabled persons per department
				g dis_prop = (dis_person/total_pop)*100000 // Disabled persons proportion
				format dis_prop %9.2f
				lab var dis_prop "Proportion of disabled persons (per 100.000)"
				
			* Employment rate per department
				g emp_rate = (emp/lab_force)*100
				format emp_rate %9.2f
				lab var emp_rate "Employment rate (%)"
				
			* Merge with shp data 
				merge 1:1 dpto using "$moddata/Shape/dta_dpto"
				drop _merge
				
		* Map using spmap package
		
			spmap dis_prop using "$moddata/Shape/coor_dpto.dta", id(id) fcolor(GnBu) ocolor(white ..)  osize(thin ..) legend(position(7)) title("Proportion of disabled persons and their employment rate", size(*0.65)) subtitle("(per department)", size(*0.63)) legtitle("Disabled persons (per 100.000)") label(xcoord(x_c) ycoord(y_c) label(emp_rate) length (40) size(1.7) color (black)) 
			
			* Export the graph 
			graph save "$outs/dist_dis.gph", replace
			graph export "$outs/dist_dis.png", as(png) replace
			
		restore
		
		* Combine both graphs 
			graph combine "$outs/dist_dis.gph" "$outs/dist_migrants.gph", note("Note: The numeric values presented in the graph correspond to the employment rate of disabled persons and migrants" "Source: DANE - GEIH", size(*0.6))
			graph export "$outs/Populations_map.png", as(png) replace
			graph close _all // To close the graph window
			
	* ------------
	* REGRESSION ANALYSIS
	
	* This section will perform a simple regression analysis. Please note that these regressions are not causal analyses. It's just to present my skills using STATA. 
	* We will analyze the relation of several variables to the labor income. 
	
	* 1. Estimation 
		* These regresions will estimate the following model: Labor Income ~ Migrant + Disabled + Controls
			
			* GLOBALS: 
			
				* Independent variables
				global ind mig dis_person
				
				* Main controls of the regression. We would construct different models, therefore, we would use multiple globals per model.	
				global model2  i.sex age i.edu i.maritial i.hh_head i.urban
				global model3  i.type_worker
				
			* Model 1: Simple OLS 
				reg ln_income $ind
				eststo model1
				
			* Model 2: Simple OLS + Social characteristics controls 
				reg ln_income $ind $model2
				eststo model2
				
			* Model 3: Simple OLS + Social characteristics controls + labor controls
				reg ln_income $ind $model2 $model3
				eststo model3
				
			est stats model1 model2 model3
			
			/*
			Akaike's information criterion and Bayesian information criterion
			Model 3 has a lower number of observations because not every respondet answer the type of worker (p7050) question
			-----------------------------------------------------------------------------
				   Model |          N   ll(null)  ll(model)      df        AIC        BIC
			-------------+---------------------------------------------------------------
				  model1 |     29,582   -39740.9  -39595.81       3   79197.62    79222.5
				  model2 |     29,582   -39740.9  -35119.78      12   70263.56    70363.1
				  model3 |        890  -1420.934  -1150.522      14   2329.044   2396.121
			-----------------------------------------------------------------------------
			mtitles("Model A" "Model B")
			*/

	* 2. Merge the results in one table 
	
		esttab model1 model2 model3 using "$outs/OLS_estimation.txt", indicate("Employment controls = 1.type_worker" "Social char. controls = 0.sex") title("OLS estimation - Labor income") mtitles("Model A" "Model B" "Model C") beta(3) t(3)  r2(3) scalars(F) label replace

* End
