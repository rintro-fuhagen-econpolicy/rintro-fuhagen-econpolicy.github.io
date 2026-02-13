# ============================================================================
# Project: R Intro
# Script: students_data_sim.R
# Author: Andreas Fischeneder
# Date: 2025-10-09
# Description: Creates students data set and save it in various data formats
# ============================================================================


# 1. Load Packages --------------------------------------------------------

library(tidyverse)
library(writexl)
library(haven)

set.seed(123)

# 2. Simulate Data --------------------------------------------------------

N = 10

students <- tibble(
  names = c("Anna", "Ben", "Clara", "Dimitri", "Emilia-Luise", "Fatima", "Gerda Maria", "Hannah", "Ismail", "Johanna"),
  age = sample(19:26, size = N, replace = T),
  grade = sample(c(1.0, 1.3, 1.7,
                   2.0, 2.3, 2.7,
                   3.0, 3.3, 3.7,
                   4.0, 5.0),
                 size = N, replace = T)
)


# 3. Save data in various types -------------------------------------------

file_path = "data/raw/students_data/students"

write_csv(students, paste0(file_path, ".csv"))
write_csv2(students, paste0(file_path, "_de.csv"))

write_rds(students, paste0(file_path, ".rds"))

write.table(students, paste0(file_path, "_tab.txt"),
            sep = "\t",      # Tabulator
            row.names = FALSE, # keine Zeilennummern
            quote = FALSE)
write.table(students, paste0(file_path, "_space.txt"),
            sep = " ",      # Leerzeichen
            row.names = FALSE,
            quote = FALSE)

students %>% 
  rename(
    Names = names,
    "age in years" = age,
  ) %>%
  write_xlsx(., paste0(file_path, ".xlsx"))

write_dta(students, paste0(file_path, ".dta"))

