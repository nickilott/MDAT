#' Get the annotations for the test set
#'
#' This function returns a list of data frames, one for each variable
#' in the microbe directory.
#' It contains the annotations for the test set and background set.
#'
#' @param database test_set
#' @export
#' @examples
#' get_annotations(test_set=test_set, background_set=background_set)

get_annotations <- function(test_set=test_set, background_set=background_set, guess_names=FALSE){

    microbe_directory <- get_microbe_directory()

    # convert names and check how many are annotated
    test_set <- check_in(microbe_directory=microbe_directory,
                         species_list=test_set,
			 guess_names=guess_names)

    background_set <- check_in(microbe_directory=microbe_directory,
                               species_list=background_set,
			       guess_names=guess_names)

    # resulting annotations container
    annotations <- list()

    # Binary variables
    binary_variables <- c("gram_stain",
                          "microbiome_location",
			  "antimicrobial_susceptibility",
			  "extreme_environment",
			  "biofilm_forming",
			  "animal_pathogen",
			  "spore_forming",
			  "plant_pathogen",
			  "pathogenicity")

    for (i in 1:length(binary_variables)){
        bin.variable <- binary_variables[i]
        dat <- get_binary_variable(microbe_directory=microbe_directory,
                                   test_set=test_set,
				   background_set=background_set,
				   variable=bin.variable)
        annotations[[i]] <- dat        
    }
    
    # quantitative variables
    quantitative_variables <- c("optimal_ph", "optimal_temperature")

    for (i in 1:length(quantitative_variables)){
        quant.variable <- quantitative_variables[i]
        dat <- get_quantitative_variable(microbe_directory=microbe_directory,
                                   test_set=test_set,
				   background_set=background_set,
				   variable=quant.variable)
        annotations[[i+9]] <- dat
    }
    names(annotations) <- append(binary_variables, quantitative_variables)
    return(annotations)
    }
