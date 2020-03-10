![img](https://github.com/jrogol/DRIVE2020/blob/master/Assets/Main.png)


This repository hosts the materials for the "Ready, Set, Bake: Recipies for Reproducible Reporting in R Markdown" presentation offered at CASE's [DRIVE/ conference](https://www.case.org/drive).

Reproducible data science is a lot like baking. Both are **repeatable** processes that yield **identical and/or expected** outputs. More importantly, these results are **shareable** with coworkers (or maybe your future self).
It takes time and effort to develop one's methods, from developing the initial process to getting ingredients in order (data wrangling is a kind of analytic _mise en place_, if you will), but will ultimately save time in the long run.

Inspired by "The Great British Bake Off," (GBBO) three increasingly difficult scenarios are presented in which R Markdown can be used to streamline reporting. Tips and tricks will help you acheive the coveted moniker of "Star ~~Baker~~ Analyst."

To download the materials, click the green "Clone or Download" button in the upper right of the repository, and selecting [Download ZIP](https://github.com/jrogol/DRIVE2020/archive/master.zip). 

## Organization

Files are organized into following folders:

* [Assets](https://github.com/jrogol/DRIVE2020/tree/master/Assets): `.pdf` version of the [presentation](https://github.com/jrogol/DRIVE2020/blob/master/Assets/ReadySetBake.pdf) and other images.
* [Data](https://github.com/jrogol/DRIVE2020/tree/master/Data): Six `csv` files used in throughout the presentation
  - [data-raw](https://github.com/jrogol/DRIVE2020/tree/master/Data/data-raw): Raw files from which the data were created. For more, see below.
* [Markdown](https://github.com/jrogol/DRIVE2020/tree/master/Markdown/): Three R Markdown documents, one for each "challenge," along with a CSS file used in "The Showstopper."
  - [The Signature](https://github.com/jrogol/DRIVE2020/tree/master/Markdown/1-TheSignature.Rmd)
  - [The Technical](https://github.com/jrogol/DRIVE2020/tree/master/Markdown/2-TheTechnical.Rmd)
  - [The Showstopper](https://github.com/jrogol/DRIVE2020/tree/master/Markdown/3-TheShowstopper.Rmd)
* [R](https://github.com/jrogol/DRIVE2020/tree/master/R/): `.R` files containing R scripts shown during the presentation.
* [Reports](https://github.com/jrogol/DRIVE2020/tree/master/Reports/): The `pdf`, `html` and `md` files created from the R Markdown documents. See the sections for the individual challenges for more details. 

## The Data

The files in the [`data/data-raw`]() folder were obtained from the  [Kaggle Fundraising Data set](https://www.kaggle.com/michaelpawlus/fundraising-data), curated by [Michael Pawlus](https://github.com/michaelpawlus).

* `data_science_for_fundraising_contact_reports.csv` provides data from 196 anonymized contact reports. Originally included with the [Data Science for Fundraising](http://nandeshwar.info/ds4fundraising/) book by Asutosh Nandeshwar and Rodger Devine.
* `data_science_for_fundraising_donor_data.csv` contains data for 34,000 anonymized constituents. Originally included with the [Data Science for Fundraising](http://nandeshwar.info/ds4fundraising/).
* lasala_das_2018.xlsx` was created by Michael Lasala for his presentation _"You Ain't Seen Nothing Yet": Intro to Data Analysis and Visualization in Excel_ at the 2018 Data Analytics Symposium.

To better reflect data seen in the wild, the files in the [`data` folder](https://github.com/jrogol/DRIVE2020/tree/master/Data/) were adapted from the above using the [`createData.R` script](https://github.com/jrogol/DRIVE2020/blob/master/Data/data-raw/createData.R).

## Challenge no. 1: The Signature

On the GBBO, The Signature challenge gives bakers an opportunity to showcase one's tried-and true recipes. Often, this task requires creating multiple identical products, like "8 Self-Saucing Puddings" ([Series 5, Episode 5](https://en.wikipedia.org/wiki/The_Great_British_Bake_Off_(series_5)#Episode_4:_Desserts)).

The presentation focuses on a [report summarizing contact reports](https://github.com/jrogol/DRIVE2020/tree/master/Reports/1-TheSignature.pdf) filed by Major Gifts officers in August. Instead of changing hard-coded queries and file paths to update the report for a new time period or unit, the [`.Rmd`](https://github.com/jrogol/DRIVE2020/tree/master/Markdown/1-TheSignature.Rmd) used **parameters** to streamline mass production.

### Files
* [1-TheSignature.Rmd](https://github.com/jrogol/DRIVE2020/tree/master/Markdown/1-TheSignature.Rmd)
* [1-TheSignature.pdf](https://github.com/jrogol/DRIVE2020/tree/master/Reports/1-TheSignature.pdf): A `pdf` report of the initial contact report summary, in this case August reports from Major Gift Officers.
* [1-TheSignature-AG_Sept.pdf](https://github.com/jrogol/DRIVE2020/tree/master/Reports/1-TheSignature-AG_Sept.pdf): Using parameters, the same `.Rmd` file is quickly amended to produce the same report, only for Annual Giving officers in September.

## Challenge no. 2: The Technical

Blancmange(https://en.wikipedia.org/wiki/The_Great_British_Bake_Off_(series_9)#Episode_4:_Desserts)
Kouign Amann(https://en.wikipedia.org/wiki/The_Great_British_Bake_Off_(series_5)#Episode_7:_Pastry)

## Challenge no. 3: The Showstopper

## Dependencies

The workshop makes use of many [`tidyverse`](https://www.tidyverse.org/) packages, particularly `dplyr`.

The [`here`](https://here.r-lib.org/) package can aid in heuristically locating files during an analysis.
Jenny Bryan's [__Ode to the here package__ ](https://github.com/jennybc/here_here) gives an excellent overview of how to use it.
Additionally, the [`keyring`](https://github.com/r-lib/keyring) package offers a way to utilize password protected resources without embedding the password in scripts.
Lastly, [`janitor`](http://sfirke.github.io/janitor/) provided functions for preprocessing the data, primarily when standardizing column names.

These packages can be installed using the following code:
```r
install.packages("tidyverse")
install.packages("here")
install.packages("keyring")
install.packages("janitor")
```


library(dplyr)
library(readr)
library(ggplot2)
library(tidyr)
library(knitr)
library(here)
library(janitor)
library(kableExtra)
knitr, rmarkdown, gt.

forecats, reticulate, ROracle and DBI, odbc

RStudio
