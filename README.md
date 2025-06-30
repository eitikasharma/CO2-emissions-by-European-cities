# 🌍 CO₂ Emissions in European Cities – Exploratory Data Analysis

📌 Overview

This project performs an exploratory data analysis (EDA) of greenhouse gas emissions data across thousands of European cities. It is part of the MM916: Data Analytics in R coursework and focuses on understanding spatial and economic patterns in emissions using population, GDP, heating demands, and sectoral breakdowns.

The data is sourced from the Global Covenant of Mayors (GCoM) initiative and explores trends in emissions per capita, sector-wise contributions, and their relationships to economic and climatic variables.

🎯 Objective

Understand and visualize the range, distribution, and patterns in CO₂ emissions.

Explore potential relationships between emissions and predictors like GDP per capita and heating demand.

Identify which countries and sectors contribute most to emissions.

Generate hypotheses for future regression modeling.

🗃 Datasets

GCoM_emissions.csv

Contains city-level data on emissions, population, GDP, and other variables.

GCoM_emissions_by_sector.csv

Contains emissions data broken down by six economic sectors:

Residential buildings and facilities

Tertiary buildings and facilities

Transport

Waste

Industry

Local electricity production

Missing data was filtered out, and cleaned datasets were created (Cleaned_DFbE, DFbS, etc.).

🧪 Methodology & Key Steps

1. Data Cleaning and Country Analysis
   
Removed cities with missing values in key columns.

Aggregated city counts by country to identify over- or underrepresented nations.

⚠️ Noted anomalies like Italy having 4037 cities vs. Estonia only 5 — indicating imbalance.

2. Population Distribution
   
Created histograms to visualize city population distribution.

Identified:

Max: London, UK – 12,051,223

Min: Lobera de Onsella, Spain – 28

Median: 4,540

3. Emissions per Capita by Country
   
Used boxplots to compare countries.

Ranked countries by median emissions per capita:

Top 3: (highest)

Bottom 3: (lowest)

4. Sectoral Emissions
   
Bar plots used to display total emissions by sector.

🏠 Residential buildings emerged as the top-emitting sector.

5. Emissions by Sector & Country
   
Joined both datasets by city ID.

Created stacked bar plots to compare how different sectors contribute to emissions by country.

6. Heating Degree Days (HDD) vs Emissions
   
Scatter plot of HDD vs. emissions per capita.

Highlighted Scandinavian cities in color.

Assessed whether colder climates lead to higher emissions due to heating needs.

7. GDP vs Emissions
   
Removed outlier city: London, UK (highest GDP).

Scatter plot of GDP per capita vs emissions per capita.

Noted trend: richer countries often have higher emissions.

Transparent points and color schemes used for enhanced clarity.

8. Summary & Recommendations

Economic strength and energy demands are key drivers of emissions.

Residential buildings are the major sectoral contributor.

Heating demands and wealth show partial correlation to emissions.

Recommends inclusion of:

Energy policies

Urban density

Government incentives

Behavioral and lifestyle data

in future regression modeling.

🛠 Technologies

R and RStudio

Libraries: ggplot2, dplyr, tidyr, readr, scales
