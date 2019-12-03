# Leitura dos dados
dados <- read.csv("especies.csv", row.names=1) #header = TRUE)

# Construção da matriz de dados
matriz <- as.data.frame(dados)

# Transposição da matriz de dados
#matriz <- t(matriz)

# Transformação logarítmica
matriz.log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
#library(vegan)
#dist <- vegdist(matriz.log, method="bray", binary=FALSE, diag=TRUE)

# Teste de significância dos agrupamentos
#library(fpc)
#set.seed(20000)
#cf <- clusterboot(dist, 
#                  B=100, 
#                  distances=TRUE, 
#                  bootmethod="boot",
#                  clustermethod=disthclustCBI,
#                  k=2, cut="number", method="average",
#                  showplots=FALSE,
#                  seed=15555)
#print(cf)
#plot(cf)

library(pvclust)
result <- pvclust(matriz.log, method.dist="euclidean", method.hclust="average", nboot=1000)
plot(result)
pvrect(result, alpha=0.95)