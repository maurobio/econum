to_print <- TRUE

# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(matriz)

library(vegan)
amostra <- min(rowSums(matriz)) # tamanho da amostra para rarefação 
s <- specnumber(matriz) # número observado de espécies

# Cálculo da curva de rarefação 
# usando a função "rarefy" do pacote "vegan"
r <- rarefy(matriz, amostra)

# Saída dos resultados
print(r)

# Curva de rarefação
if (to_print) {
  rarecurve(matriz, step=20, sample=amostra, xlab="Tamanho da Amostra", ylab="Espécies", cex=0.6)
} else {
  rarecurve(matriz, step=20, sample=amostra, xlab="Tamanho da Amostra", ylab="Espécies", col="blue", cex=0.6)
}