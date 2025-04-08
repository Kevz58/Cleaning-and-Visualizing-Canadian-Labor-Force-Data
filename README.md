# Cleaning-and-Visualizing-Canadian-Labuor-Force-Data

The goal of this project was to explore trends and changes in the Canadian labour force during the COVID-19 pandemic period (2019–2024). Using publicly available labour force survey data, the analysis focused on identifying shifts in employment patterns and wage dynamics. A key area of interest was how education level influenced hourly wages over time across various industries and provinces, particularly as the economy adjusted to the pandemic.

Due to file size or licensing restrictions, the original dataset used in this project is not included in the repository. However, you can access similar data from [Statistics Canada’s Labour Force Survey (LFS) – Public Use Microdata Files](https://www23.statcan.gc.ca/imdb/p2SV.pl?Function=getInstanceList&Id=1567657). Simply download the files for the years you're interested in (e.g., 2019–2024), save them in the same folder as the R script, and update the file path in the script accordingly to load your data.

The analysis used Canadian February Labour Force Survey data from 2019 to 2024, accessed through UBC Abacus. Data was cleaned and analyzed using R, while interactive visualizations were created in Tableau Public to clearly illustrate trends and insights.

You can view the Tableau dashboard for this project here: https://public.tableau.com/app/profile/kevin.zhou8523/viz/CanadianLabourForceSurveyforFebruary2019-2024/Dashboard1

Before running the code in this repository, ensure that you have the following software installed:

- **R** 
- **RStudio**

Additionally, install the required R packages by running the following code in RStudio's Console:

```r
install.packages(c("haven", "tidyverse"))
