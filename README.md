# Labor market analysis using administrative data in Colombia - Vulnerable Populations

**Juan Diego Mayorga Durán**

**Codesample - Labor market in Colombia**

December 19, 2022

## Project description

**The objective of this project is to analyze the labor market of specific vulnerable populations (migrants and disabled persons) using administrative data from the Colombian labor market survey *"La Gran Encuesta Integrada de Hogares"* (GEIH) in October 2022.** 

GEIH produces information at the national, urban-rural level and for the thirteen main cities and metropolitan areas. This is a self-weighting, multistage, stratified, unequal cluster, probability sampling survey [(more information on GEIH)](https://www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos). GEIH survey is divided into nine modules, including *sociodemographic characteristics, employment, unemployment, and migration, among others*. For this specific project, data only includes three modules (General characteristics, employment, and migration) since the size of the GEIH data set is very large. These modules provide rich information about employment status, wages, as well as education level, gender, and other sociodemographic data.

The purpose of studying the labor market of these specific populations is due to their vulnerability and the barriers they have to access formal and quality employment. In relation to the migrants, in the last few years, Colombia has hosted around 1.8 million migrants from Venezuela [(UNHCR, 2020)](https://www.unhcr.org/globaltrends#:~:text=During%202020%2C%20several%20crises,within%20and%20beyond%20countries'%20borders.). The magnitude of the migration influx has exerted a burden on the labor market and has created vulnerabilities in the migrant population (discrimination, xenophobia, etc.). On the other hand, disabled people in Colombia have different inclusion problems, specifically in terms of the labor market and education. Around 30% of the persons with a disability are permanently unable to work and if they work, they have lower chances of getting a job. Moreover, there is a significant educational gap between the population with and without a disabilities; an averge 10 p.p difference in all levels of education (primary, secondary and tertiary) [(INCI, 2022)](https://www.inci.gov.co/blog/la-discapacidad-en-colombia-segun-estadisticas-del-dane). 

 ## Code description 
 
This code aims to process, clean, and analyze GEIH labor market information for vulnerable specific populations in October 2022. Specifically, this code is divided into two blocks, cleaning, and analysis. To run the code, please use the **master.do file**. If this is the **FIRST TIME running the code**, please change the path to where the **master.do** is saved, change the user global, and leave the preset settings (all locals equal to 1). STATA 17 is required as new functionalities of this version are used. The code should take around 5-6 minutes to run. 

### Description of the code 

1. **Cleaning:** This section runs the cleaning and processing of GEIH, which implies merging and cleaning the data. Also, in this section, the main variables are generated and properly label to create a clean data set (codesample_JDM.dta). This process can be found in the **.do files merge, and clean_main**. There is an additional .do that is named **clean_maps** which contains the cleaning process of the shape data for some graph outputs that will be run in the analysis section.


3. **Analysis:** In this section, I present the main results of the project. This is done by analyzing three kind of outputs, which are the following: 

 - **Descriptive tables:** Analysis of the main characteristics (social and labor market) of the vulnerable population. This analyze has as a result two sets of outputs, general descriptive statistics and a difference-in-means tables (between the general population and the vulnerable groups), that are saved in the **.xlsx Summary statistics** file found in the Outputs folder.  
 
 - **Spatial graphs:** This subsection generated spatial maps of the location of vulnerable groups and their employment rate by department level. Specifically, I used spmap package and shp data information [(link)](https://sites.google.com/site/seriescol/shapes) at departamental level. The output of this analysis is a graph that presents the proportion/percentage of disabled/migrants and their employment rate by department. The **.png Populations_map** output can be found in the Outputs folder.
 
 - **Regression analysis:** This section runs a simple OLS regression analysis. Please note that these regressions are not meant to be causal analyses. Concretely, I run the following regression: 

$income(ln)_{di} =  \alpha+\beta_1 disable + \beta_1 migrant + X + \epsilon$

Where $\beta_1$ and $\beta_2$ are dummies that identify migrants and disable persons and $X$ is a set of Social characteristics and labor market controls.

The result table **.txt OLS estimation** includes three separate models that are differentiated by the controls each model considers.

***********
Data can be dowload from DANE webpage.
