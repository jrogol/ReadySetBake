![img](https://github.com/jrogol/ReadySetBake/blob/master/Assets/Main.png)


This repository hosts the materials for the "Ready, Set, Bake: Recipies for Reproducible Reporting in R Markdown" presentation offered at CASE's [DRIVE/ conference](https://www.case.org/drive).

Reproducible data science is a lot like baking. Both are **repeatable** processes that yield **identical and/or expected** outputs. More importantly, these results are **shareable** with coworkers (or maybe your future self).
It takes time and effort to develop one's methods, from developing the initial process to getting ingredients in order (data wrangling is a kind of analytic _mise en place_, if you will), but will ultimately save time in the long run.

Inspired by "The Great British Bake Off," (GBBO) three increasingly difficult scenarios are presented in which R Markdown can be used to streamline reporting. Tips and tricks will help you acheive the coveted moniker of "Star ~~Baker~~ Analyst."

To download the materials, click the green "Clone or Download" button in the upper right of the repository, and selecting [Download ZIP](https://github.com/jrogol/ReadySetBake/archive/master.zip).

## Organization

Files are organized into following folders:

* [Assets](https://github.com/jrogol/ReadySetBake/tree/master/Assets): `.pdf` version of the [presentation](https://github.com/jrogol/ReadySetBake/blob/master/Assets/ReadySetBake.pdf) and other images.
* [Data](https://github.com/jrogol/ReadySetBake/tree/master/Data): Nine `csv` files used in throughout the presentation and workshop.
  - [data-raw](https://github.com/jrogol/ReadySetBake/tree/master/Data/data-raw): Raw files from which the data were created. For more, see below.
* [Markdown](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/): Three R Markdown documents, one for each "challenge," along with a CSS file used in "The Showstopper."
  - [The Signature](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/1-TheSignature.Rmd)
  - [The Technical](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/2-TheTechnical.Rmd)
  - [The Showstopper](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/3-TheShowstopper.Rmd)
* [R](https://github.com/jrogol/ReadySetBake/tree/master/R/): `.R` files containing R scripts shown during the presentation and workshop.
* [Reports](https://github.com/jrogol/ReadySetBake/tree/master/Reports/): The `pdf`, `html` and `md` files created from the R Markdown documents. See the sections for the individual challenges for more details.

## The Data

The files in the [`data/data-raw`](https://github.com/jrogol/ReadySetBake/tree/master/Data/data-raw) folder were obtained from the  [Kaggle Fundraising Data set](https://www.kaggle.com/michaelpawlus/fundraising-data), curated by [Michael Pawlus](https://github.com/michaelpawlus).

* `data_science_for_fundraising_contact_reports.csv` provides data from 196 anonymized contact reports. Originally included with the [Data Science for Fundraising](http://nandeshwar.info/ds4fundraising/) book by Asutosh Nandeshwar and Rodger Devine.
* `data_science_for_fundraising_donor_data.csv` contains data for 34,000 anonymized constituents. Originally included with the [Data Science for Fundraising](http://nandeshwar.info/ds4fundraising/).
* `lasala_das_2018.xlsx` was created by Michael Lasala for his presentation _"You Ain't Seen Nothing Yet": Intro to Data Analysis and Visualization in Excel_ at the 2018 Data Analytics Symposium.

To better reflect data seen in the wild, the files in the [`data` folder](https://github.com/jrogol/ReadySetBake/tree/master/Data/) were adapted from the above using the [`createData.R` script](https://github.com/jrogol/ReadySetBake/blob/master/Data/data-raw/createData.R).

The `data` folder also contains three `.csv` files.
`cx_geo.csv` and `cx_zip.csv` act as crosswalks between zip codes and various census geographies (CBSA, MSA, county, etc.), and are used to mimic SQL tables. For ease of use, these two files are joined together and saved as  `cx_geography.csv`.

## Challenge no. 1: The Signature

On the GBBO, The Signature challenge gives bakers an opportunity to showcase one's tried-and true recipes. Often, this task requires creating multiple identical products, like "8 Self-Saucing Puddings" ([Series 5, Episode 5](https://en.wikipedia.org/wiki/The_Great_British_Bake_Off_(series_5)#Episode_4:_Desserts)).

The presentation focuses on a [report summarizing contact reports](https://github.com/jrogol/DRIVE2020/tree/master/Reports/1-TheSignature.pdf) filed by Major Gifts officers in August. Instead of changing hard-coded queries and file paths to update the report for a new time period or unit, the [`.Rmd`](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/1-TheSignature.Rmd) used **parameters** to streamline mass production.

### Files
* [1-TheSignature.Rmd](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/1-TheSignature.Rmd)
* [1-TheSignature.pdf](https://github.com/jrogol/ReadySetBake/tree/master/Reports/1-TheSignature.pdf): A `pdf` report of the initial contact report summary, in this case August reports from Major Gift Officers.
* [1-TheSignature-AG_Sept.pdf](https://github.com/jrogol/ReadySetBake/tree/master/Reports/1-TheSignature-AG_Sept.pdf): Using parameters, the same `.Rmd` file is quickly amended to produce the same report, only for Planned Giving officers in September.

## Challenge no. 2: The Technical

Whereas contestants could perfect their Signature bakes, The Technical is a complete unknown. The judges challenge the bakers to create somewhat obscure dishes, like [Blancmange with Langues du Chat](https://en.wikipedia.org/wiki/The_Great_British_Bake_Off_(series_9)#Episode_4:_Desserts) or [Kouign Amann](https://en.wikipedia.org/wiki/The_Great_British_Bake_Off_(series_5)#Episode_7:_Pastry).
To further test one's baking acumen, the recipes given to contestants are intentionally vague. The list of ingredients could omit measurements, or simply request one "Bake" the dish, without listing a time nor temperature.

This challege is not unlike troubleshooting a poorly-documented project inherited from a colleague (or one's past self!), or starting a new analysis from scratch. Code doesn't always "speak for itself," which can confuse collaborators (or even one's future self) and incur technical debt.

Rmarkdown enables authors to include their code alongside normal text commentary in a self-contained file; an analysis plan in a document, if you will (see _Build a Career in Data Science_ by Jacqueline Nolis and Emily Robinson for more). Posting the rationale behind the choices made alongside the code as one works through roadblocks, wrangles the data, or decides on which model to use will make troubleshooting and debugging will be easier.

Using **simple, focused chunks of code** will further reduce technical debt (instead of combining the loading, reshaping, plotting, analysis in a single block of code!). Breaking the work into smaller monotonic chunks will further aid interpretablity. The same is true when writing functions. Instead of copying-and-pasting code repeatedly, develop a function that performs one aspect of the task.

### Files
* [2-TheTechnical.Rmd](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/2-TheTechnical.Rmd)
* [2-TheTechnical.html](https://github.com/jrogol/ReadySetBake/tree/master/Reports/2-TheTechnical.html): An `html` report of the analysis, complete with table of contents.
* [2-TheTechnical.md](https://github.com/jrogol/ReadySetBake/tree/master/Reports/2-TheTechnical.md): To view the report natively in github, a regular markdown (an intermediate step en route to the HTML page) is output alongside the `html`.

## Challenge no. 3: The Showstopper

The final challenge in the GBBO tent encourages bakers to pull out all the stops and create something truly specatacular.

[3-TheShowstopper.Rmd](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/3-TheShowstopper.Rmd) builds off of the previous examples, while going beyond the default settings.

Rmarkdown provides several other code engines beyond `R`. Here, data is pulled from a database using a `SQL` chunk, which is then manipulated in native `python` (using the `reticulate` package).

Additional stylistic changes are made using snippets of `jQuery` code in the body of the document (for the logo header); a custom `css` file manipulating the font faces, colors, and sizes; and a custom `ggPlot` theme for visualizations.

As an added bonus, a [short `R` script](https://github.com/jrogol/ReadySetBake/blob/master/R/parameterizedReports.R) iterates across 54 combinations of parameters to quickly generate 54 reports - something that would take far longer to do by hand.

### Files
* [3-TheShowstopper.Rmd](https://github.com/jrogol/ReadySetBake/tree/master/Markdown/3-TheShowstopper.Rmd)
* [report.css](https://github.com/jrogol/ReadySetBake/blob/master/Markdown/report.css): An external `css` file providing additional styling and formatting guidelines.
* [R/parameterizedReports.R](https://github.com/jrogol/ReadySetBake/blob/master/R/parameterizedReports.R): R script that iteratively generates reports for 9 different units in 6 different fiscal years.
* [Showstopper](https://github.com/jrogol/ReadySetBake/tree/master/Reports/Showstopper): The directory containing all 54 reports, in both `html` and regular markdown (`md`) format.

## Dependencies

The [`rmarkdown`](https://rmarkdown.rstudio.com/) package is an integral part of the presentationa and workshop, providing the ability to create dynamic reports with built-in code.
They also make use of many [`tidyverse`](https://www.tidyverse.org/) packages, particularly `dplyr`.

The [`here`](https://here.r-lib.org/) package can aid in heuristically locating files during an analysis.
Jenny Bryan's [_Ode to the here package_ ](https://github.com/jennybc/here_here) gives an excellent overview of how to use it.
Additionally, the [`keyring`](https://github.com/r-lib/keyring) package offers a way to utilize password protected resources without embedding the password in scripts.
Lastly, [`janitor`](http://sfirke.github.io/janitor/) provided functions for preprocessing the data, primarily when standardizing column names.

These packages can be installed using the following code:
```r
install.packages("rmarkdown")
install.packages("tidyverse")
install.packages("here")
install.packages("keyring")
install.packages("janitor")
```
Additional packages used include [`gt`](https://gt.rstudio.com/) and [`kableExtra`](https://github.com/haozhu233/kableExtra) for tables; [`reticulate`](https://rstudio.github.io/reticulate/) for interacting with python; and [`DBI`](https://db.rstudio.com/dbi) and [`RSQLite`](https://github.com/r-dbi/RSQLite) for database operations.
