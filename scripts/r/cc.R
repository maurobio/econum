library(vegan)

# Leitura dos dados
matriz <- read.csv("especies.csv", row.names=1)
nomes <- rownames(matriz)
rownames(matriz) <- make.cepnames(nomes)

# Transposição da matriz de dados
matriz <- t(matriz)

# Leitura das variàveis ambientais
variaveis <- read.csv("variaveis.csv", row.names=1)

# Análise de correspondências canônica
# por meio da função "cca" do pacote "vegan"
library(vegan)
cc <- cca(matriz, variaveis)

# Biplot
plot(cc, scaling="symmetric")