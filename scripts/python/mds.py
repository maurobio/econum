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
# utilizando a função distance() do pacote EcoPy
dist = ep.distance(matriz_log, "bray")

# Escalonamento multidimensional não-métrico
fit = ep.MDS(dist, siteNames=matriz.index)

# Saída dos resultados
print("Stress = " + str(round(fit.stress, 5)))

# Diagrama de dispersão
fig, ax = plt.subplots()
x = list(fit.scores[:,0])
y = list(fit.scores[:,1])
if to_print:
    plt.scatter(x, y, color="black")
else:
    plt.scatter(x, y, color="blue")
texts = []
for i, txt in enumerate(list(matriz.index)):
    texts.append(ax.text(x[i], y[i], txt))
adjust_text(texts)
plt.axhline(y=0, color='gray', linestyle='--')
plt.axvline(x=0, color='gray', linestyle='--')
plt.title('Stress = ' + str(round(fit.stress, 5)))
plt.xlabel(u'Dimensão 1')
plt.ylabel(u'Dimensão 2')
plt.tight_layout()
plt.show()
