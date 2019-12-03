to_print <- TRUE

library(ggplot2)
library(ggrepel)
source("quickplots.R")

# Leitura dos dados
matriz <- read.csv("especies.csv", row.names=1) 

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Análise de componentes principais (modo-Q)
# utilizando a função prcomp() do Sistema R
pca <- prcomp(matriz_log, scale=TRUE, center=TRUE)

# Cálculo da variância explicada pelos componentes
pcavar <- round((pca$sdev^2) / sum((pca$sdev^2)), 3) * 100

# Coeficientes dos autovetores
loadings <- pca$rotation

# Escores dos componentes principais
scores <- pca$x

# Saída dos resultados
print(summary(pca), digits=3)

# Gráfico de declividade
if (to_print) {
  scree <- screeplot(pcavar, xlab="Autovetor", ylab="Variância (%)", color="black")
} else {
  scree <- screeplot(pcavar, xlab="Autovetor", ylab="Variância (%)", color="red")
}
plot(scree)

scores <- as.data.frame(scores)
labels=as.data.frame(rownames(scores))
x = scores[,1]
y = scores[,2]
xlab = paste("PC1 (", pcavar[1], "%)", sep="")
ylab = paste("PC2 (", pcavar[2], "%)", sep="")

# Diagrama de dispersão
if (to_print) {
  scatter <- scatterplot(scores, x, y, xlab=xlab, ylab=ylab, color="black")
} else {
  scatter <- scatterplot(scores, x, y, xlab=xlab, ylab=ylab, color="blue")
}
plot(scatter)