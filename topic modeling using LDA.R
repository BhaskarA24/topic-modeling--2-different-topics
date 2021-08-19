## text Analytics
library(tm)
library(SnowballC)
library(topicmodels)
library(wordcloud)


####set the working directory (modify path as needed)
setwd("C:\\Users\\admin\\Desktop\\topic modeling")

# load files into corpus
# get listing of.txt files in directory
filenames <- list.files(getwd(),pattern = "*.txt")
#read files into a character vector
files <- lapply(filenames,readLines)
str(files)
# create corpus from vector
article.corpus <- Corpus(VectorSource(files))

## text preprocessing
## make each letter lowercase
article.corpus <- tm_map(article.corpus, tolower)
# remove punctuation
article.corpus <- tm_map(article.corpus, removePunctuation)
# remove numbers 
article.corpus <- tm_map(article.corpus, removeNumbers)
# remove generic and custom stopwords
stopwords()
stopwords <- c(stopwords('english'),"best")
article.corpus <-tm_map(article.corpus,
                        removeWords,stopwords)
article.corpus <- tm_map(article.corpus, stemDocument)
wordcloud(article.corpus)


#create DTM
articleDtm <- DocumentTermMatrix(article.corpus,control = list(minWordLength = 3));
articleDtm2 <- removeSparseTerms(articleDtm, sparse = 0.98)

#topic modeling
# latent dirichlet alloocation (LDA) models are a widely used topic modeling technique.
k = 5   # no of clusters 
SEED = 1234
article.lda <-LDA(articleDtm2,k, method = "Gibbs", control = list(seed = SEED))
lda.topics <- as.matrix(topics(article.lda))
lda.topics
lda.terms <- terms(article.lda)
lda.terms

