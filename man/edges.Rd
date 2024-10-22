\name{edges}
\alias{edges}
\alias{showedges}
\alias{replot}
\alias{addedges}
\alias{deleteedges}
\alias{cleanskips}

\title{Interactive Edge Edit}

\description{

  A `skip' is defined here as a graph edge between two input lines. Many skips are
legitimate, but some `shortcut' skips are artefacts of the simple algorithm
used by \code{\link{asgraph}} to construct the graph topology. These are
better removed. These functions allow skips in a \link{linearmask} to be visualised and edited.

\code{addedges} may be used to bridge artefactual gaps in a network, or
to correct editing mistakes. The edge weight of a new edge is its Euclidean length.

}

\usage{

showedges(mask, plt = TRUE, add = FALSE, type = c('all', 'noskips', 'skips'), 
                       lengths = c(0,Inf), ...)

replot(mask, xlim = NULL, ylim = NULL, ...)

addedges(mask, replot = TRUE, ...)

deleteedges(mask, replot = TRUE, ...)

cleanskips(mask)

}

\arguments{
  \item{mask}{linearmask object with 'graph' attribute}
  \item{lengths}{numeric vector of minimum and maximum edge length (weight)}
  \item{plt}{logical; if TRUE the edges are plotted}
  \item{add}{logical; if TRUE the edges will be added to an existing plot}
  \item{type}{character value for subset of edges to show}
  \item{xlim}{vector of min and max x-values for new plot}
  \item{ylim}{vector of min and max y-values for new plot}
  \item{replot}{logical; if TRUE the plot will be re-done using replot}
  \item{\dots}{other arguments (see details)}
}

\details{

  \code{showedges} is a general-purpose function for displaying or
  extracting edge information from the graph attribute of a linear mask.

  \code{cleanskips} removes any between-line `skips' that are longer
  than the shortest `skip'. 

Other functions here are used to manually edit a mask graph.

  \code{replot} is used to zoom in on part of a linear mask (often to inspect `skips').
  
   The dots argument \dots is passed by \code{replot} to \code{plot.linearmask} and by \code{addedges} and \code{deleteedges} to \code{showedges} (if replot = TRUE).
  
}

\value{

\code{showedges} returns a dataframe with one row for each edge, and columns --
\item{start}{index of start vertex}
\item{finish}{index of finish vertex}
\item{line1}{line number of start}
\item{line2}{line number of finish}
\item{x1}{geographic coordinates of start}
\item{y1}{geographic coordinates of start}
\item{x2}{geographic coordinates of finish}
\item{y2}{geographic coordinates of finish}
\item{weight}{"weight" attribute of edge (its length in metres)}
The dataframe is returned invisibly if \code{plt = TRUE}.

\code{cleanskips} returns a linearmask object.

\code{replot} returns NULL.
  
  \code{addedges} and \code{deleteedges} invisibly returns a linear mask
  object with updated graph attribute.
}

\seealso{
  
  \link{linearmask}, \code{\link{getLineID}}
  
}

\examples{
\dontrun{
inputdir <- system.file("extdata", package = "secrlinear")
tempmask <- read.linearmask(file = paste0(inputdir, "/silverstream.shp", spacing = 50)

## show all edges
plot(tempmask, linecol = 'white')
tmp <- showedges(tempmask, add = TRUE)

## select a rectangular area to zoom in
replot(tempmask)

## click on the vertices of one or more edges to delete or add
tempmask <- deleteedges(tempmask)
tempmask <- addedges(tempmask)

}
}

\keyword{manip }

