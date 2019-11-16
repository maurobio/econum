# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
from scipy.spatial.distance import squareform, pdist
import matplotlib.pyplot as plt
import seaborn as sns

to_print = True

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Transformação logarítmica
matriz_log = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais

# Cálculo da distância de Bray-Curtis entre as amostras
# por meio da função pdist() do pacote SciPy
dist = pd.DataFrame(squareform(pdist(matriz_log.iloc[:, 1:], metric="braycurtis")), 
                    columns=matriz_log.index, index=matriz_log.index)

# Construção do diagrama de treliça
# utilizando o pacote seaborn
sns.set()
if to_print:
    ax = sns.heatmap(dist, cmap="Greys")
else:
    ax = sns.heatmap(dist, cmap="coolwarm")
#ax = sns.heatmap(dist, cmap="PuBuGn")
plt.tight_layout()
plt.show()
