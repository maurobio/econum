# Carregamento do pacote "vegan"
library(vegan)

# Leitura dos dados de abundância das espécies
especies <- read.csv("especies.csv", row.names=1)
#especies <- read.csv("wye.txt", sep="\t", row.names=1)

# Número total de espécies por amostra
# Aqui também poderia ser utilizada
# a função "specnumber" do pacote "vegan"
#S <- apply(especies, 2, specnumber)
S <- apply(especies > 0, 2, sum)
cat(paste("\n", "Número de especies por amostra", sep=""), fill=TRUE)
print(S)

# Número total de indivíduos por amostra
N <- apply(especies, 2, sum)
cat(paste("\n", "Número de individuos por amostra", sep=""), fill=TRUE)
print(N)

# Número máximo de indivíduos por amostra
Nmax <- apply(especies, 2, max)

# Índice de Margalef
D1 <- (S - 1) / log(N)
cat(paste("\n", "Indice de Margalef", sep=""), fill=TRUE)
print(D1, digits=4)

# Índice de Menhinick
D2 <- S / sqrt(N)
cat(paste("\n", "Indice de Menhinick", sep=""), fill=TRUE)
print(D2, digits=4)

# Índice de Berger-Parker
d <- Nmax / N
cat(paste("\n", "Indice de Berger-Parker", sep=""), fill=TRUE)
print(d, digits=4)

# Índice de McIntosh
U <- apply(especies, 2, function(x) sqrt(sum(x^2)))
M <- (N - U) / (N - sqrt(N))
cat(paste("\n", "Indice de McIntosh", sep=""), fill=TRUE)
print(M, digits=4)

# Para o cálculo da diversidade das amostras mediante a 
# função "diversity" do pacote "vegan" é necessário 
# transpor a matriz de especies

# Índice de Simpson
c <- diversity(t(especies), "simpson")
cat(paste("\n", "Indice de Simpson", sep=""), fill=TRUE)
print(c, digits=4)

# Índice de Shannon
H <- diversity(t(especies))
cat(paste("\n", "Indice de Shannon", sep=""), fill=TRUE)
print(H, digits=4)

# Índice de Hurlbert
PIE <- rarefy(t(especies), nrow(t(especies))) - 1
cat(paste("\n", "Indice de Hurlbert", sep=""), fill=TRUE)
print(PIE, digits=4)

# Números de Hill
N0 <- S
N1 <- exp(H)
N2 <- diversity(t(especies), "inv")
cat(paste("\n", "N0 de Hill", sep=""), fill=TRUE)
print(N0)
cat(paste("\n", "N1 de Hill", sep=""), fill=TRUE)
print(N1, digits=4)
cat(paste("\n", "N2 de Hill", sep=""), fill=TRUE)
print(N2, digits=4)

# Equitabilidade
J <- H / log(N0)
E1 <- N1 / N0 
E2 <- N2 / N0
cat(paste("\n", "Equitabilidade J", sep=""), fill=TRUE)
print(J, digits=4)
cat(paste("\n", "Equitabilidade E1", sep=""), fill=TRUE)
print(E1, digits=4)
cat(paste("\n", "Equitabilidade E2", sep=""), fill=TRUE)
print(E2, digits=4)
