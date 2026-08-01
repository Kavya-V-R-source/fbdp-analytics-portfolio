# ====================================
# FBDP Analytics Portfolio
# Script 03 - Exploratory Data Analysis
# Author: Kavya
# ====================================

library(tidyverse)

source("scripts/02_data_cleaning.R")

# ====================================
# 1. Dataset Overview
# ====================================

dataset_summary <- tibble(
  Rows = nrow(clean_final_data),
  Columns = ncol(clean_final_data),
  Indicators = n_distinct(clean_final_data$Indicator),
  Themes = n_distinct(clean_final_data$Theme),
  Districts = n_distinct(clean_final_data$District),
  Blocks = n_distinct(clean_final_data$Block)
)

glimpse(clean_final_data)

# ====================================
# 2. Dataset Composition
# ====================================

theme_summary <- count(clean_final_data, Theme, sort = TRUE)

district_summary <- count(clean_final_data, District, sort = TRUE)

block_summary <- count(clean_final_data, Block, sort = TRUE)

# ====================================
# 3. Data Quality Assessment
# ====================================

overall_missing <- clean_final_data |>
  summarise(
    Total_Records = n(),
    Missing_Values = sum(is.na(Value_Numeric)),
    Missing_Percentage = round(
      Missing_Values / Total_Records * 100,
      2
    )
  )

theme_missing <- clean_final_data |>
  group_by(Theme) |>
  summarise(
    Total_Records = n(),
    Missing_Values = sum(is.na(Value_Numeric)),
    Missing_Percentage = round(
      Missing_Values / Total_Records * 100,
      2
    ),
    .groups = "drop"
  ) |>
  arrange(desc(Missing_Percentage))

indicator_missing <- clean_final_data |>
  group_by(Indicator) |>
  summarise(
    Total_Records = n(),
    Missing_Values = sum(is.na(Value_Numeric)),
    Missing_Percentage = round(
      Missing_Values / Total_Records * 100,
      2
    ),
    .groups = "drop"
  ) |>
  arrange(desc(Missing_Percentage))

district_missing <- clean_final_data |>
  group_by(District) |>
  summarise(
    Total_Records = n(),
    Missing_Values = sum(is.na(Value_Numeric)),
    Missing_Percentage = round(
      Missing_Values / Total_Records * 100,
      2
    ),
    .groups = "drop"
  ) |>
  arrange(desc(Missing_Percentage))

block_missing <- clean_final_data |>
  group_by(Block) |>
  summarise(
    Total_Records = n(),
    Missing_Values = sum(is.na(Value_Numeric)),
    Missing_Percentage = round(
      Missing_Values / Total_Records * 100,
      2
    ),
    .groups = "drop"
  ) |>
  arrange(desc(Missing_Percentage))

# ====================================
# 4. Numeric Exploration
# ====================================

numeric_summary <- summary(clean_final_data$Value_Numeric)

extreme_values <- clean_final_data |>
  arrange(desc(Value_Numeric)) |>
  select(
    District,
    Block,
    Theme,
    Indicator,
    Value_Numeric
  ) |>
  slice_head(n = 10)

# ====================================
# 5. Analytical Notes
# ====================================

# Infrastructure showed the highest proportion of missing values.
#
# Most high-missing indicators were related to urban local bodies,
# suggesting that applicability should be verified before
# interpreting them as reporting gaps.
#
# Health & Nutrition showed the highest reporting completeness.
#
# Indicator values represent different units
# (percentages, counts, population, etc.).
# Therefore, overall averages across all indicators are not meaningful.