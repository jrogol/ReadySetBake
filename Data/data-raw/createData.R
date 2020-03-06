library(dplyr)
library(readr)
library(readxl)
library(tidyr)



# Donor Data --------------------------------------------------------------

donorData <- read_csv(here::here("Data/data-raw/data_science_for_fundraising_donor_data.csv"))

# Donor data consists of one row per ID.

#### Split the data into Biographic and Giving Information

donorData_bio <- donorData %>% 
  select(-contains("FY"))


donorData_giving <- donorData %>% 
  select(ID,contains("FY"))


# Create YYYYMMDD date field

YYYYMMDD <- function(date){
  # Use an early return if the Date is NA
  if (is.na(date)){
    return("00000000")
  }
  
  year <- lubridate::year(date)
  month <-  lubridate::month(date)
  day <-  lubridate::day(date)
  
  c(year,month, day) %>% 
    purrr::map(stringr::str_pad,2,pad = "0") %>% 
    paste0(collapse = "")
}

donorData_bio <- donorData_bio %>% 
  mutate(BIRTH_DATE = purrr::map_chr(BIRTH_DATE,YYYYMMDD))

#### 10% of the rows will have a year only

set.seed(20200323)

yearOnly <- donorData_bio %>% 
  select(ID,BIRTH_DATE) %>% 
  filter(BIRTH_DATE != "00000000") %>% 
  sample_frac(.1) %>% 
  rename(BIRTH_DT = BIRTH_DATE) %>% 
  mutate(BIRTH_DT = gsub("\\d{4}$","0000",BIRTH_DT))

donorData_bio <- donorData_bio %>% 
  left_join(yearOnly, by = "ID") %>% 
  mutate(BIRTH_DT = coalesce(BIRTH_DT,BIRTH_DATE)) %>% 
  select(-BIRTH_DATE)

#### Add School and clean up Degree level
donorData_bio <- donorData_bio %>% 
  mutate(SCHOOL = case_when(DEGREE_LEVEL == "UB" ~ "Arts and Sciences",
                                  DEGREE_LEVEL == "GM" ~ "Graduate Arts and Sciences",
                                  DEGREE_LEVEL == "GP" ~ "Business",
                                  DEGREE_LEVEL == "GD" ~ "Law",
                                  DEGREE_LEVEL == "GC" ~ "Medicine",
                                  DEGREE_LEVEL == "UC" ~ "Nursing",
                                  DEGREE_LEVEL == "UG" ~ "Data Science",
                                  ALUMNUS_IND == "Y" ~ "Engineering",
                                  TRUE ~ NA_character_),
         DEGREE_LEVEL = case_when(grepl("G",DEGREE_LEVEL) ~ "G",
                                  grepl("U",DEGREE_LEVEL) ~ "U",
                                  TRUE ~ DEGREE_LEVEL))

write_csv(donorData_bio,here::here("Data/donorBio.csv"))

#### Split Giving into Current and Past giving

currentVars <- c("ID","CurrFYGiving")

# Parse the number from all giving numbers, save for the current FY
donorData_giving <- donorData_giving %>% 
  mutate_if(is.character,parse_number)

# Data only contains non-zero values.

donorData_threeYear <- donorData_giving %>%
  tidyr::gather(year,giving,-ID) %>% 
  filter(giving > 0) %>% 
  mutate(year2 = case_when(grepl("Cur",year) ~ 0,
                        grepl("\\d",year) ~ parse_number(year) + 1,
                        TRUE ~ 1)) %>% 
  mutate(year = lubridate::year(Sys.Date()) - year) %>% 
  write_csv(here::here("Data/newYrGiving.csv"))


# Contact Reports ---------------------------------------------------------

contactReports <- read_csv(here::here("Data/data-raw/data_science_for_fundraising_contact_reports.csv")) %>% 
  janitor::clean_names("small_camel")

#### Add Faux Department Data and Report ID
depts <- c("Major Gifts","Planned Giving","Annual Giving","Library")
  
contactReports_clean <- contactReports %>% 
  distinct(staffName) %>% 
  (function(df){
    df %>% 
      bind_cols(dept = rep_len(depts,nrow(df)))
  }) %>% 
  inner_join(contactReports, by = "staffName") %>% 
  arrange(date) %>% 
  mutate(reportID = 100 + row_number())
  
contactReports_clean %>% 
  write_csv(here::here("Data/contactReports.csv"))

# Clean Lasala Data -------------------------------------------------------

donorData2 <- read_excel(here::here("Data/data-raw/lasala_das_2018.xlsx"),
           sheet = "Sample Data Set")

donorData2 %>% 
  janitor::clean_names() %>% 
  write_csv(here::here("Data/basicReport.csv"))
