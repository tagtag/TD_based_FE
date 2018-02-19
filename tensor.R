load("xr_all")
xr_all[is.na(xr_all[,-1]),-1]<-0
y <- read.csv("class.csv",header=F,sep="\t")
class<- t(data.frame(lapply(strsplit(as.character(y[,2]),"_"),"[",1:4)))
class0 <- paste(class[,1],class[,2],class[,3],class[,4])
class0[1:3] <- substring(class0[1:3],1,12)
class0[124:128]<- substring(class0[124:128],1,16)
label <- t(data.frame(strsplit(class0," ")))
rownames(label)<- NULL


Z <- lapply(split(data.frame(t(scale(xr_all[,-1]))),paste(label[,1],label[,2],label[,3],label[,4])),colMeans)

Z0 <- array(NA, c(dim(xr_all)[1],dim(table(label[,1])),dim(table(label[,2])),dim(table(label[,3])),dim(table(label[,4]))))
for (i in c(1:dim(table(label[,1])))) 
{
cat("\n",i," ")
for (j in c(1:dim(table(label[,2])))) 
{
cat(j, " ")
for (l in c(1:dim(table(label[,3])))) 
{
cat(l, " ")
for (m in c(1:dim(table(label[,4])))) 
{
cat(m, " ")
k<-grep(paste(names(table(label[,1]))[i],names(table(label[,2]))[j],names(table(label[,3]))[l],names(table(label[,4]))[m]),names(Z))
if(length(k)>0)
{
Z0[,i,j,l,m]<-Z[[k]]
}
}
}
}
}
Z0[is.na(Z0)]<-0
save(file="Z0",Z0)
