# Homicide-Econometric-Analysis
PGlobal Impact of Homicide Rates on Economic Indicators

## 📌 Overview

This repository contains the code, data, and documentation for my Master's thesis in Economics, titled: **"The Effect of Homicides on Economic Outcomes: A Global Panel Data Analysis."**

The primary objective of this research is to estimate the causal impact of homicide rates on key economic indicators, such as **GDP per capita growth, foreign direct investment (FDI), and trade openness** across a large sample of countries over time.

The analysis employs a comprehensive panel dataset covering more than 150 countries over 15 years (2010-2024). It uses a combination of static panel models (Fixed Effects, Random Effects) and dynamic panel models (Arellano-Bond GMM) to address endogeneity, unobserved heterogeneity, and persistence in economic variables.

This project demonstrates my ability to: manage large datasets, apply advanced econometric techniques, write clean and reproducible code in R, and interpret complex results for policy-relevant conclusions.
⚙️ Methodology

The core of this research lies in the application of **panel data econometrics** to identify the causal effect of violence on economic prosperity. The key methodological steps include:

1.  **Data Construction:** Merging data on homicide rates from the UNODC (United Nations Office on Drugs and Crime) with macroeconomic indicators from the World Bank and IMF.
2.  **Modeling Approach:**
    - **Static Models:** I start with pooled OLS, followed by Fixed Effects (FE) and Random Effects (RE) models to control for time-invariant country-specific characteristics.
    - **Dynamic Models:** To account for the dynamic nature of economic growth and potential endogeneity of the homicide rate, I employ the **Arellano-Bond GMM estimator**. This uses internal instruments to produce more reliable causal estimates.
3.  **Robustness Checks:** I conduct several robustness checks, including:
    - Using different measures of violence and economic activity.
    - Sub-sample analysis (by region and income level).
    - Instrumental Variable (IV) approaches to further address endogeneity.

## 🔍 Key Findings

The analysis provides robust evidence that:
- A one-unit increase in the homicide rate is associated with a statistically significant decrease in GDP per capita growth and FDI inflows.
- The negative impact is more pronounced in low-income countries and regions with historically high levels of violence.
- The dynamic models suggest that the effect of violence persists for several years, creating a "violence trap" for economic development.

## 🛠️ How to Reproduce This Analysis

1.  **Clone this repository:** `git clone https://github.com/your-username/Homicide-Economic-Analysis.git`
2.  **Install required R packages:** Open R and run `install.packages(c("tidyverse", "plm", "dynlm", "stargazer", "ggplot2"))`.
3.  **Run the scripts in order:** Navigate to the `code/` folder and execute the scripts from `01_data_cleaning.R` to `05_figures_tables.R`.

## 📜 Dependencies

- **R:** Version 4.0 or higher.
- **Key R Packages:** `tidyverse`, `plm`, `dynlm`, `stargazer`, `ggplot2`, `dplyr`, `tidyr`.
- **Data Sources:** UNODC, World Bank, IMF.
