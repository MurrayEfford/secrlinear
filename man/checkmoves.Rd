\name{checkmoves}
\alias{checkmoves}

\title{Check Movements}

\description{
  
This function reports problems indicated by extreme movements in a
capthist object. At present it is configured for distances measured
along a linearmask only.

}
\usage{

checkmoves (CH, accept = c(0, 1000), userdist, mask, showall = TRUE, silent = FALSE) 

}

\arguments{
  \item{CH}{single-session secr capthist object}
  \item{accept}{range of accepted movements in metres; may include Inf}
  \item{userdist}{matrix of distances between all traps(CH) (optional) }
  \item{mask}{\link{linearmask} object (optional)}
  \item{showall}{logical; if TRUE the output dataframe includes all
    detections of each individual with at least one extreme movement}
  \item{silent}{logical; if TRUE then console output is suppressed}
}
\details{

  This function works with Euclidean distances (the default if neither
  \code{mask} nor \code{userdist} is specified), non-Euclidean network distances
  implied by a linear habitat mask, or any distances presented in \code{userdist}.
  
  Linear habitat masks are prone to breaks (missing edges in the graph
  representation). If an animal is `recaptured' on both sides of a break
  then the network distance for that `movement' will be infinite.

  \code{checkmoves} displays the message `All OK' if there are no
  out-of-range movements, and otherwise displays the number of
  individuals with out-of-range movements.

}
\value{
  Invisibly returns a list with components
  \item{badmoves}{logical vector with one element for each animal
    (i.e. each row in CH)}
  \item{CH}{subset of the input CH containing the faulty detection
    histories}
  \item{df}{dataframe detailing the faulty detections}
}

\seealso{

\link{linearmask}

}

\examples{
out <- checkmoves(captdata, accept = c(0,100))
out
}

\keyword{ manip }

