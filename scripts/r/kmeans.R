to_print <- TRUE

# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1) 

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função "vegdist" do pacote "vegan"
library(vegan)
dist <- vegdist(matriz_log, method="bray") 

# Análise de agrupamentos divisiva
# usando a função "means" do pacote "stats"
cl <- kmeans(dist, centers=2, nstart=8)

# Saída dos resultados
print(cl)

# Diagrama de dispersão
if (to_print) {
  plot(cl$centers[1,], cl$centers[2,], pch=18:19, xlab="Distancia", ylab="Distancia", 
       main=paste("Compactness = ", round(cl$betweenss/cl$totss*100.0, digits=1), "%"))
  text(cl$centers[1,], cl$centers[2,], labels=rownames(matriz), cex=0.5, pos=4)
  } else {
    plot(cl$centers[1,], cl$centers[2,], col=cl$cluster, pch=19, xlab="Distancia", ylab="Distancia", 
         main=paste("Compactness = ", round(cl$betweenss/cl$totss*100.0, digits=1), "%"))
  text(cl$centers[1,], cl$centers[2,], labels=rownames(matriz), cex=0.5, pos=3)
}

# Análise de agrupamentos não-hierárquica
# usando a função "pam" do pacote "cluster"
library(cluster)
pamx <- pam(dist, 2, diss=TRUE)
print(summary(pamx))
plot(pamx, main="")
kmcol <- pamx$clustering