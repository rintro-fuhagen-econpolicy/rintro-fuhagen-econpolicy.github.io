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
library(labelled)

set.seed(123)

# 2. Simulate Data --------------------------------------------------------

N = 10

earnings <- tibble(
  names = c("Anna Maria", "Ben", "Clara", "Dimitri", "Emilia-Luise", "Fatima", "Gerda", "Hannah", "Ismail", "Johanna"),
  age = sample(19:35, size = N, replace = T),
  nationality = c("DE", "DE", "International", "EU", "DE", "DE", "DE", "EU", "International", "DE"),
  income = sample(850:2600, size = N, replace = T)
)
earnings$age[2] <- NA
earnings$nationality[2] <- "N/A"
earnings$income[3] <- "2000€"
names(earnings) <- c("Names", "age.in.years", "Nationalität", "inc in Eur")


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

write_xlsx(earnings, paste0(file_path, ".xlsx"))

earnings |>
  rename("names" = "Names",
         "age" = "age.in.years",
         "nationality" = "Nationalität",
         "income" = "inc in Eur") |>
  mutate(income = as.numeric(ifelse(income == "2000€", "2000", income)),
         nationality = case_when(nationality == "DE" ~ 1,
                                 nationality == "EU" ~ 2,
                                 nationality == "International" ~ 3)) |>
  set_variable_labels(names = "Vorname",
                      age = "Alter in Jahren",
                      nationality = "Staatsangehörigkeit",
                      income = "Einkommen in €") |>
  set_value_labels(nationality = c(DE = 1, EU = 2, International = 3)) |>
  write_dta(paste0(file_path, ".dta"))

