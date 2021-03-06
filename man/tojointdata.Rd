% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tojointdata.R
\name{tojointdata}
\alias{tojointdata}
\title{Function to change multi-study data into jointdata format}
\usage{
tojointdata(
  dataset = NULL,
  longitudinal = NULL,
  survival = NULL,
  baseline = NULL,
  id,
  longoutcome,
  timevarying = NULL,
  survtime,
  cens,
  time = NULL,
  longtimes = NULL
)
}
\arguments{
\item{dataset}{a dataset or list of datasets.  The datasets can be of either
long or wide format holding both the longitudinal and survival information
(and any baseline information).  Either the parameter \code{dataset} should
be specified, or the parameters \code{longitudinal} and \code{survival}
(and \code{baseline} if available) should be supplied.}

\item{longitudinal}{a dataset or list of datasets in long format containing
the longitudinal outcome and any time varying covariates.  It can also
contain baseline information.  This should not be supplied if
\code{dataset} is supplied to the function call.}

\item{survival}{a dataset or list of datasets in wide format (one row per
individual) containing the survival information (survival time and
censoring variable).  It can also contain baseline information. This should
not be supplied if \code{dataset} is supplied to the function call.}

\item{baseline}{a dataset or list of datasets in wide format (one row per
individual) containing any baseline information.  This variable does not
have to be supplied if there is no baseline information, or if it is
already contained in the longitudinal or survival datasets.  This should
not be supplied if \code{dataset} is supplied to the function call.}

\item{id}{a character string holding the name of the id variable.  This
should be present in all datasets supplied to this function.}

\item{longoutcome}{a character string holding the name of the longitudinal
outcome.}

\item{timevarying}{a vector of character strings indicating the names of the
time varying covariates in the dataset}

\item{survtime}{a character string denoting the name of the surivival time
variable in the dataset}

\item{cens}{a character string denoting the name of the censoring variable in
the dataset}

\item{time}{a character string to label the time variable if the data is
transformed from wide to long format, or the name of the variable holding
the time variable if the data is supplied in long format}

\item{longtimes}{if wide data, the labels that denote the time varying
variables to allow the longitudinal data to be returned in long data
format.}
}
\value{
A jointdata object, see \code{\link[joineR]{jointdata}}.
}
\description{
This function is designed to take data in various formats from multiple
studies and output the data in a \code{jointdata} format.
}
\details{
The data supplied to the \code{jointmeta1} function has to be in a
  \code{\link[joineR]{jointdata}} format.  However it is conceivable that
  data supplied from multiple studies could come in a range of formats.

  This function can handle a range of formats in which data from multiple
  studies may be supplied.  This are discussed below.  We refer to wide data
  as data that contains both time varying and time stationary data, with one
  line per individual with variables measured over time recorded in multiple
  columns.  We refer to long data as data with multiple lines per individual,
  with time varying covariates differing between rows, but time stationary
  covariates identical between rows.  Survival data are considered data with
  survival outcome (survival time and censoring variable) with or without
  baseline data.  Longitiudinal datasets are considered long format datasets
  containing time varying data potentially with baseline data. Baseline
  datasets are considered wide format datasets containing non-time varying
  data measured at baseline. This function can take data in the following
  formats and output a \code{jointdata} object. \describe{

  \item{\code{One wide dataset}}{One dataset in wide format (one row per
  individual) supplied to the parameter \code{dataset} in the function call
  with \code{longitudinal}, \code{survival} and \code{baseline} set to
  \code{NULL}, or left unspecified in the function call.  This dataset would
  contain all the data from all studies, and the survival, longitudinal and
  any baseline information would all be present in the same dataset.}

  \item{\code{One long dataset}}{One dataset in long format (multiple rows
  for each individual) supplied to the parameter \code{dataset} in the
  function call with \code{longitudinal}, \code{survival} and \code{baseline}
  set to \code{NULL}, or left unspecified in the function call.  This dataset
  would contain all the data from all studies, and the survival, longitudinal
  and any baseline information would all be present in the same dataset.}

  \item{\code{A list of study specific wide datasets}}{One dataset for each
  study, each in wide format (one row per individual), supplied to the
  parameter \code{dataset} in the function call with \code{longitudinal},
  \code{survival} and \code{baseline} set to \code{NULL}, or left unspecified
  in the function call.  The data from each study would contain the survival,
  longitudinal and any baseline information.}

  \item{\code{A list of study specific long datasets}}{One dataset for each
  study, each in long format (multiple rows per individual), supplied to the
  parameter \code{dataset} in the function call with \code{longitudinal},
  \code{survival} and \code{baseline} set to \code{NULL} or left unspecified
  in the function call.  The data from each study would contain the survival,
  longitudinal and any baseline information.}

  \item{\code{One longitudinal and one survival dataset with or without an
  additional baseline dataset}}{In this case all the longitudinal and time
  varying data for all studies is supplied in a single dataset in long format
  to the parameter \code{longitudinal}.  All the survival data for all
  studies is supplied in a single dataset in wide format to the parameter
  \code{survival}.  Baseline data can be present in these two datasets, or
  can also be supplied as a dataset to the parameter \code{baseline}. If
  \code{longitudinal} and \code{survival} are specified, then parameter
  \code{dataset} should be set to \code{NULL} or left unspecified in the
  function call. The parameter \code{baseline} is optional, but should only
  be specified if parameter \code{dataset} is \code{NULL} or unspecified.}

  \item{\code{A list of longitudinal and a list of survival datasets with or
  without a list of baseline datasets}}{In this case the longitudinal and
  time varying data for each study is supplied as one element of a list of
  long format datasets to the parameter \code{longitudinal}.  The survival
  data for each study is supplied as one element of a list of wide format
  datasets to the parameter \code{survival}. Baseline data can be present in
  these two sets of datasets, or can be supplied as an additional list of
  datasets one for each study to the parameter \code{baseline}. If
  \code{longitudinal} and \code{survival} are specified (\code{baseline} is
  optional), then parameter \code{dataset} should be set to \code{NULL}, or
  left unspecified in the function call.}

  }

  The specified id variable should be present in all datasets supplied to the
  function.  Variables containing the same information should be identically
  named in each supplied dataset, for example if a variable \code{'age'} is
  present in one dataset, denoting age of individual at baseline,
  corresponding variables in other datasets also supplying age at baseline
  should also be named \code{'age'}.  Similarly, different variables should
  not share the same name across different datasets, for example there should
  not be a variable named \code{'age'} in the longitudinal dataset denoting
  individual's age at last longitudinal measurement along with a variable
  \code{'age'} in the baseline dataset that denotes age of the individual at
  baseline.  Before supplying data to this function, names of variables in
  each dataset should be checked to confirm that common variables share the
  same name, and differing variables are appropriately distinguished from
  each other.
}
\examples{

   #simdat is a simulated dataset available in the joineRmeta package
   #it is supplied as a list of longitudinal and a list of survival datasets,
   #each list is of length equal to the number of studies in the entire
   #dataset.
   jointdat<-tojointdata(longitudinal = simdat$longitudinal,
                         survival = simdat$survival, id = 'id',
                         longoutcome = 'Y', timevarying = c('time','ltime'),
                         survtime = 'survtime', cens = 'cens', time = 'time')

}
\seealso{
\code{\link[joineR]{jointdata}}, \code{\link{jointmeta1}}
}
