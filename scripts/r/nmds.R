to_print <- TRUE

# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(matriz)

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função "vegdist" do pacote "vegan"
library(vegan)
dist <- vegdist(matriz, method="bray") 

# Escalonamento multidimensional não-métrico
# usando a função "isoMDS" do pacote "MASS"
library(MASS)
#fit <- isoMDS(dist, k=2) # k é o número de dimensões
# Também pode ser utilizada a função metaMDS() 
# do pacote "vegan"
#fit <- metaMDS(dist, k=2, engine="monoMDS")

# Obtenção da solução inicial a partir da análise de coordenadas principais
fit.null <- isoMDS(dist, k=2, tol=1e-7)

# Iterações para maximizar o ajuste
# utilizando a função "initMDS" do pacote "vegan"
repeat{
  fit <- isoMDS(dist, initMDS(dist), maxit=200, trace=FALSE, tol=1e-7)
  if(fit$stress < fit.null$stress) break
}

# Escalonamento das soluções
# utilizando a função "postMDS" do pacote "vegan"
fit.null <- postMDS(fit.null, dist)
fit <- postMDS(fit, dist)

# Saída dos resultados
print(fit)

# Diagrama de dispersão
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