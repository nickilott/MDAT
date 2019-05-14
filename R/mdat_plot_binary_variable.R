#' Plot binary variable in test and background sets
#'
#' Barplot of the distribution of values between test and
#' background sets of species
#'
#' @param contingency_table
#' @export
#' @import reshape
#' @import ggplot2
#' @examples
#' plot_binary_variable(contingency_table)

plot_binary_variable <- function(contingency_table, label="label"){

    library(reshape)
    dat <- melt(contingency_table)
    dat$Var.1 <- as.factor(dat$Var.1)
    p1 <- ggplot(dat, aes(x=Var.2, y=value, fill=Var.1))
    p2 <- p1 + geom_bar(stat="identity")
    p3 <- p2 + scale_fill_manual(values=c("grey", "black", "white"), name=label)
    p4 <- p3 + theme_bw()
    p5 <- p4 + ggtitle(label)
    p6 <- p5 + xlab("") + ylab("Count")
    return(p6)
    }