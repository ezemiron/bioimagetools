\name{segment}
\alias{segment}
\title{Segmentation of 3D images using EM algorithms}
\description{
Segmentation of 3D images using EM algorithms
}
\usage{
segment(img, nclust, beta, z.scale=0, method="cem", varfixed=TRUE, maxit=30, mask=array(TRUE,dim(img)), priormu=rep(NA,length(nclust)), priormusd=rep(NULL,length(nclust)), min.eps=10^{-7} ) }
\arguments{ 
  \item{img}{is a 3d arrary representing an image.}
  \item{nclust}{is the number of clusters/classes to be segmented.}
  \item{beta}{is a matrix of size nclust x nclust, representing the prior weight of classes neighbouring each other.}
  \item{z.scale}{ratio of voxel dimension in x/y direction and z direction. Will be multiplied on beta for neighbouring voxel in z direction.}
  \item{method}{only "cem" classification EM algorithm implemented.}
  \item{varfixed}{is a logical variable. If TRUE, variacne is equal in each class.}
  \item{maxit}{is the maximum number of iterations.}
  \item{mask}{is a logical array, representing the voxels to be used in the segmentation.}
  \item{priormu}{is a vector with mean of the normal prior of the expected values of all classes. Default is NA, which represents no prior assumption.}
  \item{priormusd}{is a vector with standard deviations of the normal prior of the expected values of all classes.}
  \item{inforce.nclust}{if TRUE enforces number of clusters to be nclust. Otherwise classes might be removed during algorithm.}
  \item{min.eps}{stop criterion. Minimal change in sum of squared estimate of mean in order to stop.}
}
\value{
 A list with "class": 3d array of class per voxel; "mu" estimated means; "sigma": estimated standard deviations. 
}
\examples{
original<-array(1,c(300,300,50))
for (i in 1:5)original[(i*60)-(0:20),,]<-original[(i*60)-(0:20),,]+1
for (i in 1:10)original[,(i*30)-(0:15),]<-original[,(i*30)-(0:15),]+1
original[,,26:50]<-4-aperm(original[,,26:50],c(2,1,3))

img<-array(rnorm(300*300*50,original,.2),c(300,300,50))
img<-img-min(img)
img<-img/max(img)

beta<-matrix(rep(-.5,9),nrow=3)
beta<-beta+1.5*diag(3)

seg.img<-segment(img,3,beta,z.scale=.3)

print(sum(seg.img$class!=original)/prod(dim(original)))

if (require(EBImage))display(seg.img$class/3)
}
\author{Volker J. Schmid \email{volkerschmid@users.sourceforge.net}}


