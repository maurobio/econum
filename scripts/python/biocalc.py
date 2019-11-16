# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import ecopy as ep

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados de abundância
matriz = matriz.transpose()

# Transformação logarítmica
matriz = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais

#Leitura das variáveis ambientais
variaveis = pd.read_csv("variaveis.csv", header=0, index_col=0, encoding="utf8")

# Conversão das variáveis categóricas 
# para fatores numéricos
variaveis["DLU"] = variaveis.DLU.astype('category')
variaveis["Exot"] = variaveis.Exot.astype('category')
factors = variaveis.select_dtypes(['category']).columns
variaveis[factors] = variaveis[factors].apply(lambda x: x.cat.codes)

# Cálculo da matriz de distância de Bray-Curtis
# entre as amostras
dist = ep.distance(matriz, method="bray")

test = ep.bioenv(dist, variaveis)

# Saída dos resultados
print(test)
