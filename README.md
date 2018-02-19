# TD_based_FE
Sample R core used for "Tensor decomposition-based unsupervised feature extraction identifies candidate genes that induce post-traumatic stress disorder-mediated heart diseases" https://doi.org/10.1186/s12920-017-0302-1

1. execute xr_all.R following the instruction in the comments in the file to generate xr_all file.
You need to download GSE68077_RAW.tar from GEO

2. Download class.csv in the current directory and execute tensor.R to generate file Z0 that includes tensor.
x_{i,j_1,j_2,j_3,j_4} corresponds to Z[i,j_1,j_2,j_3,j_4].

3. Execute batch.R in bacth mode, since it takes long time. It genetaes the file HOSVD.
HOSVD$U[[1]] : x_{\ell_5,i} : gene
HOSVD$U[[2]] : x_{\ell_1,j_1} : Control vs Treated
HOSVD$U[[3]] : x_{\ell_2,j_2} : Tissue
HOSVD$U[[4]] : x_{\ell_3,j_3} : stress duration
HOSVD$U[[5]] : x_{\ell_2,j_4} : rest period 

4. Identify which x_{l_5,i} is assocaited with l_1=2 and l_2=4 by investigateing G (core tensor) values

ZZ <-order(-abs(HOSVD$Z@data[,2,4,,]))[1:4];data.frame(arrayInd(ZZ,dim(HOSVD$Z  X1 X2 X3 HOSVD.Z.data...2..4......ZZ.])
1 11  1  1                    -34.92058
2  1  1  1                    -30.34751
3  1  2  2                    -30.30752
4  4  2  3                    -29.97348

Then we know that l_5=,1,4,11 are associated with l_1=2 and l_2=4

5. Assign P-values to genes i and select gene using adjusted P-values.

P <- pchisq(rowSums(scale(HOSVD$U[[1]][,c(1,4,11)])^2),3,lower.tail=F)
table(p.adjust(P,"BH")<0.01)

FALSE  TRUE 
42896   803 
