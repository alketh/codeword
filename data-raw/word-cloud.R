library("purrr")
library("magrittr")

# Let's create a word cloud using most of the available scripts
dirs <- c("h:\\C\\phd\\atlantistools\\R\\",
          "h:\\C\\phd\\ecocat\\R\\" ,
          "H:\\C\\phd\\gettingandcleaning" ,
          "H:\\C\\phd\\indperform\\INDperform\\R",
          "H:\\C\\phd\\noaa-storm",
          "H:\\C\\phd\\r-programming",
          "H:\\C\\phd\\seriespicker\\R",
          "H:\\Z\\R_codes\\gns-data-input",
          "H:\\Z\\R_codes")

# Get all R files!
files <- map(dirs, list.files, pattern = "\\.R", full.names = T) %>% 
  flatten_chr()

# Remove .Rmd files and .RCheck files
files <- files[!grepl(pattern = "\\.Rmd", files)]
files <- files[!grepl(pattern = "\\.Rcheck", files)]

scripts <- map(files, readLines)

nlines <- map_int(scripts, length) %>% 
  sum()

words <- map(scripts, clean_script) %>% 
  unlist()



