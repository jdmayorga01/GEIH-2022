# Labor market analysis using administrative data in Colombia

**Juan Diego Mayorga Durán**

**Codesample for the RA possition at the World Bank**

December 19, 2022

## Project description

**The objective of this project is to analyze the labor market of specific vulnerable populations (migrants and disabled persons) using administrative data from the Colombian labor market survey *"La Gran Encuesta Integrada de Hogares"* (GEIH) in October 2022.** 

GEIH produces information at the national, urban-rural level and for the thirteen main cities and metropolitan areas. This is a self-weighting, multistage, stratified, unequal cluster, probability sampling survey [(more information on GEIH)](https://www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos). GEIH survey is divided into nine modules, including *sociodemographic characteristics, employment, unemployment, and migration, among others*. For this specific project, data only includes three modules (General characteristics, employment, and migration) since the size of the GEIH data set is very large. These modules provide rich information about employment status, wages, as well as education level, gender, and other sociodemographic data.

The purpose of studying the labor market of these specific populations is due to their vulnerability and the barriers they have to access formal and quality employment. In relation to the migrants, in the last few years, Colombia has hosted around 1.8 million migrants from Venezuela [(UNHCR, 2020)](https://www.unhcr.org/globaltrends#:~:text=During%202020%2C%20several%20crises,within%20and%20beyond%20countries'%20borders.). The magnitude of the migration influx has exerted a burden on the labor market and has created vulnerabilities in the migrant population (discrimination, xenophobia, etc.). On the other hand, disabled people in Colombia have different inclusion problems, specifically in terms of the labor market and education. Around 30% of the persons with a disability are permanently unable to work and if they work, they have lower chances of getting a job. Moreover, there is a significant educational gap between the population with and without a disability; an averge 10 p.p difference in all levels of education (primary, secondary and tertiary) [(INCI, 2022)](https://www.inci.gov.co/blog/la-discapacidad-en-colombia-segun-estadisticas-del-dane). 

 ## Code description 
 
 This code aims to process, clean, and analyze GEIH labor market information for vulnerable specific populations in October 2022. Specifically, this code is divided into two blocks, cleaning, and analysis. To run the code, please use the **master.do file**. If this is the **FIRST TIME running the code**, please change the path to where the **master.do** is saved and leave the preset settings (all locals equal to 1). STATA 17 is required as new functionalities of this version are used. The code should take around 5-6 minutes to run. 
 
### Folder organization
The main folders that are preset in the .zip would be *"Master data, code, and documentation"*. The other folder are generated in the master.do file. 

1. Master data: GEIH and shape data of Colombia.
2. Modified data: Intermediate results of the GEIH processing.
3. Clean data: Final data set used in the analysis (codesample_JDM.dta).
4. Code: This folder should include 5 .do elements (analysis, clean_main, clean_maps, merge and packages). The explanation of each .do can be found below.
5. Outputs: Main tables and graphs created for the analysis.
6. Documentation: GEIH documentation where the description of variables can be found.
 


### Description of the code 

1. **Cleaning:** This section runs the cleaning and processing process of GEIH, which implies merging and cleaning the data. Also, in this section, the main variables are generated and properly label to create a clean data set (codesample_JDM.dta). This process can be found in the **.do files merge, and clean_main**. There is an additional .do that is named **clean_maps** which contains the cleaning process of the shape data for some graph outputs that will be run in the analysis section.


3. **Analysis:** In this section, I present the main analysis of the project. This is done by analyzing three kind of outputs, which are the following: 

 - **Descriptive tables:** Analysis of the main characteristics (social and labor market) of the vulnerable population. This analyze has as a result two sets of outputs, general descriptive statistics and a difference-in-means tables (between the general population and the vulnerable groups), that are saved in the **.xlsx Summary statistics** file found in the Outputs folder.  
 
 
 
 - **Spatial graphs:** This subsection generated spatial maps of the location of vulnerable groups and their employment rate by department level. Specifically, I used spmap package and shp data information ([link])(https://sites.google.com/site/seriescol/shapes) at departamental level. The output of this analysis is a graph that presents the proportion/percentage of disabled/migrants and their employment rate by department. 
 - **Regression analysis:**
 

### 
