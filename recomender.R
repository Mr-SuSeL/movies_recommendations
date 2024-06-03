library(dplyr)
library(ggplot2)
library(tidyr)
library(cluster)
setwd("C:\Users\susel\OneDrive\Pulpit\UczenieMaszynowe_lab\Recomendations_Movies\movies_recomendations\recomender.R")

ratings = read.csv("10K/ratings.csv", sep = ";") # user_id	movie_id	rating	timestamp
movies = read.csv("10K/movies.csv", sep = ";") # movie_id	title	 genre[1-7]
users = read.csv("10K/users.csv", sep = ";") # user_id	timestamp

# deleting timestamp
ratings <- ratings[,-4]

#install.packages("reshape2", dependencies=TRUE)
#install.packages("stringi", dependencies=TRUE)
library(stringi)
library(reshape2)

