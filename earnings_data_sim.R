# ============================================================================
# Project: R Intro
# Script: earnings_data_sim.R
# Author: Andreas Fischeneder
# Date: 2025-10-09
# Description: Creates earnings data set and save it in various data formats
# ============================================================================


# 1. Load Packages --------------------------------------------------------

library(tidyverse)
library(writexl)
library(haven)

set.seed(123)

# 2. Simulate Data --------------------------------------------------------

N = 10

earnings <- tibble(
  names = c("Anna", "Ben", "Clara", "Dimitri", "Emilia-Luise", "Fatima", "Gerda Maria", "Hannah", "Ismail", "Johanna"),
  age = sample(19:35, size = N, replace = T),
  nationality = c("DE", "DE", "International", "EU", "DE", "DE", "DE", "EU", "International", "DE"),
  income = sample(850:2600, size = N, replace = T)
)
earnings$age[2] <- NA
earnings$income[3] <- "2000€"


# 3. Save data in various types -------------------------------------------

file_path = "data/raw/earnings_data/earnings"

write_csv(earnings, paste0(file_path, ".csv"))
write_csv2(earnings, paste0(file_path, "_de.csv"))

write_rds(earnings, paste0(file_path, ".rds"))

write.table(earnings, paste0(file_path, "_tab.txt"),
            sep = "\t",      # Tabulator
            row.names = FALSE, # keine Zeilennummern
            quote = FALSE)
write.table(earnings, paste0(file_path, "_space.txt"),
            sep = " ",      # Leerzeichen
            row.names = FALSE,
            quote = FALSE)

earnings %>% 
  rename(
    Names = names,
    "age in years" = age,
  ) %>%
  write_xlsx(., paste0(file_path, ".xlsx"))

write_dta(earnings, paste0(file_path, ".dta"))

