# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1) 

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Definição dos grupos
groups <- as.factor(c(1,1,1,1,2,2,2,2))

# Análise de similaridade usando a função
# anosim() do pacote "vegan"
library(vegan)
ano <- anosim(matriz_log, groups, permutations=9999)

# Saída dos resultados
print(summary(ano))
#plot(ano)

source("quickplots.R")
#p <- boxplot(as.data.frame(matriz), ano$class.vec, ano$dis.rank)
#print(p)
if (ano$permutations) {
    pval <- format.pval(ano$signif)
} else {
    pval <- "not assessed"
}
box <- boxplot(ano$dis.rank, ano$class.vec, fill=ano$class.vec,
        main=paste("R = ", round(ano$statistic, 3), ", ", "P = ", pval ))
plot(box)