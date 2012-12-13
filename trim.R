trimDHS <- function(data, npercent){
  range <- c(0.5 - npercent/2, 0.5 + npercent/2)
  uni <- seq(from=as.numeric(data[2]), to=as.numeric(data[3]), 1)
  trim.quantile <- quantile(uni, probs=range)
  as.vector(trim.quantile)
}
