############################################################################################
## package 'secrlinear'
## linearkd.R
## 2023-12-24
############################################################################################

linearkd <- function (X, linmask, sigma, which = NULL, ...) {
  if (requireNamespace("spatstat.geom", quietly = TRUE) && 
      requireNamespace("spatstat.linnet", quietly = TRUE)) {
    gr <- attr(linmask, 'graph')
    ed <- igraph::as_data_frame(gr, what = "edges")
    if (is.null(which)) which <- 1:nrow(ed)
    ed <- ed[which,1:2]
    ed <- matrix(as.numeric(unlist(ed)), ncol = 2)
    xyppp <- spatstat.geom::ppp(x = linmask$x, y = linmask$y, 
                                window = spatstat.geom::boundingbox(linmask))
    lin <- spatstat.linnet::linnet(xyppp, edges = ed)
    mylpp <- spatstat.linnet::lpp(X, lin)
    kd.im <- spatstat.linnet::density.lpp(mylpp, sigma = sigma, ...) 

    # extract linim values
    df <- as.data.frame(kd.im)[,c('xc','yc','values')]
    names(df) <- c("x", "y", "density")
    kd.mask <- read.mask(data = df, spacing = kd.im$xstep)
    
    # match to initial mask
    addCovariates(linmask, kd.mask)
  }
  else {
    stop ("linearkd requires package spatstat")
  }
}

