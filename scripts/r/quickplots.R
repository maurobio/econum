library(ggplot2)
library(ggrepel)
theme_set(theme_bw())

#scatterplot <- function(df, x, y, main="", sub="", xlab="", ylab="", size=3, color="black") {
#  gg <- ggplot(df) +
#          geom_point(aes(x, y), size=size, color=color) +
#          geom_text_repel(aes(x, y, label=rownames(df))) 

#  gg <- gg + labs(title=main, subtitle=sub, y=ylab, x=xlab)

#  gg <- gg + theme(panel.grid.major=element_blank(), 
#                    panel.grid.minor=element_blank(),
#                    axis.title.x=element_text(size=12), 
#                    axis.title.y=element_text(size=12), 
#                    axis.text.x=element_text(size=12),
#                    axis.text.y=element_text(size=12))
#  return(gg)
#}

scatterplot <- function(df, x, y, main="", xlab="", ylab="", size=3, color="black") {
  gg <- qplot(x, y, data=df, main=main, xlab=xlab, ylab=ylab) +
          geom_point(size=size, color=color) +
          geom_text_repel(aes(x, y, label=rownames(df)))

  gg <- gg + theme(panel.grid.major=element_blank(), 
                   panel.grid.minor=element_blank(),
                   axis.title.x=element_text(size=12), 
                   axis.title.y=element_text(size=12), 
                   axis.text.x=element_text(size=12),
                   axis.text.y=element_text(size=12),
                   plot.title = element_text(hjust = 0.5))
  return(gg)
}

screeplot <- function(df, main="", xlab="", ylab="", size=3, color="black") {
  gg <- qplot(c(1:length(df)), df, main=main, xlab=xlab, ylab=ylab) +
        geom_line(color=color) +
        geom_point(size=size, color=color) +
        scale_x_continuous(breaks=1:length(df)) +
        ylim(0,max(df))

  gg <- gg + theme(panel.grid.major = element_blank(), 
                    panel.grid.minor = element_blank(),
                    axis.title.x=element_text(size=12), 
                    axis.title.y=element_text(size=12), 
                    axis.text.x=element_text(size=12),
                    axis.text.y=element_text(size=12))
  return(gg)
}

histogram <- function(df, x, main="", xlab="", ylab="", fill="gray", color="black") {
  gg <- qplot(x, data=df, geom="histogram", main=main, xlab=xlab, ylab=ylab) +
      geom_histogram(color=color, fill=color)
  
  gg <- gg + theme(panel.grid.major = element_blank(), 
                   panel.grid.minor = element_blank(),
                   axis.title.x=element_text(size=12), 
                   axis.title.y=element_text(size=12), 
                   axis.text.x=element_text(size=12),
                   axis.text.y=element_text(size=12))
  return(gg)
}

# Use suppressMessages(print(hist)) instead of plot(hist)

boxplot <- function(x, group, main="", xlab="", ylab="", fill=NULL) {
  gg <- qplot(group, x, geom=c("boxplot"), main=main, xlab=xlab, ylab=ylab, fill=group)
  
  gg <- gg + theme(panel.grid.major = element_blank(), 
                   panel.grid.minor = element_blank(),
                   axis.title.x=element_text(size=12), 
                   axis.title.y=element_text(size=12), 
                   axis.text.x=element_text(size=12),
                   axis.text.y=element_text(size=12),
                   legend.position="none")
  return(gg)
}