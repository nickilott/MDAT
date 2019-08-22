#' Run the associations
#'
#' This is the main function that performs the association
#' testing between variables in The Microbe Directory and
#' species lists of interest.
#'
#' @param test_set vector of species of interest (e.g. differentially abundant
#' in the system of interest)
#' @param background_set vector of species to form the background set (null set)
#' @param guess_names try to match names of input (species) to microbe directory names
#' @export
#' @import dplyr
#' @examples
#' run_associations(test_set, background_set)

run_associations <- function(test_set,
                             background_set,
			     guess_names=FALSE,
			     variables=c("gram_stain",
			                 "microbiome_location",
					 "antimicrobial_susceptibility",
					 "extreme_environment",
					 "biofilm_forming",
					 "animal_pathogen",
					 "spore_forming",
					 "plant_pathogen",
					 "pathogenicity",
					 "optimal_ph",
					 "optimal_temperature")){


    # check that the variables are as expected
    # TODO

    # format identifiers
    microbe_directory <- get_microbe_directory()

    # convert names and check how many are annotated
    test_set <- check_in(microbe_directory=microbe_directory,
                         species_list=test_set,
			 guess_names=guess_names)

    background_set <- check_in(microbe_directory=microbe_directory,
                               species_list=background_set,
			       guess_names=guess_names)

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
    binary_variables <- intersect(binary_variables, variables)

    binary_results <- list()
    plots_binary <- list()
    for (i in 1:length(binary_variables)){
        bin.variable <- binary_variables[i]
        dat <- get_binary_variable(microbe_directory=microbe_directory,
                                   test_set=test_set,
				   background_set=background_set,
				   variable=bin.variable)
        # make contingency table
        c.table <- build_contingency_table(dat)

        # skip if not enough data
        if (nrow(c.table) < 2){next}

        # get the results
        res <- run_fisherexact(c.table, label=bin.variable)
        binary_results[[i]] <- res

        # plot
	p.binary <- plot_binary_variable(c.table, label=bin.variable)
        plots_binary[[i]] <- p.binary
    }
    binary_results <- bind_rows(binary_results)

    # quantitative variables
    quantitative_variables <- c("optimal_ph", "optimal_temperature")
    quantitative_variables <- intersect(quantitative_variables, variables)

    quantitative_results <- list()
    plots_quant <- list()

    for (i in 1:length(quantitative_variables)){
        quant.variable <- quantitative_variables[i]
        dat <- get_quantitative_variable(microbe_directory=microbe_directory,
                                   test_set=test_set,
				   background_set=background_set,
				   variable=quant.variable)
        res <- run_wilcoxtest(dat, label=quant.variable)
        quantitative_results[[i]] <- res

        # plot
	p.quant <- plot_quantitative_variable(dat)
        plots_quant[[i]] <- p.quant
    }
    quantitative_results <- bind_rows(quantitative_results)
    plots_results <- c(plots_binary, plots_quant)

    # Produce a single output table with the results
    full_results <- bind_rows(binary_results, quantitative_results)

    # FDR correction
    full_results$qvalue <- p.adjust(full_results$pvalue, method="fdr")
    full_results <- full_results[,c("variable", "test", "statistic", "pvalue", "qvalue")]

    return(list(full_results, plots_results))
}
