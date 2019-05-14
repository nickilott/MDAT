#' Return a dataframe of The Microbe Directory
#'
#' This function formats the taxonomic labels and removes the
#' citation columns
#'
#' @export
#' @examples
#' get_microbe_directory()

get_microbe_directory <- function(){

    md <- format_identifiers(microbe_directory)
    md <- md[,grep("_citation", colnames(md), invert=TRUE)]
    return(md)
    }
