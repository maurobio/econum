# Leitura da matriz de dados de abundância
matriz <- read.csv("especies.csv", row.names=1)

# Transformação logarítmica
matriz.log <- log10(matriz + 1) # Logaritmos decimais
matriz.log <- log(matriz + 1) # Logaritmos naturais

# Tranformação raiz quadrada
matriz.sqrt <- sqrt(matriz)

# Estandardização e centragem
matriz.stand.1 <- scale(matriz, scale=TRUE, center=TRUE)

# A matriz de abundância pode ser transformada numa matriz de presença/ausência
# por meio da função "decostand" do pacote "vegan"
library(vegan)
matriz.bin <- decostand(matriz, method="pa")

# Também é possível estandartizar a matriz de dados de abundância 
# por meio da função "decostand"
matriz.stand.2 <- decostand(matriz, method="standardize")
