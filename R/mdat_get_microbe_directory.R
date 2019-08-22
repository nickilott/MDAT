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

    # change the 0,1 etc categories to something
    # more meaningful
    md$gram_stain <- ifelse(md$gram_stain == 0, "-ve", md$gram_stain)
    md$gram_stain <- ifelse(md$gram_stain == 1, "+ve", md$gram_stain)
    md$gram_stain <- ifelse(md$gram_stain == 2, "indeterminate", md$gram_stain)

    md$microbiome_location <- ifelse(md$microbiome_location == 0, "No", md$microbiome_location)
    md$microbiome_location <- ifelse(md$microbiome_location == 1, "Yes", md$microbiome_location)

    md$pathogenicity <- ifelse(md$pathogenicity == 1, "COGEM-1", md$pathogenicity)
    md$pathogenicity <- ifelse(md$pathogenicity == 2, "COGEM-2", md$pathogenicity)
    md$pathogenicity <- ifelse(md$pathogenicity == 3, "COGEM-3", md$pathogenicity)

    md[md == 0] <- "No"
    md[md == 1] <- "Yes"

    md$optimal_ph <- as.numeric(md$optimal_ph)
    md$optimal_temperature <- as.numeric(md$optimal_temperature)

    return(md)
    }
