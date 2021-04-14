library(dplyr)
library(tidyverse)
library(here)

con <- advancementtools::cx_Oracle(usr = "BI",
                                   pw = key_get("advance","BI","adv"))


q <- "SELECT  FIP5
            ,title
            ,geography
    FROM    cx_geo
    UNPIVOT (title for geography in (
                                    county as 'County'
                                    ,cbsa_title     as 'CBSA'
                                    ,csa_title as 'CSA'
                                    ,msa_title as 'MSA'
                                    )
            )"

cx_geo <- advancementtools::query_Oracle(con,q)

cx_zip <- advancementtools::query_Oracle(con,"SELECT zip, fip5 from cx_zip")

bio <- read_csv(here("Data/donorBio.csv"))

cx_zip %>% 
  inner_join(distinct(bio,ZIP=ZIPCODE)) %>% 
  write_csv(here("Data/cx_zip.csv"))

cx_geo %>% 
  write_csv(here("Data/cx_geo.csv"))

advancementtools::dx_Oracle(con)
