% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findCliques.R
\name{getCliques}
\alias{getCliques}
\title{Compute clique groups from processed m/z data}
\usage{
getCliques(
  mzdata,
  filter = TRUE,
  mzerror = 5e-06,
  intdiff = 1e-04,
  rtdiff = 1e-04,
  tol = 1e-05,
  silent = TRUE
)
}
\arguments{
\item{mzdata}{An 'object with processed m/z data. Currently supported
class types are 'xcmsSet' or 'XCMSnExp.}

\item{filter}{If TRUE, filter out very similar features
that have a correlation similarity > 0.99 and equal values of m/z,
retention time and intensity.}

\item{mzerror}{Relative error for m/z, if relative error 
between two features is below that value that features
are considered with similar m/z value.}

\item{intdiff}{Relative error for intensity, if relative
error between two features is below that value that
features are considered with similar intensity.}

\item{rtdiff}{Relative error for retention time, if 
relative error between two features is below that value
that features are considered with similar retention time.}

\item{tol}{Minimum relative increase in log-likelihood to do
a new round of log-likelihood maximisation.}

\item{silent}{If 'FALSE' print on the console the log-likelihood
maximization progress. Default is 'TRUE'.}
}
\value{
It returns an 'anClique' object with the computed
clique groups. It adds the column 'cliqueGroup' to the
'peaklist' in the 'anClique' object.
}
\description{
This function splits features in groups to
find isotope and adduct annotation within each group. To
find them it uses a similarity network.
This similarity network has nodes as features and weighted
edges as the cosine similarity between features. Once
the network is obtained we find clique groups in this network.
The clique groups are fully connected components with
high similarity in inner edges and lower similarity in
edges outside the clique. We move nodes to different groups
until we find the groups with the maximum log-likelihood.
}
\details{
Signal processing algorithms may output artefact features.
Sometimes they produce two artefact features which are almost identical
This artefacts may lead to errors in the computation of the clique
groups, so it is recommended to set 'filter' = TRUE to drop repeated.
features.
}
\examples{
library(BiocParallel)
mzfile <- system.file("standards.mzXML", package = "cliqueMS")
msSet <- xcms::xcmsSet(files = mzfile, method = "centWave",
ppm = 15, peakwidth = c(5,20), snthresh = 10,
BPPARAM = BiocParallel::SerialParam())
ex.cliqueGroups <- getCliques(msSet)
}
\seealso{
\code{\link{computeCliques}}
\code{\link{createNetwork}}
\code{\link{anClique}}
}
