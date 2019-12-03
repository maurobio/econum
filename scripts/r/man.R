to_file <- TRUE

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
dist1 <- vegdist(matriz_log, method="bray") 

# Leitura das variàveis ambientais
variaveis <- read.csv("variaveis.csv", row.names=1)

# Cálculo da distância euclideana
# entre as amostras
dist2 <- vegdist(scale(variaveis), method="euclid")

# Teste de Mantel
# por meio da função mantel() do pacote "vegan"
test <- vegan::mantel(dist1, dist2, method="pearson", permutations=9999)

# Saída dos resultados
print(test)

# O teste de Mantel também pode ser efetuado 
# por meio da função mantel() do pacote "ecodist"
test2 <- ecodist::mantel(formula=dist1~dist2, nperm=9999)

# Diagrama de dispersão
if (to_file) {
  plot(dist1, dist2, 
     xlab="Distancia de Bray-Curtis", 
     ylab="Distancia Euclideana", 
     main="", pch=19, col="black")
} else {
  plot(dist1, dist2, 
       xlab="Distancia de Bray-Curtis", 
       ylab="Distancia Euclideana", 
       main="", pch=19, col="aquamarine4")
}
