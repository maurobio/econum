# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import ecopy as ep

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Número total de espécies por amostra
S = matriz.gt(0).sum()
print("\n", "Número de especies por amostra")
print(np.asarray(S))

# O número de espécies por amostra 
# também pode ser obtido pela função diversity()
# do pacote EcoPy com o parâmetro spRich
S = ep.diversity(matriz.T, "spRich")

# Número total de indivíduos por amostra
N = matriz.sum()
print("\n", "Número de indivíduos por amostra")
print(np.asarray(N))

# Número máximo de indivíduos por amostra
Nmax = matriz.max()

# Índice de Margalef
D1 = (S - 1) / np.log(N)
print("\n", "Índice de Margalef")
print(np.asarray(D1))

# Índice de Menhinick
D2 = S / np.sqrt(N)
print("\n", "Índice de Menhinick")
print(np.asarray(D2))

# Índice de Berger-Parker
d = Nmax / N
print("\n", "Índice de Berger-Parker")
print(np.asarray(d))

# Índice de McIntosh
U = matriz.apply(lambda x: np.sqrt(np.sum(x**2)))
M = (N - U) / (N - np.sqrt(N))
print("\n", "Índice de McIntosh")
print(np.asarray(M))

# Para o cálculo da diversidade das amostras mediante a 
# função diversity() do pacote "ecopy" é necessário 
# transpor a matriz de dados

# Índice de Simpson
c = ep.diversity(matriz.transpose(), "simpson", num_equiv=False)
print("\n", "Índice de Simpson")
print(np.asarray(c))

# Índice de Shannon
H = ep.diversity(matriz.transpose(), "shannon", num_equiv=False)
print("\n", "Índice de Shannon")
print(np.asarray(H))

# Índice de Hurlbert
PIE = ep.rarefy(matriz.transpose()) - 1
print("\n", "Índice de Hurlbert")
print(np.asarray(PIE))

# Números de Hill
N0 = np.asarray(S)
N1 = np.exp(H)
N2 = ep.diversity(matriz.transpose(), "gini-simpson")
print("\n", "N0 de Hill")
print(N0)
print("\n", "N1 de Hill")
print(np.asarray(N1))
print("\n", "N2 de Hill")
print(np.asarray(N2))

# Equitabilidade
J = H / np.log(N0)             # Pielou
E1 = N1 / N0                   # Sheldon
E2 = N2 / N0                   # Hill 
E3 = ((N1 - 1) / (N0 - 1)) - 1 # Heip
E4 = (N2 - 1) / (N1 - 1)       # Alatalo
print("\n", "Equitabilidade J")
print(np.asarray(J))
print("\n", "Equitabilidade E1")
print(np.asarray(E1))
print("\n", "Equitabilidade E2")
print(np.asarray(E2))
print("\n", "Equitabilidade E3")
print(np.asarray(E3))
print("\n", "Equitabilidade E4")
print(np.asarray(E4))
