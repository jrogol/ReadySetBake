library(dplyr)

schools <- readr::read_csv(here::here("Data/donorBio.csv")) %>% 
  # Only Alumni have a SCHOOL, replace missing values
  distinct(SCHOOL = tidyr::replace_na(SCHOOL,"Non-Alumni")) %>% 
  pull()

years <- 2015:2020


grid <- expand.grid(schools, years)

start <- Sys.time()
purrr::pwalk(grid,
             ~rmarkdown::render(here::here("Markdown/3-TheShowstopper.Rmd"),
             output_file = paste0(stringr::str_remove_all(..1,"[:space:]|[:punct:]"),
                                  "FY",..2,".html"),
             output_dir = here::here("Reports/Showstopper"),
             params = list(school = ..1,
                           year = ..2,
                           geoType = "MSA")))
end <- Sys.time()

end-start

# 54 reports in 6:30!