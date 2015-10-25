# Hierarchical Clustering
# Can we find things that are close together?
"
Clustering organizes things that are close into groups
- how do we define close?
- how do we group things?
- how do we visualize the grouping?
- how do we interpret the grouping?
"

# Hierarchical clustering
"
An agglomerative approach (bottom-up)
- find closest two things
- put them together
- find next closest
Requires:
- a defined distance
- a merging approach
Produces:
- a tree showing how close things are to each other
"

# How do we define close?
"
Most important step
- garbage in -> garbage out
Distance or similarity
- continuous - euclidian distance
- countinuous - correlation similarity
- binary - manhattan distance
Pick a distance / similarity that makes sense for your problem
"

# Hierarchical Clustering Part 2
# Hierarchical clustering - example
set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12, mean=rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1),each=4), sd=0.2)
plot(x, y, col="blue", pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))

# Hierarchical clustering - dist
# important parameters: x, method (optional)
"
takes a data frame to calculate the distance between all rows
"
dataFrame <- data.frame(x=x, y=y)
dist(dataFrame) # defaults to euclidian distance

# Hierarchical clustering - hclust (cluster dendogram)
dataFrame <- data.frame(x=x, y=y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)

# Hierarchical Clustering Part 3
# Merging points - complete
"
Average linkage: the new point it the average / mid-way position between the two clusters
Complete linkage: take the farthest two points, each from the two clusters, as the distance
"

# heatmap()
dataFrame <- data.frame(x=x,y=y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
heatmap(dataMatrix)

# K-Means Clustering
# Can we find things that are close together?
# How do we define close?

# K-means clustering
"
A partitioning approach
- fix a number of clusters
- get centroids of each cluster
- assign things to closest centroid
- recalculate centroids

Requires:
- a defined distance metric
- a number of clusters
- an initial guess as to cluster centroids

Produces:
- final estimate of cluster centroids
- an asignment of each point to clusters
"

# K-means clustering - example
set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12, mean=rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2)
plot(x,y,col="blue", pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))

# K-Means Clustering Part 2
# kmeans()
"
important parameters: x, centers, iter.max, nstart
"
dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame, centers =3)
names(kmeansObj)
"
[1] "cluster"      "centers"      "totss"        "withinss"    
[5] "tot.withinss" "betweenss"    "size"         "iter"        
[9] "ifault"     
"
kmeansObj$cluster
" [1] 3 3 3 3 1 1 1 1 2 2 2 2"

par(mar=rep(0.2,4))
plot(x,y,col=kmeansObj$cluster, pch=19, cex=2)
points(kmeansObj$centers, col = 1:3, pch=3, cex=3, lwd=3)

# Heatmaps
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj2 <- kmeans(dataMatrix, centers=3)
par(mfrow=c(1,2),mar=c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt="n") # plot of the original data
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt="n") # sorted by cluster

# Notes
"
K-means requires a number of clusters
- pick by eye / intuition
- pick by cross validation / information theory, etc.

K-means is not deterministic
- different # of clusters
- different number of iterations
"

# Dimension Reduction Part 1
# Principal Components Analysis and Singular Value Decomposition
# Matrix data - not so interesting version
set.seed(12345)
par(mar=rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow=40)
image(1:10, 1:40, t(dataMatrix)[,nrow(dataMatrix):1])

# Cluster the data - still not interesting
par(mar=rep(0.2, 4))
heatmap(dataMatrix)

# What if we add a pattern?
set.seed(678910)
for (i in 1:40) {
  # flip a coin
  coinFlip <- rbinom(1, size = 1, prob = 0.5)
  # if coin is heads add a common pattern to that row
  if (coinFlip) {
    dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3),each=5)
  }
}

par(mar=rep(0.2,4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])

# What if we add a pattern? - the clustered data
par(mar=rep(0.2, 4))
heatmap(dataMatrix)

# Patterns in rows and columns
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab="Row Mean", ylab = " Row", pch=19)
plot(colMeans(dataMatrixOrdered), xlab="Column", ylab = " Column Mean", pch=19)

# Singular Variable Decomposition (SVD)
"
If X is a matrix with each variable in a column and each observation in a row
then the SVD is a matrix decomposition
X = UDV^T
where the columns of U are orthogonal (left singular vectors), the columns of V are orthogonal (right
singular vectors) and D is a diagonal matrix (singular values)
"

# Principal Components Analysis (PCA)
"
The principal components are equal to the right singular values if you first scale (subtract the mean,
divide by the standard deviation) the variables
"

# Dimension Reduction Part 2
# Components of the SVD - u and v
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1,,xlab="Row",ylab="First left singular vector",pch=19)
plot(svd1$v[,1],xlab="Column",ylab="First right singular vector",pch=19)

# Components of the SVD - variance explained
par(mfrow = c(1,2))
plot(svd1$d, xlab="Column", ylab="Singular value", pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)

# Relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale=TRUE)
plot(pca1$rotation[,1],svd1$v[,1],pch=19,xlab="Principal Component 1",
     ylab="Right Singular Vector 1")
abline(c(0,1))

# Components of the SVD - vraiance explained
constantMatrix <- dataMatrixOrdered * 0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1),each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)

# What if we add a second pattern?
set.seed(678910)
for (i in 1:40){
  # flip a coin
  coinFlip1 <- rbinom(1,size=1,prob=0.5)
  coinFlip2 <- rbinom(1,size=1,prob=0.5)
  # if coin is heads add a common pattern to that row
  if (coinFlip1) {
    dataMatrix[i,]<- dataMatrix[i,]+rep(c(0,5),each=5)
  }
  if(coinFlip2) {
    dataMatrix[i,] <- dataMatrix[i,]+rep(c(0,5),5)
  }
}
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]

# Singular value decomposition - true patterns
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rep(c(0,1),each=5),pch=19,xlab="Column",ylab="Pattern 1")
plot(rep(c(0,1),5),pch=19,xlab="Column",ylab="Pattern 2")

# v and patterns of variance in rows
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd2$v[,1],pch=19,xlab="Column",ylab="First right singular vector")
plot(svd2$v[,2],pch=19,xlab="Column",ylab="Second right singular vector")

# d and variance explained
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,2))
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Percent of variance explained", pch=19)

# Dimension Reduction Part 3
# Missing values
dataMatrix2 <- dataMatrixOrdered
## randomly insert some missing data
dataMatrix2[sample(1:100, size=40, replace=FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2)) ## doesn't work!

# Imputing {impute}
# Available from http://bioconductor.org
library(impute)
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100, size=40, replace=FALSE)] <- NA
dataMatrix2 <- impute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrixOrdered)); svd2 <- svd(scale(dataMatrix2))
par(mfrow=c(1,2)); plot(svd1$v[,1],pch=19);plot(svd2$v[,1],pch=19)