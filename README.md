# Labor market analysis using administrative data in Colombia

**Juan Diego Mayorga Durán**

**Codesample for the RA possition at the World Bank**

December 19, 2022

## Description

**The objective of this project is to analyze the labor market of specific vulnerable populations (migrants and disabled persons) using administrative data from the Colombian labor market survey *"La Gran Encuesta Integrada de Hogares"* (GEIH) in October 2022.** 

GEIH produces information at the national, urban-rural level and for the thirteen main cities and metropolitan areas. This is a self-weighting, multistage, stratified, unequal cluster, probability sampling survey [(more information on GEIH)](https://www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral/empleo-y-desempleo/geih-historicos). GEIH survey is divided into nine modules, including *sociodemographic characteristics, employment, unemployment, and migration, among others*. For this specific project, data only includes three modules (General characteristics, employment, and migration) since the size of the GEIH data set is very large. These modules provide rich information about employment status, wages, as well as education level, gender, and other sociodemographic data.

The purpose of studying the labor market of these specific populations is due to their vulnerability and the barriers they have to access formal and quality employment. In relation to the migrants, in the last few years, Colombia has hosted around 1.8 million migrants from Venezuela [(UNHCR, 2020)](https://www.unhcr.org/globaltrends#:~:text=During%202020%2C%20several%20crises,within%20and%20beyond%20countries'%20borders.). The magnitude of the migration influx has exerted a burden on the labor market and has created vulnerabilities in the migrant population (discrimination, xenophobia, etc.). On the other hand, disabled people in Colombia have different inclusion problems, specifically in terms of the labor market and education. Around 30% of the persons with a disability are permanently unable to work and if they work, they have lower chances of getting a job. Moreover, there is a significant educational gap between the population with and without a disability; an averge 10 p.p difference in all levels of education (primary, secondary and tertiary) [(INCI, 2022)](https://www.inci.gov.co/blog/la-discapacidad-en-colombia-segun-estadisticas-del-dane). 

 ## Code description 
This code aims to process, clean, and analyze GEIH information for vulnerable specific populations in October 2022. Specifically, this code is divided into two blocks, cleaning, and analysis.

1. Cleaning: This section runs the cleaning and processing process of GEIH, which implies merging and cleaning the data. This process can be found in the **.do files merge, and clean_main**. There is an additional.do that is named **clean_maps** which contains the cleaning process of the shape data for some graph outputs that will be run in the analysis section.
 

### 
