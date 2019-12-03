to_print <- TRUE

# Leitura dos dados
matriz <- read.csv("especies.csv", row.names=1)

# Construção da matriz de dados
#matriz <- as.data.frame(dados)

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função "vegdist" do pacote "vegan"
library(vegan)
dist <- vegdist(matriz, method="bray") 

# Escalonamento multidimensional não-métrico
# usando a função "isoMDS" do pacote "MASS"
library(MASS)
fit <- isoMDS(dist, k=2) # k é o número de dimensões
# Também pode ser utilizada a função metaMDS() 
# do pacote "vegan"
#fit <- metaMDS(dist, k-2, engine="monoMDS")

# Saída dos resultados
print(fit)

# Diagrama de dispersão
#x <- fit$points[,1]
#y <- fit$points[,2]
#plot(x, y, xlab="Dim 1", ylab="Dim 2",
#     main=paste("NMDS (stress=", format(fit$stress, digits=3), ")"), pch=19)
#text(x, y, labels=rownames(fit$points), pos=1, cex=0.7)
scores <- as.data.frame(fit$points)
x = fit$points[,1]
y = fit$points[,2]
xlab = "Dimensão 1"
ylab = "Dimensão 2"
source("quickplots.R")
if (to_print) {
  scatter <- scatterplot(scores, x, y, main=paste("Stress = ", format(fit$stress, digits=4), sep=""), xlab=xlab, ylab=ylab)
} else {
  scatter <- scatterplot(scores, x, y, main=paste("Stress = ", format(fit$stress, digits=4), sep=""), xlab=xlab, ylab=ylab, col="blue")  
}
plot(scatter)