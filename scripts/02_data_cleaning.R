# ====================================
# FBDP Analytics Portfolio
# Script 02 - Data Cleaning
# Author: Kavya
# ====================================

library(tidyverse)

# Import data from Script 01
source("scripts/01_import_data.R")

# Replace "Pending" with proper missing values
clean_final_data <- final_data |>
  mutate(
    Value_Clean = if_else(
      Value == "Pending",
      NA_character_,
      Value
    )
  )

# Create an analysis-ready numeric column
clean_final_data <- clean_final_data |>
  mutate(
    Value_Numeric = suppressWarnings(
      as.numeric(Value_Clean)
    )
  )

# Validate the cleaned data
glimpse(clean_final_data)

summary(clean_final_data$Value_Numeric)