#' Wilcoxon rank sum test on quantitative variables
#'
#' Wilcoxon test on quantitative variables
#' between test_set and background_set
#'
#' @param quantitative_variable_dataframe
#' @export
#' @examples
#' run_wilcoxtest(quantitative_variable_dataframe, label="label")

run_wilcoxtest <- function(quantitative_variable_dataframe, label="label"){

    test_values <- quantitative_variable_dataframe[quantitative_variable_dataframe$type=="test_set",][,1]
    background_values <- quantitative_variable_dataframe[quantitative_variable_dataframe$type=="background_set",][,1]
    res <- wilcox.test(test_values, background_values)
    res <- data.frame(statistic=res$statistic, pvalue=res$p.value, test="Wilcoxon rank sum")
    res$variable <- label
    return(res)
    }