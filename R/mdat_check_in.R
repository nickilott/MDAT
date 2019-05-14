#' Check the proportion of species that are annotated in the microbe-directory
#'
#' This function takes the microbe directory dataframe and the species list as input. It
#' reports the proportion of species in the input list that are present in the microbe directory.
#' If the parameter guess_names == TRUE then it will try and guess names of the input to match
#' the microbe directory. The function returns the species list (revised or original depending
#' if names were guessed)
#'
#' @param microbe_directory species_list guess_names
#' @export
#' @examples
#' check_in(microbe_directory=microbe_directory, species_list=species_list, guess_names=TRUE)

check_in <- function(microbe_directory=microbe_directory, species_list=species_list, guess_names=TRUE){

    species_list <- unique(species_list)

    n_in_list <- length(species_list)
    microbe_directory_list <- rownames(microbe_directory)
    in_directory <- intersect(microbe_directory_list, species_list)
    n_annotated <- length(in_directory)
    p_in <- (n_annotated/n_in_list)*100

    # guess the name of discordant ones
    if (guess_names == TRUE){
        cat("Checking names and revising input list...\n")
        if (p_in < 100){
            for (i in 1:length(microbe_directory_list)){
                # assume things are the same up to family level
                md_family <- unlist(strsplit(microbe_directory_list[i], ";g__"))
                md_genus <- unlist(strsplit(microbe_directory_list[i], ";s__"))
                md_species <- gsub(";s__", "", md_genus[2])
                md_species <- unlist(strsplit(md_species, "_"))[2]
                md_family <- md_family[1]
                for (j in 1:length(species_list)){
		    # skip if it's alerady been found
                    if (species_list[j] %in% in_directory){next}
                    test_family <- unlist(strsplit(species_list[j], ";g__"))
                     test_genus <- unlist(strsplit(species_list[j], ";s__"))
                    test_species <- gsub(";s__", "", test_genus[2])
                    test_species <- unlist(strsplit(test_species, "_"))[2]
                    test_family <- test_family[1]

                    # test if families are the same first
                    if (md_family == test_family){
		        # now test species
		        if (md_species == test_species){
                           cat(paste0("Changing ", species_list[j], " to ", microbe_directory_list[i], "\n"))
                           species_list[j] <- microbe_directory_list[i]
                       }
                    }
                }
            }
        }
    }
    in_directory_revised <- intersect(microbe_directory_list, species_list)
    n_annotated_revised <- length(in_directory_revised)
    p_in_revised <- (n_annotated_revised/n_in_list)*100
    cat(paste0("Original list had ", p_in, "% annotated.\n", "Revised list now has ", p_in_revised, "% annotated\n"))
    return(species_list)    
}
