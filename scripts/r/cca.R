# Leitura dos dados
dados <- read.csv("especies.csv", row.names=1)
variaveis <- read.csv("variaveis.csv", row.names=1)

# Construção da matriz de dados
matriz.X <- as.matrix.data.frame(dados)
matriz.Y <- as.matrix.data.frame(variaveis)

# Transposição da matriz de dados
matriz.X <- t(matriz.X)
matriz.Y <- matriz.Y

# Estandardização das matrizes de dados
Xs <- scale(matriz.X)
Ys <- scale(matriz.Y)

# Análise de correlação canônica
# utilizando a função "cancor" do Sistema R
cca <- cancor(Xs, Ys)
print(cca)

#library(yacca)
#cc <- cca(matriz.X, matriz.Y, xscale=TRUE, yscale=TRUE)
#library(vegan)
#cc <- CCorA(Xs, Ys)
#biplot(cc, "b")
