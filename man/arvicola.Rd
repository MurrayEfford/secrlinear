\name{Arvicola}
\docType{data}

\alias{arvicola}

\title{ Water Vole Capture Dataset }

\description{

Data from a trapping study of water voles (\emph{Arvicola amphibius})
along a river in Oxfordshire, U.K.

}

\usage{arvicola}

\format{\pkg{secr} \link[secr]{capthist} object}

\details{

  Water voles were trapped monthly from May
  1984 to May 1985 along 0.9 km of the River Glyme near Woodstock in
  Oxfordshire, U.K. (Efford 1985). Two sheet-aluminium traps were set at
  stations 20 m apart along one bank and checked morning and evening for
  3 days. Traps were baited with slices of carrot and provisioned with
  bedding and additional carrot. Voles were marked with individual
  colour-coded ear tags. The dataset provided is from June 1984. This
  was early in the breeding season and most voles were overwintered
  adults; only 3 were young-of-the-year, and these were omitted.

Raw data files ``Jun84capt.txt'' and ``glymetrap.txt'' are provided in
the `extdata' folder of the \pkg{secrlinear} installation. The vignette
\url{../doc/secrlinear-vignette.pdf} shows how to import the raw data.

The data comprise detections of 26 voles at 44 stations on 6
occasions. The two traps at each station were notionally labelled `A'
and `B', but captures were recorded only by the station at which they
occurred: captures were assigned label `A' or `B' effectively at
random. Each trap could catch a single adult vole, but trap saturation
was low (maximum 20.5\% of traps caught a vole). No voles died in traps
in June 1984.

Water voles in the U.K. restrict their activity to waterways and their
immediate banks, except for some populations in more extensive
(2-dimensional) wetlands. It is therefore natural to treat their habitat
as linear in a spatially explicit capture--recapture model of these
data. A suitable linear habitat mask is provided in the accompanying
dataset \link{glymemask}.

See \url{../doc/secrlinear-vignette.pdf} for more analysis of this
dataset.

}

\source{

M. G. Efford unpublished data.

}

\references{

 Efford, M. G. (1985) \emph{The structure and dynamics of water vole
 populations}. D.Phil thesis, University of Oxford.

}

\seealso{

\link{glymemask}

}

\examples{

head(traps(arvicola))

## for speed, pre-compute distance matrix
userd <- networkdistance (traps(arvicola), glymemask, glymemask)
## fit model
glymefit <- secr.fit(arvicola, mask = glymemask, trace = FALSE,
                     details = list(userdist = userd))
## estimates of 'real' parameters
predict(glymefit)

\dontrun{
summary(arvicola)

tmp <- secr.test(glymefit, nsim = 1000)
tmp
plot(tmp)

## More voles were caught only once than is predicted by the model.
## This is probably due to within-population variation in movement or
## capture probability.

}

}

\keyword{datasets}
