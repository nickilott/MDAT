#' Read The Microbe Directory database
#'
#' This function reads in the data in csv format.
#' @param database in .csv format
#' @export
#' @examples
#' read_database("microbe-directory.csv")

read_database <- function(database){

    dat <- read.csv(database, header=TRUE, stringsAsFactors=FALSE, row.names=1)
    return(dat)
    }