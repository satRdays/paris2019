
# Paris 2019 

## Workshops - packages requirements 

#### 11:00	12:30	Susan Baert: Introduction to the tidyverse.

```
tidyverse
```

#### 11:00	12:30	Étienne Côme, Kim Antunez, Timothée Giraud: Spatial data and cartography

```
cartography (>=2.2.0)
dplyr
ggplot2 (>=3.1.0)
leaflet
maptools
mapview
osmdata
sf (>=0.7-2) (for Unix-alikes systems, see: https://github.com/r-spatial/sf#linux)
SpatialPosition
tmap
```

You can find the [lecture](https://comeetie.github.io/satRday/lecture/lecture.html) and the [exercices](https://comeetie.github.io/satRday/exercises/exercises.html) online.

We invite you to download the data (1.3 MB) you will need for this workshop in advance:
```{r}
# download the dataset
download.file("https://github.com/comeetie/satRday/blob/master/exercises/data.zip?raw=true", 
              destfile = "data.zip")
# unzip
unzip("data.zip",exdir=".") 
```

#### 13:30	15:00	Sophie Donnet: Machine Learning, deep learning with R (FULL)

- [Installation instructions](installation_instructions.pdf)
- [Introduction to deep learning](cours_deeplearning_for_dummies.pdf)
- [Deep-with-R_tutorial.R](Deep-with-R_tutorial.R)
- [Deep-with-R.html](Deep-with-R.html)

#### 13:30	15:00	Corentin Roquebert: Textual analysis with R

```
tm
wordcloud
quanteda
remotes
# Github specific package:
remotes::install_github("juba/rainette"))
```

Corpus is available [here](corpusrap_clean.csv)

#### 15:30	17:00	Andrew Collier Markdown: Reproducible Research and Automated Reporting.

This tutorial is for you if

- you know a bit of R;
- you might (or might not) be familiar with R Markdown; and
- you are interested in using R to generate reports (or other automated documents).

This tutorial is *not* for you if

- you're an R Markdown wizard/ninja/deity.

Please install the following packages:

- [`tidyverse`](https://cran.r-project.org/web/packages/tidyverse/)
- [`mailR`](https://cran.r-project.org/web/packages/mailR/)
- [`knitr`](https://cran.r-project.org/web/packages/knitr/)
- [`kableExtra`](https://cran.r-project.org/web/packages/kableExtra/)
- [`scales`](https://cran.r-project.org/web/packages/scales/)
- [`hrbrthemes`](https://cran.r-project.org/web/packages/hrbrthemes/)
- [`countrycode`](https://cran.r-project.org/web/packages/countrycode/)

The material for the tutorial is available [here](automated-reporting-tutorial.zip).

#### 15:30	17:00	DataThon - "Students well being"

```
# No Specific requirements
```
