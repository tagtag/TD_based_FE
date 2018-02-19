#Download GSE68077_RAW.tar from https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE68077
#untar GSE68077_RAW.tar in the curret directory.
#there should be 346 files 
files <- list.files(,pattern="*.gz")
xr_all <- NULL
for (i in c(1:length(files)))
{
cat(i, " ")
x <- read.csv(files[i],sep="\t",skip=9)
xr_all <- cbind(xr_all,x$rProcessedSignal)
}
save(file="xr_all_org",xr_all)
