#' Format the taxonomic labels in the microbe directory data
#'
#' This function formats the taxonomic labels in the microbe directory
#' and adds them as rownames. It is from phylum -> species.
#'
#' @param microbe_directory
#' @export
#' @examples
#' format_identifiers(microbe_directory)

format_identifiers <- function(microbe_directory){

    phylum <- paste0("p__", microbe_directory[,2])
    class <- paste0("c__", microbe_directory[,3])
    order <- paste0("o__", microbe_directory[,4])
    family <- paste0("f__", microbe_directory[,5])
    genus <- paste0("g__", microbe_directory[,6])
    species <- paste0("s__", gsub(" ", "_", microbe_directory[,7]))

    new.id <- paste0(phylum, ";",
                     class, ";",
		     order, ";",
		     family, ";",
		     genus, ";",
		     species)

    rownames(microbe_directory) <- new.id

    microbe_directory <- microbe_directory[, 8:ncol(microbe_directory)]
    return(microbe_directory)
    }