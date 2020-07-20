#Functions for plotting ions (LTER)
#df = dataframe
#ion = ion
#axislabel = "ion concentration"
ion <- function(df, ion, axislabel) {
  ggplot(df, aes(sampledate, ion)) +
    geom_point() +
    labs(x = "",
         y = axislabel)
}
