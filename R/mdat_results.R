plot_null <- function(plot, label="nolabel"){

        df <- data.frame(x=1, y=1, text.output="No data")
        plot1 <- ggplot(df, aes(x=x, y=y, label=text.output)) + geom_text()
	plot2 <- plot1 + theme(panel.background=element_rect(fill="white", colour="white"))
	plot3 <- plot2 + theme(panel.grid.major=element_line(colour="white"))
        plot4 <- plot3 + theme(panel.grid.minor=element_line(colour="white"))
        plot5 <- plot4 + theme(legend.position="none")
        plot6 <- plot5 + theme(axis.line=element_blank())
        plot7 <- plot6 + theme(axis.text.x=element_blank())
        plot8 <- plot7 + theme(axis.text.y=element_blank())
        plot9 <- plot8 + theme(axis.ticks=element_blank())
        plot10 <- plot9 + theme(axis.title.x=element_blank())
        plot10 <- plot10 + theme(axis.title.y=element_blank()) + ggtitle(label) 
        return(plot10)
}

#' Get the results table
#'
#' Return results table
#' @param result from run_associations
#' @export
#' @examples
#' get_results(run_association_list)

get_results <- function(run_association_list){

    return(run_association_list[[1]])
    }

#' Plot the results
#'
#' Plot the results that are stored after run_associations
#' @param plot results from run_associations
#' @import gridExtra grid
#' @export
#' @examples
#' plot_results(run_association_list)

plot_results <- function(run_association_list, output="print"){

    if (!(output %in% c("print", "return"))){
        stop("Output must be one of 'print' or 'return'")}

    p <- arrangeGrob(grobs=run_association_list[[2]], ncol=4)

    if (output == "print"){
        grid.draw(p)}
    else{
        return(p)}
}


