#install.packages("rstudioapi")
# run the above line if returns 'there is no package called ‘rstudioapi’'

# build path to the R script where all the functions are stored 
path = paste(dirname(rstudioapi::getSourceEditorContext()$path),'/src/functions.R',sep='')
# source that path
source(path)

## run on full data
full_data()

## run on test data
test_data()

