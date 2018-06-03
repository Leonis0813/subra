#! /usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
install.packages(paste("/tmp", args[1], sep="/"), type="source")
