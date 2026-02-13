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

set.seed(1234)

# 2. Simulate Data --------------------------------------------------------

N = 10

students <- tibble(
  names = randomNames::randomNames(N, which.names = "first"),
  age = sample(19:26, size = N, replace = T),
  grade = sample(c(1.0, 1.3, 1.7,
                   2.0, 2.3, 2.7,
                   3.0, 3.3, 3.7,
                   4.0, 5.0),
                 size = N, replace = T)
)


# 3. Save data in various types -------------------------------------------

write_csv(students, "data/raw/students.csv")
write_csv2(students, "data/raw/students_de.csv")

write_rds(students, "data/raw/students.rds")

write.table(students, "students_tab.txt",
            sep = "\t",      # Tabulator
            row.names = FALSE, # keine Zeilennummern
            quote = FALSE)
write.table(students, "students_tab.txt",
            sep = " ",      # Leerzeichen
            row.names = FALSE,
            quote = FALSE)

students %>% 
  rename(
    Names = names,
    "age in years" = age,
  ) %>%
  write_xlsx(., "students.xlsx")

write_dta(students, "students.dta")

