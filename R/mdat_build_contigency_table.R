#' Build contigensy table for binary variable
#'
#' This function reads data frame of binary variable
#' and returns a contigency table for input into
#' chi-squared test
#'
#' @param binary_variable_dataframe
#' @export
#' @examples
#' build_contingency_table(binary_variable_dataframe)

build_contingency_table <- function(binary_variable_dataframe){

    ct <- table(binary_variable_dataframe[,1], binary_variable_dataframe[,2])
    return(ct)
    }