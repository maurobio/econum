# Leitura dos dados
matriz <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(matriz)

# Transformação logarítmica da matriz de abundância
matriz_log <- log10(matriz + 1)

# Leitura das variàveis ambientais
variaveis <- read.csv("variaveis.csv", row.names=1)

# Análise de Procrustes
# por meio da função procrustes() do pacote "vegan"
library(vegan)
proc <- procrustes(matriz_log, variaveis)

# Saída dos resultados
print(summary(proc))
plot(proc)
plot(proc, kind=2)