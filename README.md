# Labor market analysis using administrative data in Colombia - Vulnerable Populations

**Juan Diego Mayorga Durán**

**Codesample - Labor market in Colombia**

- Date: December 19, 2022
- Last modified: December 28, 2022

***********

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

## Results

The results are divided into three main outputs: descriptive tables, graphs, and Spatial graphs, and Regression analysis that describe the labor market outcomes of vulnerable populations in Colombia. 


### Descriptive stadistics 

![image](https://user-images.githubusercontent.com/68482485/209865819-81f4b1fd-9099-4a54-8bf2-b37fda7f32f6.png)

**Main differences bewteen migrants and natives (t-test):**		

![image](https://user-images.githubusercontent.com/68482485/209866012-dd0eb9c6-a8f9-4f2a-8dfc-0ba9f5b6b8f4.png)

**Main differences bewteen disabled people and natives (t-test):**		

![image](https://user-images.githubusercontent.com/68482485/209866168-c6d4c089-4193-4e4d-86b1-85ba6bed82ba.png)


### Spatial graphs 
![Populations_map](https://user-images.githubusercontent.com/68482485/209867062-9e71bc1b-66c3-4204-bdad-2790f38789fc.png)


### Regression analysis

**OLS estimation - Labor income**

|                      |      Model A                  |      Model B                  |      Model C                  |
| -------------------- | :---------------------------: | :---------------------------: | :---------------------------: |
| Migrant              |       -0.050<sup>\*\*\*</sup> |       -0.028<sup>\*\*\*</sup> |       -0.012                  |
|                      |     (-8.690)                  |     (-5.605)                  |     (-0.475)                  |
| Disable person       |       -0.086<sup>\*\*\*</sup> |       -0.058<sup>\*\*\*</sup> |       -0.066<sup>\*</sup>     |
|                      |    (-14.845)                  |    (-11.566)                  |     (-2.567)                  |
| Male                 |                               |        0.178<sup>\*\*\*</sup> |        0.160<sup>\*\*\*</sup> |
|                      |                               |     (34.385)                  |      (6.146)                  |
| Age (years)          |                               |        0.021<sup>\*\*\*</sup> |        0.019                  |
|                      |                               |      (3.685)                  |      (0.641)                  |
| Primary              |                               |        0.000                  |        0.000                  |
|                      |                               |          (.)                  |          (.)                  |
| Secondary            |                               |        0.174<sup>\*\*\*</sup> |        0.167<sup>\*\*\*</sup> |
|                      |                               |     (23.302)                  |      (4.650)                  |
| Tertiary             |                               |        0.553<sup>\*\*\*</sup> |        0.572<sup>\*\*\*</sup> |
|                      |                               |     (72.767)                  |     (14.429)                  |
| No education         |                               |       -0.058<sup>\*\*\*</sup> |       -0.048                  |
|                      |                               |    (-11.018)                  |     (-1.758)                  |
| Single               |                               |        0.000                  |        0.000                  |
|                      |                               |          (.)                  |          (.)                  |
| Has a relationship   |                               |        0.069<sup>\*\*\*</sup> |        0.092<sup>\*\*\*</sup> |
|                      |                               |     (13.414)                  |      (3.588)                  |
| Other                |                               |        0.000                  |        0.000                  |
|                      |                               |          (.)                  |          (.)                  |
| Head                 |                               |        0.078<sup>\*\*\*</sup> |        0.108<sup>\*\*\*</sup> |
|                      |                               |     (14.835)                  |      (4.079)                  |
| Rural                |                               |        0.000                  |        0.000                  |
|                      |                               |          (.)                  |          (.)                  |
| Urban                |                               |        0.071<sup>\*\*\*</sup> |        0.145<sup>\*\*\*</sup> |
|                      |                               |     (13.432)                  |      (5.099)                  |
| Self-employed        |                               |                               |       -0.141<sup>\*\*\*</sup> |
|                      |                               |                               |     (-4.880)                  |
| Employer             |                               |                               |        0.111<sup>\*\*\*</sup> |
|                      |                               |                               |      (3.917)                  |
| Employment controls  |           No                  |           No                  |          Yes                  |
| Social char. controls  |           No                  |          Yes                  |          Yes                  |
| Observations         |        29582                  |        29582                  |          890                  |
| *R*<sup>2</sup>      |        0.010                  |        0.261                  |        0.454                  |
| F                    |        145.8                  |       1042.2                  |        60.73                  |

Standardized beta coefficients; *t* statistics in parentheses<br>
<sup>\*</sup> *p* < 0.05, <sup>\*\*</sup> *p* < 0.01, <sup>\*\*\*</sup> *p* < 0.001



***********
Data can be dowload from DANE webpage in the following [(link)](https://microdatos.dane.gov.co/index.php/catalog/771/get-microdata).
