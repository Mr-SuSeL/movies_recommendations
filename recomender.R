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

# Create ratings matrix with rows as users and columns as movies
# ratingmat = dcast(ratings, user_id ~ movie_id, value.var = "rating", na.rm=FALSE)
ratingmat = dcast(ratings, user_id ~ movie_id, value.var = "rating")

# We can now remove user ids
ratingmat = as.matrix(ratingmat[,-1]) #sparse matrix

# let's choice to calculate similarity according to the cosine similarity method
install.packages("recommenderlab", dependencies=TRUE)
library(recommenderlab)

# removing zeros
#Convert ratings matrix to real rating matrix which makes it dense
ratingmat = as(ratingmat, "realRatingMatrix") # broken

#Normalize the ratings matrix
ratingmat = normalize(ratingmat) # broken

#Create Recommender Model. The parameters are UBCF and Cosine similarity. We take 10 nearest neighbours
rec_mod = Recommender(ratingmat, method = "UBCF", param=list(method="Cosine",nn=10)) 











