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
#install.packages("recommenderlab", dependencies=TRUE)
library(recommenderlab)

# removing zeros
#Convert ratings matrix to real rating matrix which makes it dense
ratingmat = as(ratingmat, "realRatingMatrix") 

#Normalize the ratings matrix
ratingmat = normalize(ratingmat) 

#Create Recommender Model. The parameters are UBCF and Cosine similarity. We take 10 nearest neighbours
rec_mod = Recommender(ratingmat, method = "UBCF", param=list(method="Cosine",nn=10)) 

# Prediction module:
# Obtain top 5 recommendations for 7th user entry in dataset
Top_5_pred = predict(rec_mod, ratingmat[7], n=5)

#Convert the recommendations to a list
Top_5_List = as(Top_5_pred, "list")

#We convert the list to a dataframe and change the column name to movieId
#Top_5_df=data.frame(Top_5_List)
#colnames(Top_5_df)="movieId"
Top_5_df=data.frame(Top_5_List)
colnames(Top_5_df)="movie_id"


#Since movieId is of type integer in Movies data, we typecast id in our recommendations as well
Top_5_df$movie_id=as.numeric(Top_5_df$movie_id)


#install.packages("tidytable")
#library(tidytable)
#Merge the movie ids with names to get titles and genres
#names=left_join(Top_5_df, movies, by="movieId")
names=left_join(Top_5_df, movies, by="movie_id")
# Problem with data typing integer of movies dataset vs character Top_5_df resolved

#Print the titles and genres
names <- names[ ,-2]
names



























