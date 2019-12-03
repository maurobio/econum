to_print <- TRUE

# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1) 
variaveis <- read.csv("variaveis.csv", row.names=1)

# Transformação logarítmica
variaveis.log <- log1p(variaveis)

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica
matriz.log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis entre as amostras
library(vegan)
dist <- vegdist(matriz.log, method="bray", binary=FALSE, diag=TRUE)

# Obtanção dos grupos pela análise de agrupamentos
gr <- cutree(hclust(dist, method="average"), 3)

# Análise discriminante linear
# por meio da função lda() do pacote "MASS"
library(MASS)
model <- lda(gr~., data=variaveis.log)
print(model)

prop = model$svd^2/sum(model$svd^2)
var <- round((model$svd^2) / sum((model$svd^2)), 2) * 100

Fp <- predict(model)$x
cla <- predict(model)$class
pos <- predict(model)$posterior
ct <- table(gr, cla)
diag(prop.table(ct, 1))

if (dim(Fp)[2] > 1) {
  plot(Fp[,1], Fp[,2],
    type="n",
    xlab=paste("CV1 (", var[1], "%)", sep=""), 
    ylab=paste("CV2 (", var[2], "%)", sep=""), 
    main="", pch=19)
  if (to_print) {
    text(Fp[,1], Fp[,2], row.names(variaveis))
  } else {
    text(Fp[,1], Fp[,2], row.names(variaveis), col=c(as.numeric(cla)))
  }
  abline(v=0, lty="dotted")
  abline(h=0, lty="dotted")
}