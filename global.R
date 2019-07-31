list_genes=as.list(read.csv(file="data/gene_list.csv", header = FALSE))
gene_matrix=read.csv(file="data/gene_matrix.csv",row.names = 1)
names(list_genes)="Affected genes"
