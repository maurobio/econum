# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import ecopy as ep
import matplotlib.pyplot as plt
from adjustText import adjust_text

to_print = True

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Transformação logarítmica
matriz_log = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função distance() do pacote "ecopy"
dist = ep.distance(matriz_log, method="bray")

# Análise de coordenadas principais
# utilizando a função pcoa() do pacote "ecopy"
pco = ep.pcoa(dist)

# Variância explicada pelos componentes
print(pco.summary)

# Soma dos autovalores positivos
pcovar = pco.evals / sum(pco.evals[pco.evals > 0]) * 100

# Diagrama de dispersão
fig, ax = plt.subplots()
x = list(pco.U[:,0])
y = list(pco.U[:,1])
if to_print:
    plt.scatter(x, y, color="black")
else:
    plt.scatter(x, y, color="blue")
texts = []
for i, txt in enumerate(list(matriz.index)):
    texts.append(ax.text(x[i], y[i], txt))
adjust_text(texts)
plt.xlabel('PCO1 (' + str(round(pcovar[0],1)) + '%)')
plt.ylabel('PCO2 (' + str(round(pcovar[1],1)) + '%)')
plt.tight_layout()
plt.show()