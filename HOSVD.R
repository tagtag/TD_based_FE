load("Z0")
require(rTensor)
HOSVD <- hosvd(as.tensor(Z0))
save(file="HOSVD",HOSVD)
