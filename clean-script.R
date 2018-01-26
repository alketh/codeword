# load("data/dummy_script.rda", verbose = T)
# script <- dummy_script

clean_script <- function(script) {
  # Remove lines with comments
  pos <- stringr::str_locate(script, pattern = "#")[, 1]
  pos <- which(pos == 1)
  
  cs <- script
  if (length(pos) >= 1) cs <- script[-pos]
  
  # Extract code language using the tokenizer Package
  out <- tokenizers::tokenize_words(cs)
  
  # Do some cleaning
  out <- out[vapply(out, length, FUN.VALUE = integer(1)) != 0]
  return(unlist(out))
}