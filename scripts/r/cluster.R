to_print <- TRUE

# Leitura dos dados
dados <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(dados)

# Transformação logarítmica
matriz.log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
library(vegan)
dist <- vegdist(matriz.log, method="bray", binary=FALSE, diag=TRUE)
#dist <- vegdist(trans, method="jaccard", binary=TRUE, diag=TRUE)

# Análise de agrupamentos, 
# cálculo da correlação cofenética 
# e construção do dendrogama

# Ligação simples
hc <- hclust(dist, method = "single")
dc <- cophenetic(hc)
r_slm <- cor(dist, dc)
#plot(ggdendrogram(hc, rotate = TRUE, theme_dendro = TRUE))
if (to_print) {
  plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("SLM (r = ", format(r_slm, digits=4), ")"), horiz=TRUE, edgePar=list(col="black", lwd=2))
} else {
  plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("SLM (r = ", format(r_slm, digits=4), ")"), horiz=TRUE, edgePar=list(col="blue", lwd=2))
}

# Ligação completa
hc <- hclust(dist, method = "complete")
dc <- cophenetic(hc)
r_clm <- cor(dist, dc)
if (to_print) {
  plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("CLM (r = ", format(r_clm, digits=4), ")"), horiz=TRUE, edgePar=list(col="black", lwd=2))
} else {
  plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("CLM (r = ", format(r_clm, digits=4), ")"), horiz=TRUE, edgePar=list(col="blue", lwd=2))
}
  
# Média ponderada
hc <- hclust(dist, method = "mcquitty")
dc <- cophenetic(hc)
r_wpgma <- cor(dist, dc)
if (to_print) {
plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("WPGMA (r = ", format(r_wpgma, digits=4), ")"), horiz=TRUE, edgePar=list(col="black", lwd=2))
} else {
  plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("WPGMA (r = ", format(r_wpgma, digits=4), ")"), horiz=TRUE, edgePar=list(col="blue", lwd=2))
}

# Média não-ponderada
hc <- hclust(dist, method = "average")
dc <- cophenetic(hc)
r_upgma <- cor(dist, dc)
if (to_print) {
plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("UPGMA (r = ", format(r_upgma, digits=4), ")"), horiz=TRUE, edgePar=list(col="black", lwd=2))
} else {
  plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("UPGMA (r = ", format(r_upgma, digits=4), ")"), horiz=TRUE, edgePar=list(col="blue", lwd=2))
}

# Método de Ward
hc <- hclust(dist, method = "ward.D2")
dc <- cophenetic(hc)
r_ward <- cor(dist, dc)
if (to_print) {
plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("Ward (r = ", format(r_ward, digits=4), ")"), horiz=TRUE, edgePar=list(col="black", lwd=2))
} else {
  plot(as.dendrogram(hc), xlab="Distancia de Bray-Curtis", ylab="", main=paste("Ward (r = ", format(r_ward, digits=4), ")"), horiz=TRUE, edgePar=list(col="blue", lwd=2))
}