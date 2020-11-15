#Breakdown steps can be found in eda.Rmd
#Install the following packages if have not been done yet

#install.packages("psych",dependencies=TRUE)
#install. packages("tidyr")
#install. packages("dplyr")

library(psych)
library(tidyr)
library(dplyr)


scatter_matrix_function = function(dataset,g1,g2){
  data = read.table(dataset)
  s2 = sample(g2, 2, replace=FALSE)
  sm_sample = c(s1,s2)
  pairs.panels(data[,sm_sample], 
               method = "pearson", # correlation method
               hist.col = "#00AFBB",
               density = TRUE,  # show density plots
               ellipses = TRUE # show correlation ellipses
  )
  
}

stat_summary = function(dataset,csv_filename,g1,g2){
  data = read.table(dataset)
  data_long <- gather(data, factor_key=TRUE)
  
  summarydf <- data_long %>% group_by(key) %>%
    summarize(mean= mean(value), sd= sd(value), max = max(value),min = min(value))
  
  write.csv(summarydf, filename=csv_filename)
  
  g1_stat = apply(summarydf[g1,2:5],2,mean)
  g2_stat = apply(summarydf[g2,2:5],2,mean)
  
  group_stat = data.frame(g1_stat,g2_stat)
  
  return(group_stat)
}

eda_generator = funtion(data,csv_filename,g1,g2){
  
  scatter_matrix_function(dataset,g1,g2)
  stat_summary(dataset,csv_filename,g1,g2)
  
}