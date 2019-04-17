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

# Definição dos grupos
groups = np.array([1,1,1,2,2,2,3,3,3])

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função distance() do pacote "ecopy"
dist = ep.distance(matriz_log, "bray")

# Análise de similaridade usando a função
# anosim() do pacote "ecopy"
ano = ep.anosim(dist, groups, nperm=9999)

# Saída dos resultados
print(ano.summary())

ano.plot()