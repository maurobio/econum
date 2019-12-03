# Carregamento da funcao "parameters"
source("params.R")

# Numero de digitos no formato de saida
options(digits=4, width=90)

# Leitura do arquivo de dados
x <- read.csv("especies.csv", header=TRUE, as.is=TRUE)
#x <- read.table("especies.csv", header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE, as.is=TRUE)

# Chamada da funcao "parameters"
p <- parameters(x, freq=TRUE, dom=TRUE, tofile=FALSE)

# Numero total de individuos
i <- sum(p$abundance)

# Numero total de especies
s <- nrow(x)

# Total de especies por categoria
a <- length(which(p$category == "Acessoria"))
d <- length(which(p$category == "Acidental"))
c <- length(which(p$category == "Constante"))

# Saida dos resultados
linha <- paste("+", strrep("-", 81), "+", sep="")
cat(linha, fill=TRUE)
cat(knitr::kable(p), fill=TRUE)
cat(linha, fill=TRUE)

cat(paste("Total de individuos = ", i, sep=""), fill=TRUE)
cat(paste("Total de especies   = ", s, sep=""), fill=TRUE)
cat(paste("Especies constantes = ", c, sep=""), fill=TRUE)
cat(paste("Especies acessorias = ", a, sep=""), fill=TRUE)
cat(paste("Especies acidentais = ", d, sep=""), fill=TRUE)