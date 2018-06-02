args = commandArgs(trailingOnly=T)
install.packages(paste("/tmp", args[1], sep="/"), type="source")
