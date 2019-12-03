# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1) 

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Definição dos grupos
groups <- as.factor(c(1,1,1,1,2,2,2,2))

# Similaridade percentual usando a função
# simper() do pacote "vegan"
library(vegan)
sim <- simper(matriz_log, groups, permutations=9999)

# Saída dos resultados
print(summary(sim))