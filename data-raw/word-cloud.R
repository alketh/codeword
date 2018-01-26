library("purrr")
library("magrittr")
library("wordcloud2")
library("dplyr")

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

# Remove single character words and numeric values!
words <- words[stringr::str_length(words) != 1]
words <- words[!grepl(pattern = "[0-9]", x = words)]
words <- words[words != "wuwu"]
words <- words[words != "species"]

# Remove words with count of cutoff and less
cutoff <- 20

agg_words <- data.frame(words = words) %>% 
  group_by(words) %>% 
  summarise(count = n()) %>% 
  filter(count > cutoff) %>% 
  arrange(desc(count))

pdf(file = "test.pdf")
wordcloud2(agg_words, color = "random-dark")
dev.off()
