#' Get a quantititative variable from microbe directory
#'
#' This function returns a dataframe of one of the quantitative
#' variable from the microbe directory for each of the test_set
#' and background set
#'
#' @param database test_set background_set
#' @export
#' @examples
#' get_quantitative_variable(microbe_directory=microbe_directory, test_set=test_set, background_set=background_set, variable="optimal_ph")

get_quantitative_variable <- function(microbe_directory=microbe_directory,
                                      test_set=test_set,
				      background_set=background_set,
				      variable="optimal_ph"){

    if (!(variable %in% c("optimal_ph", "optimal_temperature"))){
        stop(paste0("There is no quantitative variable '", variable, "' in The Microbe Directory"))
    }

    test_set_variable <- data.frame(microbe_directory[test_set, variable])
    test_set_variable$type <- "test_set"
    colnames(test_set_variable) <- c(variable, "type")

    background_set_variable <- data.frame(microbe_directory[background_set, variable])
    background_set_variable$type <- "background_set"
    colnames(background_set_variable) <- c(variable, "type")

    dat <- data.frame(rbind(test_set_variable, background_set_variable))

    cat("Removing rows with no data...\n")
    dat <- na.omit(dat)
    return(dat)
    }