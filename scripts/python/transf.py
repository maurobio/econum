# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transformação logarítmica
matriz_log = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais
matriz_ln = matriz.apply(lambda x: np.log(x + 1))   # Logaritmos naturais

# Transformação raiz quadrada
matriz_sqrt = matriz.apply(lambda x: np.sqrt(x))

# Estandardização por meio da função zscore() do pacote "scipy"
from scipy import stats
matriz_stand = matriz.apply(lambda x: stats.zscore(x))

# A matriz de abundância pode ser transformada numa matriz de presença/ausência
# por meio da função transform() do pacote "ecopy"
import ecopy as ep
matriz_bin = ep.transform(matriz, method="pa")
