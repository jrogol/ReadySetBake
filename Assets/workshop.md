![img](https://github.com/jrogol/ReadySetBake/blob/master/Assets/Main.png)
# DRIVE/Cast Interactive Workshop
### 21 April 2021

## Prerequisites

* Install R and RStudio
* Download and unzip [materials](https://github.com/jrogol/ReadySetBake/archive/master.zip)
  - Also available on [Box.com](https://virginia.box.com/s/ul43etnjxyu9vumh5mzw2x5vhy11sgth) for a limited time.
* Install packages

  ```r
  install.packages("rmarkdown")
  install.packages("tidyverse")
  install.packages("here")
  install.packages("keyring")
  install.packages("janitor")
  install.packages("gt")
  install.packages("kableExtra")
  install.packages("DBI")
  install.packages("RSQLite")
  ```

## The Basics

* Create a new RStudio project
  - File > New Project...
    - Choose Existing Directory, using the folder that contains the unzipped materials.
  - Benefits
    - Acts as an "anchor" of sorts for the `here` package. See [here](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/) for more.
    - No extraneous variables lying around from prior projects!
    - Self-contained history of code that's run, as well.
  - Create Structure function
    - Open `R/createStructure.R`
      - What does it do?
      - Source the File to load the function.
      - Navigate to the root folder in the Files pane
      - Create the Structure using `createStructure()`
      - Notice the new folders created!
* Create a new R Markdown File (_not_ plain Markdown)
  - File > New File > R Markdown... (Or via the GUI)
    - Document (Not Presentation, Shiny, or Template)
      - Select HTML today.
      - Change the title and author as you see fit.
  - Save this as `markdown.Rmd` in the "Markdown Folder"
  - YAML header at the top of the page.
    - Note the output format
    - Add parameters by adding `params:` on the line below `output: html_document`
      - Add a line after `params:` - it will be indented,
      - Add `x: 7`, `y: 5`, `unit: "Central"` (quotes are a best practice, though not needed for a single word), each on their own line.
      - Add `### Parameters Test` as a new section
  - Code chunks
    - Chunk Settings
      - Universal via `knitr::opts_chunk()` in the `settings` chunk at the top of the document
        - Will _not_ work in other chunks.
        - Can also be set via the GUI, clicking on the gear symbol in the upper right of the `setup` chunk
      - Local Options`
        - See `include=FALSE` in the `setup` chunk or `echo=FALSE` in the `pressure` chunk
        - Clicking the gear icon in the GUI for a sparticular chunk will also show the options.
    - Insertion (command/control + shift + i, or GUI)
      - Create a chunk named `paramsTest`
          ```r
          params$x
          params$y

          roundTo <- 2
          ```
      - Set to `echo = FALSE` to _not_ print the code.
    - Execution of chunks.
      - One Line: cmd/ctrl + Enter
      - Entire Chunk: cmd/ctrl + Shift + Enter (or Play icon in the right corner of a chunk)
      - All prior chunks: Rotated Next button, again in the upper right corner of a given chunk.
  - Inline Code is denoted by ``r <code>`` in free text.
    - Add the following text:
      - `r params$x` divided by `r params$y` is `r round(params$x/params$y,roundTo)`
      - My current unit is set to `r params$unit`
  - Quickly Render: Knit!
      - cmd/ctrl + shift + k, or by the "Knit" button in the GUI menu bar.
      - Output document saves in same directory, and opens in a new window
      - knit with parameters (GUI only): Brings up Pop-up.
        - Change Y to 8, unit to "Arts & Sciences"
        - Note these overwrite the defaults!
  - Text formatting
    - Bold `**Knit**`, or ``echo = FALSE`` as code.
    - RStudio 4.1 - visual editor
      - Gear at top.
      - or: cmd/ctrl + shift + F4
    - Link to [Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf)
  - `here` demo
    - Borrowed from the package ["Getting Started" vignette](https://here.r-lib.org/articles/here.html)
    - New section `## Here Demo`
    - New chunk `hereDemo, warning = FALSE`
        ```r
        message("Original Working Directory")
        getwd()

        setwd("C:/Users/jr2ef/Desktop/ReadySetBakeWorkshop/Data")

        message("New Working Directory")
        getwd()

        message("`here`")
        here::here()

        message("Why?")
        here::dr_here()

        message("Relative Paths!")
        here::here("Markdown")
        ```
    - Run the _whole chunk_ - RMarkdown resets the working directory automagically!
    - Create `### How to Build a Model` (in a subsection of "Including Plots")
      - Load Data with a new chunk (`include=F`)
          ```r loadData
          donors <- readr::read_csv(here::here("Data/donorBio.csv"))

          # One-Hot Encode the ALUMNUS_IND to 1 if an alum, 0 otherwise.
          donors <-  dplyr::mutate(data, alum = dplyr::if_else(ALUMNUS_IND == "Y", 1, 0))
          ```
      - "Here's how to construct a basic linear model using the `donorBio` data.`"
          ```r model
          lm(alum+CON_YEARS~TotalGiving, data = donors)
          ```
        - Set options to `eval=FALSE` to _show_, but _not execute_ the code.
  - randomization
    - Create a New Section!
      - `## Randomization`
    - sample digits. Run _in place_.
      - Knit. Different results!
    - Add `set.seed()` with an arbitrary number
      - re-run in place
        - duplicate the chunk and run in place.
        - knit again.

        ```{r random}
        sample(1:10,2,T)
        ```
        Run This Chunk, then run it again. The results are the same!

        ```{r randomSeed}
        set.seed(2021)
        sample(1:10,2,T)
        sample(1:10,2,T)
        ```
        This is also true for _subsequent_ chunks.

        ```{r resample}
        sample(1:10,2,T)
        ```

## Dependencies

- Open `Markdown/Workshop-TheShowstopper.Rmd`
  - Navivage to the `packageList` chunk via RStudio GUI (in the lower left corner)
  - `results='asis'` treats results as markdown, as opposed to a vector or other R object
  - For simplicity, this is wrapped in a function and packaged, along with `createStructure` in an in-house R Package, `advancementtools` (which also includes connections to our database, obscuring IP addresses and other connection data from each document)

## The Showstopper

- `R/parameterizedReports` breakdown
  - `purrr::pwalk` iterates over each item in the list
    - i.e. the first entry of `schools` and the first entry of `years`, the second, etc.
    - `pwalk()` accepts multiple inputs, and can avoid nasty nested `for` loops.
  - `walk()` functions are used for side effects, like generating a report or plots
  - `map()` functions are different in that it returns the object created, as well (i.e. a `ggplot` object)
-Tweaked version
  - `html_document` options
    - `self_contained`: removes external dependencies (scripts, images, etc)
    - `keep_md`: Generates a "traditional" Markdown document, as opposed to R.
      - Useful for posting to github, for example
    - `toc`: Adds a table of contents
    - `toc_float`: Table of Contents remains in place as you scroll.
    - See Yihui's [Definitive Guide](https://bookdown.org/yihui/rmarkdown/html-document.html) for more.
- SQL demo
  - `keyring` is a password manager for R, and avoids storing passwords in free text.
  - SQL Lite is built-into R, but other drivers are available.
    - See [here](https://jnolis.com/blog/sql_database_rstudio/) for more.
    - the `SQLprep` and `SQLprep2` chunks load two geographic crosswalks into a temporary database
  - Using R Variables (`sqlPlayground` chunk)
    - `glue::glue_sql()` (from the `glue` package in the tidyverse) can insert and format R variables for SQL
      - Single objects are easy, putting curly braces around the name of the R object in the SQL command
      - Vectors are trickier
        - Change to `zip <- c(22904, 01701)` (line 272)
        - unpack vectors via `glue::glue_sql("{vectorName*}", .con = con)` (note the asterisk!)
  - SQL Chunks
    - Reference r variables as `?variable` (must unpack beforehand, if a vector!)
    - Omitting an `output.var` prints results, doesn't store them.
    - See the SQL chunk at line 301 for an example.
  - ggplot themes
    - `plotDemo` chunk
      - Lines 138-151 and 165- 178 set a bunch of options using `ggplot2::theme()`
      - Replace those lines with `customTheme` from the `customTheme` chunk (line 108)
        - Same results, but no copy and paste!
- Python Demo
  - `reticulate` can be a little tricky to get up and running.
    - The ["Configuration" Vignette](https://rstudio.github.io/reticulate/articles/versions.html) may help.
  - The `geoHist` chunk contains basic python code.
    - Can be executed just like R code - either the entire chunk _or_ line by line (a nice improvement over a Jupyter Notebook, IMHO)
    - R variables can be accessed in python code using `r.objectName`, as in line 380 and 389.
  - Python code _cannot_ currently be run inline.
    - However, python objects can be used in R code (both inline and in Chunks) using `py$pythonObject` (see lines 394 and 397)
  - Newer version of R studio have separate R _and_ python environment navigators to see what objects exist (in the "Environment" pane)
- custom CSS
  - External file: `Markdown/report.css`
    - Delete css definition from YAML
  - Can also write native CSS chunks - see the bottom of the document.
    - Update Font to 'EB Garamond', 12 pt.
    - Update Horizontal rule from `dotted` to `solid`
      - Change color to ``#03AC13`
    - Updates will take affect the next time it's rendered/knit
- Native HTML code and JavaScript can also be authored
  - HTML is inserted in the text
    - See lines 65-74, which comment out a `<script>` section)
  - JavaScript can also run from a `js` chunk
    - See line 76 for the floating header code.
  - Also interactive elements like `leaflet` for maps, `DT` for tables, `dygraphs`
  - see [here](https://rmarkdown.rstudio.com/gallery)
- Tease Creation of Templates
  - creating a template: [here](https://bookdown.org/yihui/rmarkdown/template-structure.html)
