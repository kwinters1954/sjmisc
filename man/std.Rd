% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/std.R
\name{std}
\alias{std}
\alias{center}
\title{Standardize and center variables}
\usage{
std(x, ..., robust = c("sd", "gmd", "mad"), include.fac = FALSE,
  append = TRUE, suffix = "_z")

center(x, ..., include.fac = FALSE, append = TRUE, suffix = "_c")
}
\arguments{
\item{x}{A vector or data frame.}

\item{...}{Optional, unquoted names of variables that should be selected for
further processing. Required, if \code{x} is a data frame (and no
vector) and only selected variables from \code{x} should be processed.
You may also use functions like \code{:} or tidyselect's
\code{\link[tidyselect]{select_helpers}}.
See 'Examples' or \href{../doc/design_philosophy.html}{package-vignette}.}

\item{robust}{Character vector, indicating the method applied when
standardizing variables with \code{std()}. By default, standardization is
achieved by dividing the centered variables by their standard deviation
(\code{robust = "sd"}). However, for skewed distributions, the median
absolute deviation (MAD, \code{robust = "mad"}) or Gini's mean difference
(\code{robust = "gmd"}) might be more robust measures of dispersion. For
the latter option, \CRANpkg{sjstats} needs to be installed.}

\item{include.fac}{Logical, if \code{TRUE}, factors will be converted to numeric
vectors and also standardized or centered.}

\item{append}{Logical, if \code{TRUE} (the default) and \code{x} is a data frame,
\code{x} including the new variables as additional columns is returned;
if \code{FALSE}, only the new variables are returned.}

\item{suffix}{String value, will be appended to variable (column) names of
\code{x}, if \code{x} is a data frame. If \code{x} is not a data
frame, this argument will be ignored. The default value to suffix
column names in a data frame depends on the function call:
\itemize{
  \item recoded variables (\code{rec()}) will be suffixed with \code{"_r"}
  \item recoded variables (\code{recode_to()}) will be suffixed with \code{"_r0"}
  \item dichotomized variables (\code{dicho()}) will be suffixed with \code{"_d"}
  \item grouped variables (\code{split_var()}) will be suffixed with \code{"_g"}
  \item grouped variables (\code{group_var()}) will be suffixed with \code{"_gr"}
  \item standardized variables (\code{std()}) will be suffixed with \code{"_z"}
  \item centered variables (\code{center()}) will be suffixed with \code{"_c"}
}}
}
\value{
A vector with standardized or centered variables. If \code{x} is a
        data frame, only the transformed variables will be returned.
}
\description{
\code{std()} computes a z-transformation (standardized and centered)
             on the input. \code{center()} centers the input.
}
\details{
\code{std()} and \code{center()} also work on grouped data frames
         (see \code{\link[dplyr]{group_by}}). In this case, standardization
         or centering is applied to the subsets of variables in \code{x}.
         See 'Examples'.
}
\note{
\code{std()} and \code{center()} only return a vector, if \code{x} is
        a vector. If \code{x} is a data frame and only one variable is specified
        in the \code{...}-ellipses argument, both functions do return a
        data frame (see 'Examples').
}
\examples{
data(efc)
std(efc$c160age) \%>\% head()
std(efc, e17age, c160age, append = FALSE) \%>\% head()

center(efc$c160age) \%>\% head()
center(efc, e17age, c160age, append = FALSE) \%>\% head()

# NOTE!
std(efc$e17age) # returns a vector
std(efc, e17age) # returns a tibble

# works with mutate()
library(dplyr)
efc \%>\%
  select(e17age, neg_c_7) \%>\%
  mutate(age_std = std(e17age), burden = center(neg_c_7)) \%>\%
  head()

# works also with grouped data frames
mtcars \%>\% std(disp)

mtcars \%>\%
  group_by(cyl) \%>\%
  std(disp)

data(iris)
# also standardize factors
std(iris, include.fac = TRUE, append = FALSE)
# don't standardize factors
std(iris, include.fac = FALSE, append = FALSE)

}
