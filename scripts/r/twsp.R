# Leitura dos dados
dados <- read.csv("especies.csv", row.names=1)

# Transposição da matriz de dados
matriz <- t(dados)

# Análise de espécies indicadoras
# utilizando o pacote "twinspanR"
library(twinspanR)
twsp <- twinspan(matriz)
summary(twsp)
print(twsp, what="table")