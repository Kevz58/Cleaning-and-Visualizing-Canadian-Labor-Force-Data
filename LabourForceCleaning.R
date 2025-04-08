# ========================================================================
# Title: Data Cleaning and Export for Canadian Labour Force Data
# Author: Kevin
# Date: April 1, 2025
# Description: This script reads SPSS (.sav) files, cleans them, renames them, 
#              and exports them as CSVs for further analysis
# ========================================================================

# ==========================================================================
# 1. Load Libraries
# ==========================================================================

library(haven)
library(tidyverse)

# ==========================================================================
# 2. Read & Load Data
# ==========================================================================

# List SPSS files for Feburary 2019 - Feburary 2024
# You can change this to your own desired file path with the files  
FilesList <- list.files(path = "C:\\Users\\kevin\\OneDrive\\Desktop\\336 HAckathon\\FebSav", 
                        pattern = "*.sav", full.names = TRUE)
# Read in SAV Files into a list called ImportedFilesList
ImportedFilesList <- lapply(FilesList, read_sav)

# ==========================================================================
# 3. Clean & Process Data
# ==========================================================================

# Select only the relevant columns needed from Labour Force Survey
# Labour Force Status (LFSSTAT), province (PROV), age group (AGE_12),  
# sex (SEX), education level (EDUC), industry classification (NAICS_21),
# part-time work status (WHYPT), hourly earnings (HRLYEARN), 
# union membership (UNION), firm size (FIRMSIZE), 
# reason for leaving last job (WHYLEFTO), and school attendance (SCHOOLN).  
filtered_list <- lapply(ImportedFilesList, function(df) {
  df |> 
    select(LFSSTAT, PROV, AGE_12, SEX, EDUC, NAICS_21, WHYPT, HRLYEARN, 
           UNION, FIRMSIZE, WHYLEFTO, SCHOOLN, SURVYEAR) |> 
    filter(AGE_12 %in% c("1","2", "3", "4","5","6","7","8","9","10"))
})

# Change Names for Data in Each label

# Change factors for LFSStat
LabourForce_labels <- c(
  "1" = "Employed, at work",
  "2" = "Employed, Absent From Work",
  "3" = "Unemployed",
  "4" = "Not in Labour Force"
)

# Change factors for province names
province_labels <- c(
  "10" = "Newfoundland and Labrador",
  "11" = "Prince Edward Island",
  "12" = "Nova Scotia",
  "13" = "New Brunswick",
  "24" = "Quebec",
  "35" = "Ontario",
  "46" = "Manitoba",
  "47" = "Saskatchewan",
  "48" = "Alberta",
  "59" = "British Columbia"
)

# Change factors for sex
sex_labels <- c(
  "1" = "Male",
  "2" = "Female"
)

# Change Factors for Job Industry
industry_labels <- c(
  "1" = "Agriculture",
  "2" = "Forestry and logging and support activities for forestry",
  "3" = "Fishing, hunting and trapping",
  "4" = "Mining, quarrying, and oil and gas extraction",
  "5" = "Utilities",
  "6" = "Construction",
  "7" = "Manufacturing - durable goods",
  "8" = "Manufacturing - non-durable goods",
  "9" = "Wholesale trade",
  "10" = "Retail trade",
  "11" = "Transportation and warehousing",
  "12" = "Finance and insurance",
  "13" = "Real estate and rental and leasing",
  "14" = "Professional, scientific and technical services",
  "15" = "Business, building and other support services",
  "16" = "Educational services",
  "17" = "Health care and social assistance",
  "18" = "Information, culture and recreation",
  "19" = "Accommodation and food services",
  "20" = "Other services (except public administration)",
  "21" = "Public administration"
)

# Change factors for Education levels
education_labels <- c(
  "0" = "0 to 8 Years",
  "1" = "Some High School",
  "2" = "High School Graduate",
  "3" = "Some Post Secondary",
  "4" = "Post Secondary Certificate or Diploma",
  "5" = "Bachelor's degree",
  "6" = "Above bachelor's degree"
)

# Change factors for Union Status
union_labels <- c(
  "1" = "Union member",
  "2"	= "Not a member but covered by a union contract or collective agreement",
  "3"	= "Non-unionized"
)

# Change Factors for firm size
firm_label <- c(
  "1" =	"Less than 20 employees",
  "2" =	"20 to 99 employees",
  "3" =	"100 to 500 employees",
  "4" =	"More than 500 employees"
)

# Change Factors for leaving jobs
leaving_label <- c(
  "0" = "Job leavers, other reasons",
  "1" = "Job leavers, own illness or disability",
  "2"	= "Job leavers, personal or family responsibilities",
  "3" = "Job leavers, going to school",
  "4" = "Job losers, laid off",
  "5" =	"Job leavers, retired"
)

# Change factors for age groups
age_label <- c(
  "1" = "15 to 19 years",
  "2" = "20 to 24 years",
  "3" = "25 to 29 years",
  "4" = "30 to 34 years",
  "5" = "35 to 39 years",
  "6" = "40 to 44 years",
  "7" = "45 to 49 years",
  "8" = "50 to 54 years",
  "9" = "55 to 59 years",
  "10" = "60 to 64 years",
  "11" = "65 to 69 years",
  "12" = "70 and over"
)

# Change factor for school status
school_Status_label <- c(
  "1" = "Non-student",
  "2"	= "Full-time student",
  "3" =	"Part-time student"
)

# Create function to apply factor labels
apply_labels <- function(df) {
  df |>
    mutate(
      PROV = factor(PROV, levels = names(province_labels), labels = province_labels),
      LFSSTAT = factor(LFSSTAT, levels = names(LabourForce_labels), labels = LabourForce_labels),
      AGE_12 = factor(AGE_12, levels = names(age_label), labels = age_label),
      SEX = factor(SEX, levels = names(sex_labels), labels = sex_labels),
      UNION = factor(UNION, levels = names(union_labels), labels = union_labels),
      FIRMSIZE = factor(FIRMSIZE, levels = names(firm_label), labels = firm_label),
      WHYLEFTO = factor(WHYLEFTO, levels = names(leaving_label), labels = leaving_label),
      SCHOOLN = factor(SCHOOLN, levels = names(school_Status_label), labels = school_Status_label),
      EDUC = factor(EDUC, levels = names(education_labels), labels = education_labels),
      NAICS_21 = factor(NAICS_21, levels = names(industry_labels), labels = industry_labels)
    )
}

# Apply factor labels to filtered list
CleanedDataList <- lapply(filtered_list, apply_labels)

# Combine the six datasets into a single CombinedDataset
CombinedDatasetFeb2019toFeb2024 <- bind_rows(CleanedDataList)

# ==========================================================================
# 4. Export Processed Data
# ==========================================================================

# Set File Path
output_folder <- "C:/Users/kevin/OneDrive/Desktop/336 HAckathon/Cleaned" # Can be changed to own file path

# Export as CSV
write.csv(CombinedDatasetFeb2019toFeb2024, file = file.path(output_folder, "combined_data.csv"), row.names = FALSE)



