# Leitura dos dados de abundância
matriz <- read.csv("especies.csv", row.names=1) 

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Leitura das variàveis ambientais
variaveis <- read.csv("variaveis.csv", row.names=1)

# Definição dos grupos
groups <- as.factor(c(1,1,1,1,2,2,2,2))

# Melhor combinação Variáveis usando a função
# bioenv() do pacote "vegan"
library(vegan)
sol <- bioenv(matriz_log, variaveis, method="spearman", index="bray", metric="euclidean")

# Saída dos resultados
print(summary(sol))