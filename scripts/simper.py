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

# Percentual de similaridade usando a função
# simper() do pacote "ecopy"
sim = ep.simper(np.asarray(matriz_log), groups, spNames=matriz_log.columns)

# Saída dos resultados
print(sim)