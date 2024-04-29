# INSPIRE-Mental-Health-Project_Landscape_Analysis
Landscape Analysis for Obtaining Secondary Data

## Summary

The **"INSPIRE: Building a Data Science Platform for Integration and Harmonization of Longitudinal Data on Mental Health in Africa"** project is designed to improve mental health outcomes for depression, anxiety and psychosis in African settings. To do this, the project aims to provide primary and secondary mental health datasets from African researches to help ensure data-driven decision making on mental health conditions. 

This is a scoping analysis of longitudinal mental health research in African settings to investigate availability, accessibility, and quality of secondary mental health data across different African populations.

Literature search for articles published in English from 1970 to 2022 was obtained from a comprehensive mapping list of African scientific publications from the [**International Digital Health and AI Research Collaborative (I-DAIRS) global research map (GRM) of mental health and well-being**](https://mentalhealth.i-dair.org/#/home). The map is based on a new methodology, which combines a technological approach based on AI (Natural Language Processing) to comb through free available databases of patents and publications to provide a landscape of Research and Development (R&D) activities across different world regions.

Although this is primarily a scoping review, some exploratory quantitative analyses was performed within article by calculating proportions of articles according to country, Africa regions, depression, anxiety, psychosis, response rates and access rates.

## Setup

We are assuming you have `R Software` and `Rstudio IDE` installed. If not you can download and install [**R software**](https://www.r-project.org/) then followed by [**RStudio/Posit IDE**](https://posit.co/download/rstudio-desktop/).

## Data

The data used for analysis and/or generated are available on reasonable request from the [**Study PI - Agnes Kiragga**](mailto:akiragga@aphrc.org?subject=[GitHub]%20Source%20Han%20Sans) and [**Study Program Coordinator - Bylhah Mugotitsa**](mailto:bmugotitsa@aphrc.org?subject=[GitHub]%20Source%20Han%20Sans).

- **Data used for analysis:** `African_authors_detailed_list (2) (1).xlsx`
- **Meta Data Generated:** `Longitudinal Meta data.xlsx` and `Track_list of data request letters.xlsx`. 

## Run

After cloning the repository or downloading the ZIP, you also need the data files (**Data used for analysis** and **Meta Data Generated**) in the _INSPIRE-Mental-Health-Project_Landscape_Analysis_ folder.

Open `Rstudio` then set your working directory to the _INSPIRE-Mental-Health-Project_Landscape_Analysis_ folder. 

- Copy the below code to run all files at once in Rstudio

```
source("main.R")

```
- To run individual files, open the `main.R` script, and run from the beginning.

