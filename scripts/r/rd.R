library(vegan)

# Leitura dos dados
matriz <- read.csv("especies.csv", row.names=1)
nomes <- rownames(matriz)
rownames(matriz) <- make.cepnames(nomes)

# Transposição da matriz de dados
matriz <- t(matriz)

# Leitura das variàveis ambientais
variaveis <- read.csv("variaveis.csv", row.names=1)

# Análise de redundâncias
# por meio da função "rda" do pacote "vegan"
ra <- rda(matriz, variaveis)

# Biplot
plot(ra, scaling="symmetric")