# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import ecopy as ep

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Transformação logarítmica
matriz_log = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais

# Cálculo do coeficiente de Jaccard mediante a função distance()
# do pacote "ecopy". Outras opções de coeficientes binários são: 
# "kulczynski" e "sorensen". É necessário transformar a matriz 
# de abundância para presença/ausência
matriz_bin = ep.transform(matriz, method="pa")
simil = ep.distance(matriz_bin, method="jaccard")

# Cálculo da distância de Bray-Curtis mediante a função distance()
# do pacote "ecopy". Outras opções de coeficientes de distância são: 
# "euclidean", "manhattan" e "canberra"
dist = ep.distance(matriz_log, method="bray")
ochiai = ep.distance(matriz_bin, method="ochiai")

# A matriz de correlação é calculada por meio 
# da função corr() do pacote "pandas" 
matriz_log = matriz_log.transpose()
corr = np.asarray(matriz_log.corr(method="pearson"))

labels = list(matriz.index)
row_col = len(labels)
for j in range(row_col):
   print(labels[j] + '\t', end="")
print('')
for i in range(row_col):
    print(labels[i] + '\t', end="")
    for j in range(i+1):
        print("%.4f" % simil[i][j] + "\t", end="")
    print('')