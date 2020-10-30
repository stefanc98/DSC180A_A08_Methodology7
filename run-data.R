#install.packages("rstudioapi")
# run the above line if returns 'there is no package called ‘rstudioapi’'

# build path to the R script where all the functions are stored 
path = paste(dirname(rstudioapi::getSourceEditorContext()$path),'/src/functions.R',sep='')
# source that path
source(path)

# build path to Mootha Dataset
path = paste(dirname(rstudioapi::getSourceEditorContext()$path),'/src/data/MoothaData.txt',sep='')
mootha  = read.table(path,header=TRUE)
# build path to Jongho Dataset
path = paste(dirname(rstudioapi::getSourceEditorContext()$path),'/src/data/JonghoZscores.txt',sep='')
Z = scan(path)

# run these functions
mootha_function(mootha)
Jongho_function(Z)






#source('./src/functions.R')
#mootha <- read.table('./src/data/MoothaData.txt')
#Z = scan('./src/data/JonghoZscores.txt')

#mootha_function(mootha)
#Jongho_function(Z)
