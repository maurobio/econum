to_print <- TRUE

# Leitura dos dados
dados <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(dados)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função "vegdist" do pacote "vegan"
library(vegan)
dist <- vegdist(matriz_log, method="bray")

# Análise de coordenadas principais
# utilizando a função "cmdscale" do Sistema R
pco <- cmdscale(dist, k=2, eig=TRUE)

# Soma dos autovalores positivos
pcovar <- pco$eig / sum(pco$eig[pco$eig > 0])

# Diagrama de dispersão
#plot(pco$points, main="PCO",
#     xlab=paste("PC1 (", round(pcovar[1], 3)*100, "%)", sep=""), 
#     ylab=paste("PC2 (", round(pcovar[2], 3)*100, "%)", sep=""),
#     pch=19)
#text(pco$points[,1:2], labels=rownames(pco$points), pos=3, cex=0.7)

scores <- as.data.frame(pco$points)
x = pco$points[,1]
y = pco$points[,2]
xlab = paste("Eixo 1 (", round(pcovar[1], 3)*100, "%)", sep="")
ylab = paste("Eixo 2 (", round(pcovar[2], 3)*100, "%)", sep="")
source("quickplots.R")
if (to_print) {
  scatter <- scatterplot(scores, x, y, xlab=xlab, ylab=ylab)
} else {
  scatter <- scatterplot(scores, x, y, xlab=xlab, ylab=ylab, col="blue")
}
plot(scatter)

# Árvore de conexão mínima
#mst <- spantree(dist)
#plot(mst, pco, type="t")