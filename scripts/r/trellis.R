to_file <- TRUE

# Leitura dos dados de abundância das espécies
matriz <- read.csv("especies.csv", row.names=1)

# Construção da matriz de dados
# utilizando a função data.matrix()
matriz <- data.matrix(matriz)

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica
matriz.log <- log(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função vegdist() do pacote "vegan"
library(vegan)
d <- vegdist(matriz.log,binary=FALSE,method="bray")

# Construção do diagrama de treliça
# utilizando o pacote "pheatmap"
library(pheatmap)
if (to_file) {
  pheatmap(as.matrix(d),col=gray.colors(12),treeheight_row=0,
         treeheight_col=0)
} else {
  pheatmap(as.matrix(d),treeheight_row=0, treeheight_col=0)
}