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

    p1 <- run_association_list[[2]][[1]]
    if (is.null(p1)){ p1 <- plot_null(p1, label="gram_stain") }
    p2 <- run_association_list[[2]][[2]]
    if (is.null(p2)){ p2 <- plot_null(p2, label="microbiome_location") }
    p3 <- run_association_list[[2]][[3]]
    if (is.null(p3)){ p3 <- plot_null(p3, label="antimicrobial_susceptibility") }
    p4 <- run_association_list[[2]][[4]]
    if (is.null(p4)){ p4 <- plot_null(p4, label="extreme_environment") }
    p5 <- run_association_list[[2]][[5]]
    if (is.null(p5)){ p5 <- plot_null(p5, label="biofilm_forming") }
    p6 <- run_association_list[[2]][[6]]
    if (is.null(p6)){ p6 <- plot_null(p6, label="animal_pathogen") }
    p7 <- run_association_list[[2]][[7]]
    if (is.null(p7)){ p7 <- plot_null(p7, label="spore_forming") }
    p8 <- run_association_list[[2]][[8]]
    if (is.null(p8)){ p8 <- plot_null(p8, label="plant_pathogen") }
    p9 <- run_association_list[[2]][[9]]
    if (is.null(p9)){ p9 <- plot_null(p9, label="pathogenicity") }
    p10 <- run_association_list[[2]][[10]]
    if (is.null(p10)){ p10 <- plot_null(p10, label="optimal_ph") }
    p11 <- run_association_list[[2]][[11]]
    if (is.null(p11)){ p11 <- plot_null(p11, label="optimal_temperature") }
    
    p <- arrangeGrob(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, ncol=4)

    if (output == "print"){
        grid.draw(p)}
    else{
        return(p)}
}


