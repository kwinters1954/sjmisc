---
title: "Working with Labelled Data"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Working with Labelled Data}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

# Introduction into Labelled Data

_Labelled data_ (or labelled vectors) is a common data structure in other statistical environments to store meta-information about variables, like variable names, value labels or multiple defined missing values.

There are several approaches to facilitate this data structure in **R**, for instance packages like `haven`, `foreign`, `Hmisc`, or `labelled`. However, all these packages differ in the way how a labelled data structure is implemented, hence being capable to deal only with specific structures or classes of labelled vectors. The **sjmisc**-package aims at providing generic methods to work with any kind of labelled data.

_Labelled data_ extends **R**'s capabilities to deal with different types of missing values. Missing values no longer need to be represented by just a single value, `NA`, but each value can get a _missing flag_ via the `is_na`-attribute. The **sjmisc**-package offers functions to support these features.

## Labelled Data in haven and labelled

The `labelled`-package is intented to support `labelled` metadata structures only, thus the data structure of labelled vectors in `haven` and `labelled` is the same.

Labelled data in this format stores information about value labels, variable names and multiple defined missing values. However, _variable names_ are only part of this information if data was imported with one of `haven`s read-functions. Adding a variable label attribute is (at least currently) not possible via the `labelled`-method.


```r
library(haven)
```

```
## 
## Attache Paket: 'haven'
## 
## Die folgenden Objekte sind maskiert von 'package:sjmisc':
## 
##     read_sas, read_spss, read_stata, zap_labels
```

```r
x <- labelled(c(1, 2, 1, 8, 9),
              c(Male = 1, Female = 2, 
                Refused = 8, "Not applicable" = 9),
              c(FALSE, FALSE, TRUE, TRUE))

print(x)
```

```
## <Labelled>
## [1] 1 2 1 8 9
## 
## Labels:
##  value          label is_na
##      1           Male FALSE
##      2         Female FALSE
##      8        Refused  TRUE
##      9 Not applicable  TRUE
```

## Labelled Data in Hmisc

The `Hmisc`-package only supports variable labels. As additional information, in can store a unit measure as well.


```r
library(Hmisc)
x <- c(1, 2, 3, 4)
label(x) <- "Variable label"
units(x) <- "cm"
str(x)
```

```
## Classes 'labelled', 'numeric'  atomic [1:4] 1 2 3 4
##   ..- attr(*, "label")= chr "Variable label"
##   ..- attr(*, "units")= chr "cm"
```

## Labelled Data in foreign

The `foreign`-package stores value labels as `value.labels` attribute, while variable labels are stored as attribute of the data frame returned by the `read.spss`-method. If you use `sjmisc::read_spss`, variable labels are added as attribute to each variable.


```r
library(foreign)
efc <- read.spss("sample_dataset.sav", 
                 to.data.frame = TRUE, 
                 use.value.labels = FALSE, 
                 reencode = "UTF-8")
str(efc$16sex)

> $e16sex  : atomic  2 2 2 2 2 2 1 2 2 2 ...
>  ..- attr(*, "value.labels")= Named chr  "2" "1"
>  .. ..- attr(*, "names")= chr  "female" "male"

attr(efc, "variable.labels")['e16sex']

>            e16sex 
>  "elder's gender" 
```

# Value Labels

# Variable Labels

# Missing Values

# Converting Vectors