# ====================================
# FBDP Analytics Portfolio
# Script 01 - Import Data
# Author: Kavya
# ====================================

library(readxl)
library(tidyverse)
library(janitor)

# List all sheets in the workbook
excel_sheets("data/raw/Analysis for March 2026 data -trial.xlsx")

# Read the March 2026 sheet
march_data <- read_excel(
  "data/raw/Analysis for March 2026 data -trial.xlsx",
  sheet = "March 2026 data"
)

View(march_data)
glimpse(march_data)
names(march_data)
dim(march_data)
head(march_data)

# Read raw sheet WITHOUT assuming headers
raw_data <- read_excel(
  "data/raw/Analysis for March 2026 data -trial.xlsx",
  sheet = "March 2026 data",
  col_names = FALSE
)

district_names <- raw_data[1,]
View(district_names)
block_names <- raw_data[2, ]
View(block_names)
header_row <- raw_data[4, ]
View(header_row)

clean_data <- raw_data[-c(1:4), ]
head(clean_data)
names(clean_data)[1:7] <- c(
  "SNO",
  "KDI",
  "Tile_ID",
  "Indicator",
  "Theme",
  "Direction",
  "Periodicity"
)

names(clean_data)
unlist(block_names)
length(unlist(block_names))
block_vector <- unlist(block_names)
length(block_vector)
block_vector <- unlist(block_names[8:57])
names(clean_data)[8:57] <- block_vector
names(clean_data)
View(clean_data)


clean_data |>
  pivot_longer(
    cols = 8:57,
    names_to = "Block",
    values_to = "Value"
  )

long_data <- clean_data |>
  pivot_longer(
    cols = 8:57,
    names_to = "Block",
    values_to = "Value"
  )

glimpse(long_data)

district_vector <- unlist(district_names[8:57])

length(district_vector)

head(district_vector) 
head(block_vector)     

lookup_table <- tibble(
  District = district_vector,
  Block = block_vector
)     

View(lookup_table)

glimpse(lookup_table)

head(lookup_table)     
     
     
final_data <- long_data |>
  left_join(
    lookup_table,
    by = "Block"
  )    


final_data <- final_data |>
  select(
    District,
    Block,
    everything()
  )



count(
  final_data,
Value,
sort = TRUE
)
  
final_data |>
  filter(Value == "Pending") |>
  count(Indicator, sort = TRUE)

final_data |>
  filter(Value == "NIL") |>
  count(Indicator, sort = TRUE)
final_data |>
  filter(is.na(Value))

final_data |>
  filter(Value == "NA")

final_data |>
  filter(is.na(suppressWarnings(as.numeric(Value)))) |>
  count(Value, sort = TRUE)

