#' Get a binary variable from microbe directory
#'
#' This function returns a dataframe of one of the binary
#' variable from the microbe directory for each of the test_set
#' and background set
#'
#' @param database test_set background_set variable
#' @export
#' @examples
#' get_binary_variable(microbe_directory=microbe_directory, test_set=test_set, background_set=background_set, variable="spore_forming")

get_binary_variable <- function(microbe_directory=microbe_directory,
                                      test_set=test_set,
				      background_set=background_set,
				      variable="spore_forming"){

    if (!(variable %in% c("gram_stain",
                          "microbiome_location",
			  "antimicrobial_susceptibility",
			  "extreme_environment",
			  "biofilm_forming",
			  "animal_pathogen",
			  "spore_forming",
			  "plant_pathogen",
			  "pathogenicity"))){
        stop(paste0("There is no binary variable '", variable, "' in The Microbe Directory"))
    }

    test_set_ids <- intersect(rownames(microbe_directory), test_set)

    test_set_variable <- data.frame(microbe_directory[test_set_ids, variable])
    test_set_variable$type <- "test_set"
    colnames(test_set_variable) <- c(variable, "type")
    
    background_set_ids <- intersect(rownames(microbe_directory), background_set)
    background_set_variable <- data.frame(microbe_directory[background_set_ids, variable])
    background_set_variable$type <- "background_set"
    colnames(background_set_variable) <- c(variable, "type")

    dat <- data.frame(bind_rows(test_set_variable, background_set_variable))
    rownames(dat) <- append(test_set_ids, background_set_ids)

    cat("Removing rows with no data...\n")
    dat <- na.omit(dat)

    return(dat)
    }