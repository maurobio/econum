to_print <- TRUE

# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1)
nomes <- rownames(matriz)
rownames(matriz) <- make.cepnames(nomes)

# Transposição da matriz de dados
matriz <- t(matriz)

# Análise de correspondências
# utilizando o pacote "ca"
library(ca)
corresp <- ca(matriz, nd=2)
pct <- round(100* (corresp$sv^2) / sum(corresp$sv^2), 1)
if (to_print) {
  plot(corresp, 
     main="",
     xlab=paste("Eixo 1 (", pct[1], "%)", sep=""), 
     ylab=paste("Eixo 2 (", pct[2], "%)", sep=""), 
     col="black", col.lab="black", arrows=c(FALSE, FALSE))
} else {
  plot(corresp, 
       main="",
       xlab=paste("Eixo 1 (", pct[1], "%)", sep=""), 
       ylab=paste("Eixo 2 (", pct[2], "%)", sep=""), 
       col="darkgreen", arrows=c(FALSE, FALSE))
}