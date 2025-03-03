args <- commandArgs(trailingOnly = TRUE)
data <- read.table(args[1])$V1
ks_test <- ks.test(data, "punif")
write.table(ks_test$p.value, file=args[2], row.names=FALSE, col.names=FALSE)

