library(vegan)
options(digits = 4)

# Leitura dos dados
especies <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(especies)

# Cálculo do coeficiente de Jaccard mediante a função vegdist
# O parâmetro "binary" indica a conversão da matriz para dados binários
# Outras opções de coeficientes binários são:
# "kulczynski" e "mountford"
simil <- vegdist(matriz, method="jaccard", binary=TRUE, diag=TRUE)

# Outros coeficientes binários podem ser calculados por meio 
# da função "designdist".
sorensen <- designdist(matriz, "(A+B-2*J)/(A+B)")
ochiai <- designdist(matriz, "1-J/sqrt(A*B)")

# Transformação logarítmica da matriz de abundância
matriz.log <- log10(matriz + 1)

# Cálculo da distância de Bray-Curtis
# Outras opções de coeficientes de distância são: 
# "euclidean", "manhattan", canberra", "morisita" e "horn"
dist <- vegdist(matriz.log, method="bray", binary=FALSE, diag=TRUE)

# Também é possível calcular diversos coeficientes de distância 
# utilizando a função distance() do pacote "ecodist"
#library(ecodist)
#dist <- distance(matriz.log, "bray-curtis")

# A matriz de correlação é calculada por meio 
# da função cor() do pacote "stats" 
# A matriz de correlação deve ser convertida
# em matriz de distância para ser usada
# na análise de agrupamentos
corr <- as.dist(cor(t(matriz.log)))