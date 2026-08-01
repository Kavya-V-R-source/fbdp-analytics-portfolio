# ====================================
# FBDP Analytics Portfolio
# Script 02 - Data Cleaning
# Author: Kavya
# ====================================

library(tidyverse)

source("scripts/01_import_data.R")

clean_final_data <- final_data |>
  mutate(
    Value = if_else(
      Value == "Pending",
      NA_character_,
      Value
    )
  )

count(clean_final_data, Value, sort = TRUE)


final_data |>
  count(Value) |>
  filter(grepl("nil", Value, ignore.case = TRUE))
final_data |>
  count(Value, sort = TRUE) |>
  print(n = 100)

final_data |>
  mutate(
    Numeric_Value = suppressWarnings(as.numeric(Value))
  ) |>
  filter(is.na(Numeric_Value) & !is.na(Value)) |>
  distinct(Value)



