to_print <- TRUE

# Leitura dos dados
matriz <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(matriz)

# Análise de correspondências corrigida
# utilizando a função "decorana" do pacote "vegan"
library(vegan)
dca <- decorana(matriz)
plot(dca, type="none", display="sites", main="")
if (to_print) {
  points(dca, pch=19, cex=1, col="black")
} else {
  points(dca, pch=19, cex=1, col="blue")
}
text(dca, labels=rownames(matriz), cex=1, pos=3)