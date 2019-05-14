#' Plot quantitative variable in test and background sets
#'
#' Boxplot of the distribution of values between test and
#' background sets of species
#'
#' @param quantitative_variable_dataframe
#' @export
#' @import ggplot2
#' @examples
#' plot_quantitative_variable(quantitative_variable_dataframe)

plot_quantitative_variable <- function(quantitative_variable_dataframe, colors=c("grey", "black")){

    label <- colnames(quantitative_variable_dataframe)[1]
    p1 <- ggplot(quantitative_variable_dataframe, aes_string(x="type", y=label, color="type"))
    p2 <- p1 + geom_boxplot(outlier.alpha=0)
    p3 <- p2 + geom_jitter(width=0.25, height=0) + theme_bw()
    p4 <- p3 + scale_color_manual(values=colors, name=label)
    return(p4)
    }