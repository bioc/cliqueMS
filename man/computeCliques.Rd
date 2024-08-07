% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findCliques.R
\name{computeCliques}
\alias{computeCliques}
\title{Computes clique groups from a similarity network}
\usage{
computeCliques(anclique, tol = 1e-05, silent = TRUE)
}
\arguments{
\item{anclique}{This function uses S4 'anClique' object. Gives
warning if clique groups have already been computed.}

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
This function splits the features in the network
in clique groups. The cliques are fully connected components
that have high similarity for inner edges and low similarity
for edges outside the clique. This function finds the clique
groups that better fit this criteria, moving nodes to different
groups until we find the groups that have the best log-likelihood.
}
\examples{
library(BiocParallel)
mzfile <- system.file("standards.mzXML", package = "cliqueMS")
msSet <- xcms::xcmsSet(files = mzfile, method = "centWave",
ppm = 15, peakwidth = c(5,20), snthresh = 10,
BPPARAM = BiocParallel::SerialParam())
ex.anClique <- createanClique(msSet)
show(ex.anClique)
netlist <- createNetwork(msSet, xcms::peaks(msSet), filter = TRUE)
getNetanClique(ex.anClique) <- netlist$network
computeCliques(ex.anClique)
}
\seealso{
\code{\link{getCliques}}
}
