#install.packages("rstudioapi")
# run this above line if returns 'there is no package called ‘rstudioapi’'


#install.packages("rjson")
#run this above line if rjson has not yet been installed

library("rstudioapi")
library("rjson")

# build path to the R script where all the functions are stored
path = paste(dirname(rstudioapi::getSourceEditorContext()$path),
             '/src/methods.R',
             sep = '')
# source that path
source(path)


# run these functions

main = function(targets) {
  
  if ('eda' %in% targets) {
    path = path = paste(dirname(rstudioapi::getSourceEditorContext()$path),
                        "/config",
                        sep = '')
    params = fromJSON(file = "eda-params.json")
    eda_generator(params['data'],params['csv_filename'],params['g1'],params['g2'])
  }
  
  
  if ('methods' %in% targets) {
    path = paste(dirname(rstudioapi::getSourceEditorContext()$path),
                 "/config",
                 sep = '')
    # build path and load data for the first method
    data_fp = fromJSON(file = "methods.json")
    
    path = paste(dirname(rstudioapi::getSourceEditorContext()$path),
                 data_fp['data_fp'],
                 sep = '')
    mootha  = read.table(path, header = TRUE)
    mootha_function(mootha)
    
    
    # build path and load data for the second method
    path2 = paste(dirname(rstudioapi::getSourceEditorContext()$path),
                  data_fp['data_fp2'],
                  sep = '')
    Z = scan(path2)
    Jongho_function(Z)
    
  }
}


if (!interactive()) {
  main(targets)
}

#future functions (aka pipeline)
#FDR_function()
#simulate_function()
#fit_function()


#source('./src/functions.R')
#mootha <- read.table('./src/data/MoothaData.txt')
#Z = scan('./src/data/JonghoZscores.txt')

#mootha_function(mootha)
#Jongho_function(Z)
