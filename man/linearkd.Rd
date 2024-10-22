\name{linearkd}
\alias{linearkd}

\title{Kernel Density on Linear Network}

\description{

This function applies the kernel density methods of McSwiggan et al. (2016) as implemented in \pkg{spatstat} (Baddeley et al. 2015). The default method solves
the heat equation McSwiggan et al. (2016).

}

\usage{

linearkd(X, linmask, sigma, which = NULL, ...)

}

\arguments{

  \item{X}{2-column matrix of coordinates}
  
  \item{linmask}{linear habitat mask}
  
  \item{sigma}{numeric spatial scale of kernel}
  
  \item{which}{index vector to select subset of edges (optional)}
  
  \item{\dots}{other arguments passed to \code{spatstat.linnet::density.lpp}
  
}

}

\details{

The density along the network of the points in X is saved as covariate `density' of the linear mask.

Setting to FALSE the argument `finespacing' of \code{densityHeat.lpp} speeds up estimation. 

}

\value{

A linear habitat mask identical to the input except for the additional covariate. 

}

\references{

Baddeley, A., Rubak, E., and Turner, R. 2015. Spatial Point Patterns: Methodology and Applications with R. Chapman and Hall/CRC Press, London. ISBN 9781482210200, https://www.routledge.com/Spatial-Point-Patterns-Methodology-and-Applications-with-R/Baddeley-Rubak-Turner/p/book/9781482210200/. 

McSwiggan, G., Baddeley, A. and Nair, G. 2016. Kernel density estimation on a linear network. \emph{Scandinavian Journal of Statistics} \bold{44,} 324--345.

}

\seealso{

\code{\link{read.linearmask}}

}

\section{Warning}{This function is still in development: there are details to 
resolve concerning terminal vertices etc. }

\examples{

# simulate some points
set.seed(123)
pop <- sim.linearpopn(glymemask, N = 40)

# restrict edges to overcome a glitch in this particular linearmask

tmp <- linearkd(X = pop, linmask = glymemask, sigma = 30, 
    which = 1:325, finespacing = FALSE)

plot(tmp, cov = 'density', cex = 1.7)
plot (pop, add = TRUE, cex = 1.4)

# view covariates
head(covariates(tmp))

}
