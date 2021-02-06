chooseCRANmirror()

install.packages("wordcloud")

library(tm)
library(XML)
library(SnowballC)
library(NLP)
library(slam)

rm(list=ls(all=TRUE))

doc <- Corpus(x, readerControl)
doc1 <- Corpus(DirSource("Datatest2016"))

ovid<- system.file("texts", "txt", package = "tm")
ovidCorpus<- Corpus(DirSource(ovid), readerControl = list(reader = readPlain))
inspect(ovidCorpus)

docs <- c("This is a text.", "This another one.")
corpus1<-Corpus(VectorSource(docs))

reut21578 <- system.file("texts", "crude", package = "tm")
reuters <- Corpus(DirSource(reut21578),readerControl = list(reader = readReut21578XML))


inspect(doc1)
class(doc1)
class(doc1[[1]])
summary(doc1)
writeLines(as.character(doc1[[2]]))

inspect(reuters[[1]])
inspect(ovidCorpus)
summary(ovidCorpus)
writeLines(as.character(ovidCorpus[[1]]))
ovidCorpus[[2]]
writeLines(as.character(reuters[[1]]))
writeLines(as.character(corpus1[[1]]))

writeLines(as.character(reuters[[1]]))
reuters2 <- tm_map(reuters, PlainTextDocument)

reuters3 <- tm_map(reuters2, content_transformer(tolower))
writeLines(as.character(reuters3[[1]]))

reuters4 <- tm_map(reuters3, removeNumbers)
writeLines(as.character(reuters4[[1]]))

reuters5 <- tm_map(reuters4, removePunctuation)
writeLines(as.character(reuters5[[1]]))

reuters6<- tm_map(reuters5, removeWords, stopwords("english"))
writeLines(as.character(reuters6[[1]]))

mondico <- c( "crude", "oil")
Doc1RW <- tm_map(reuters5, removeWords, mondico)

Doc1RW2 <- tm_map(reuters5, removeWords, c("prices"))

reuters7 <- tm_map(reuters6, stemDocument)
writeLines(as.character(reuters7[[1]]))

reuters8<- tm_map(reuters7, stripWhitespace)
writeLines(as.character(reuters8[[1]]))

dtm0 <- DocumentTermMatrix(reuters2)
inspect(dtm0[5:10, 740:743])
class(dtm0)
dim(dtm0)

mondico <- c("prices", "crude", "oil")
dtm<-DocumentTermMatrix(reuters8, list(dictionary = c("prices", "crude", "oil") ))
dtm_mondico

inspect(removeSparseTerms(dtm, 0.4))
dtmsparse<- removeSparseTerms(dtm, 0.05)
dtmsparse
dtm2<- removeSparseTerms(dtm, 0.7)


library(ggplot2)
library(wordcloud)

freq <-colSums(as.matrix(dtm2))
length(freq)
ord <- order(freq)
freq[head(ord)]
freq[tail(ord)]
head(table(freq),k)
tail(table(freq),15)
freq <- sort(colSums(as.matrix(dtm2)), decreasing=TRUE)
head(freq, 14)
wf <- data.frame(word=names(freq), freq=freq)
head(wf)
