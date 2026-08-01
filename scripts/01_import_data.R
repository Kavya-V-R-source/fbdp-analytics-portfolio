# ====================================
# FBDP Analytics Portfolio
# Script 01 - Import Data
# Author: Kavya
# ====================================

library(readxl)
library(tidyverse)
library(janitor)

# Read raw Excel sheet without headers
raw_data <- read_excel(
  "data/raw/Analysis for March 2026 data -trial.xlsx",
  sheet = "March 2026 data",
  col_names = FALSE
)

# Extract district and block names
district_names <- raw_data[1, ]
block_names <- raw_data[2, ]

# Remove metadata rows
clean_data <- raw_data[-c(1:4), ]

# Rename metadata columns
names(clean_data)[1:7] <- c(
  "SNO",
  "KDI",
  "Tile_ID",
  "Indicator",
  "Theme",
  "Direction",
  "Periodicity"
)

# Assign block names as column names
block_vector <- unlist(block_names[8:57])
names(clean_data)[8:57] <- block_vector

# Convert from wide format to long format
long_data <- clean_data |>
  pivot_longer(
    cols = 8:57,
    names_to = "Block",
    values_to = "Value"
  )

# Create district-block lookup table
district_vector <- unlist(district_names[8:57])

lookup_table <- tibble(
  District = district_vector,
  Block = block_vector
)

# Add district names to the long dataset
final_data <- long_data |>
  left_join(
    lookup_table,
    by = "Block"
  ) |>
  select(
    District,
    Block,
    everything()
  )
