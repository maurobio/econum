# Carregamento do pacote "vegan"
library(vegan)

# Numero de digitos no formato de saida
options(digits=3, width=90)

# Leitura dos dados
matriz <- read.csv("especies.csv", row.names=1)

# Número total de espécies por amostra
S <- apply(matriz > 0, 2, sum)
# Aqui também poderia ser utilizada
# a função specnumber() do pacote "vegan"
S <- apply(matriz, 2, specnumber) 

# Número total de indivíduos por amostra
N <- apply(matriz, 2, sum)

# Número máximo de indivíduos por amostra
Nmax <- apply(matriz, 2, max)

# Índice de Margalef
D1 <- (S - 1) / log(N)

# Índice de Menhinick
D2 <- S / sqrt(N)

# Índice de Berger-Parker
d <- Nmax / N

# Índice de McIntosh
U <- apply(matriz, 2, function(x) sqrt(sum(x^2)))
M <- (N - U) / (N - sqrt(N))

# Para o cálculo da diversidade das amostras mediante a 
# função diversity() do pacote "vegan" é necessário 
# transpor a matriz de dados

# Índice de Simpson
c <- diversity(t(matriz), "simpson") 

# Índice de Shannon
H <- diversity(t(matriz))

# Índice de Hurlbert
PIE <- rarefy(t(matriz), nrow(t(matriz))) - 1

# Números de Hill
N0 <- S
N1 <- exp(H)
N2 <- diversity(t(matriz), "inv")

# Equitabilidade
J <- H / log(N0)                # Pielou
E1 <- N1 / N0                   # Sheldon
E2 <- N2 / N0                   # Hill 
E3 <- ((N1 - 1) / (N0 - 1)) - 1 # Heip
E4 <- (N2 - 1) / (N1 - 1)       # Alatalo

# Armazenamento dos resultados em um quadro de dados
result <- t(data.frame(S, N, D1, D2, d, M, c, H, PIE, N0, N1, N2, J, E1, E2, E3, E4))

# Saida dos resultados
linha <- paste("+", strrep("-", 70), "+", sep="")
cat(linha, fill=TRUE)
cat(knitr::kable(result), fill=TRUE)
#cat(knitr::kable(result[,cols]), fill=TRUE)
cat(linha, fill=TRUE)