to_print = TRUE

# Leitura dos dados
dados <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(dados)

# Transformação logarítmica
matriz.log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
library(vegan)
dist <- vegdist(matriz.log, method="bray", binary=FALSE, diag=TRUE)

# Análise de agrupamentos divisiva
# usando a função "diana" do pacote "cluster"
library(cluster)
dv <- diana(dist)
print(dv)
if (to_print) {
  plot(dv, which.plots=2, hang=-1, xlab="", ylab="Distancia de Bray-Curtis", 
     main=paste("DIANA (dv = ", round(dv$dc, digits=4), ")"), sub="", lwd=2)
} else {
  plot(dv, which.plots=2, hang=-1, xlab="", ylab="Distancia de Bray-Curtis", 
       main=paste("DIANA (dv = ", round(dv$dc, digits=4), ")"), sub="", col="blue", lwd=2)
}