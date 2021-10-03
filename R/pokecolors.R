# pokecolors
#' Vectors of colors for figures
#'
#' Creates different vectors of related colors that may be useful for figures.
#'
#' @param palette Character string indicating a palette of colors.
#' @return Vector of character strings representing the chosen palette of colors.
#' @export
#' @importFrom grDevices rgb2hsv
#' @examples
#' par(mar=c(0.6,5.1,0.6,0.6))
#' plot(0, 0, type = "n", xlab = "", ylab = "", xlim = c(0, 6), ylim = c(4, 0), yaxs = "i",
#'      xaxt = "n", yaxt = "n", xaxs = "i")
#' axis(side=3, at=1:3, c("bulbasaur", "pal10", "pal11"), las=1)
#'
#' def <- pokecolors("bulbasaur")
#' points(seq(along = def), rep(1, length(def)), pch = 22, bg = def, cex = 8)
#' pal10 <- pokecolors("pal10")
#' points(seq(along = pal10), rep(2, length(pal10)), pch = 22, bg = pal10, cex = 8)
#' pal11 <- pokecolors("pal11")
#' points(seq(along = pal11), rep(3, length(pal11)), pch = 22, bg = pal11, cex = 8)
pokecolors <- function(palette = c("bulbasaur",
                                   "pal10",
                                   "pal11"))
{

  bulbasaur <- c("#15251a",
                 "#474a3b",
                 "#447356",
                 "#81a48d",
                 "#559a72",
                 "#284d38",
                 "#89e3a7",
                 "#9efbc0",
                 "#bed2a4",
                 "#98a188",
                 "#2d2d23",
                 "#7f876a",
                 "#e8e5dc",
                 "#c1bdc7",
                 "#cfc5ce",
                 "#a1a3ab")

  pal10 <- c('#3e71a8',
             '#577f9f',
             '#698e96',
             '#779d8d',
             '#84ad83',
             '#8fbd77',
             '#99cd6b',
             '#a2dd5c',
             '#aaee49',
             '#b2ff2e')

  pal11 <- c('#202547',
             '#323649',
             '#41474b',
             '#4e5a4c',
             '#5c6c4c',
             '#68804c',
             '#75944b',
             '#81a949',
             '#8ebe45',
             '#9ad340',
             '#a6e939',
             '#b2ff2e')

  switch(match.arg(palette),
         bulbasaur = bulbasaur,
         pal10   = pal10,
         pal11   = pal11)
}


# display.pokecolors
#' Display pokecolors
#'
#' displays the discrete pokecolors palettes
#'
#' @param palette Character string indicating a palette of colors.
#' @export
#' @importFrom grDevices rgb2hsv
#' @importFrom graphics image
#' @importFrom graphics text
#' @importFrom graphics par
#' @examples
#' display_pokecolors()
display_pokecolors <- function(palette = c("bulbasaur",
                                           "pal10",
                                           "pal11"))
{
  palette <- match.arg(palette)
  jcols   <- pokecolors(palette)
  n       <- length(jcols)
  cnames  <- names(jcols)
  image(1:n, 1, as.matrix(1:n),
        col  = jcols,
        xlab = "", ylab = "",
        xaxt = "n", yaxt = "n", bty = "n")
  text(1:n, par("usr")[1] - 0.025,
       srt = 45, adj = 0.5,
       labels = cnames, xpd = TRUE)
}

# display all pokecolors
#' Display all pokecolors
#'
#' Creates different vectors of related colors that may be useful for figures.
#'
#' @export
#' @importFrom grDevices rgb2hsv
#' @importFrom graphics rect
#' @importFrom graphics axis
#' @importFrom graphics plot
#' @examples
#' display_all_pokecolors()
display_all_pokecolors <- function()
{
  palette <- c("bulbasaur",
               "pal10",
               "pal11")
  jcols    <- sapply(palette, pokecolors)
  maxlen   <- max(sapply(jcols, length))
  ncols    <- length(jcols)


  plot(0, 0, type = "n", xlab = "", ylab = "", xlim = c(0, maxlen + 1),
       ylim = c((ncols + 1) * 2, 0), yaxs = "i",
       xaxt = "n", yaxt = "n", xaxs = "i")

  yseq <- seq(2, ncols * 2, length.out = ncols)

  axis(side = 2, at = yseq, palette, las = 1)

  for (c in 1:ncols)
  {
    pal <- pokecolors(palette[c])
    #points(seq(along = pal), rep(yseq[c], length(pal)), pch = 22, bg = pal, cex = 6)
    rect(xleft   = seq(along = pal) - 0.5,
         ybottom = yseq[c] - 0.85,
         xright  = seq(along = pal) + 0.5,
         ytop    = yseq[c] + 0.85,
         border  = NA,
         lwd     = 0,
         col     = pal)
  }
}



#' pokecolors color scales
#'
#' @inheritParams pokecolors
#' @param ... additional parameters for \code{\link[ggplot2]{discrete_scale}}
#' @export scale_color_pokecolors
#' @importFrom ggplot2 discrete_scale
#' @importFrom scales manual_pal
#' @rdname scale_pokecolors
#'
#' @examples
#' library(ggplot2)
#' data(morley)
#'
#' pltl <- ggplot(data = morley, aes(x = Run, y = Speed,
#' group = factor(Expt),
#' colour = factor(Expt))) +
#'     geom_line(size = 2) +
#'     theme_bw() +
#'     theme(panel.background = element_rect(fill = "grey97"),
#'           panel.border = element_blank())
#'
#' pltd <- ggplot(data = morley, aes(x = Run, y = Speed,
#' group = factor(Expt),
#' colour = factor(Expt))) +
#'     geom_line(size = 2) +
#'     theme_bw() +
#'     theme(panel.background = element_rect(fill = "grey15"),
#'           panel.border = element_blank(),
#'           panel.grid.major = element_line(color = "grey45"),
#'           panel.grid.minor = element_line(color = "grey25"))
#'
#' pltl + scale_color_pokecolors(palette = "bulbasaur")
#'
#' pltd + scale_color_pokecolors(palette = "bulbasaur")
#'
#'
scale_color_pokecolors = function (palette = c("bulbasaur",
                                               "pal10",
                                               "pal11"),
                                   ...)
{
  palette <- match.arg(palette)
  discrete_scale("colour",
                 "pokecolors",
                 manual_pal(unname(pokecolors(palette))),
                 ...)
}

#' @export scale_colour_pokecolors
#' @rdname scale_pokecolors
scale_colour_pokecolors = scale_color_pokecolors


#' @export scale_fill_pokecolors
#' @importFrom ggplot2 discrete_scale
#' @rdname scale_pokecolors
scale_fill_pokecolors = function (palette = c("bulbasaur",
                                              "pal10",
                                              "pal11"),
                                  ...)
{
  palette <- match.arg(palette)
  discrete_scale("fill",
                 "pokecolors",
                 manual_pal(unname(pokecolors(palette))),
                 ...)
}


