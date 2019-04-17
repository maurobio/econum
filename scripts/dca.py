# -*- coding: utf-8 -*-
import pandas as pd
import cornpy as cp
import matplotlib.pyplot as plt
from adjustText import adjust_text

to_print = True

# Leitura dos dados
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Análise de correspondências corrigida
# utilizando a função decorana() do pacote CEPy
site_scores, species_scores = cp.decorana(matriz)

# Diagrama de dispersão
fig, ax = plt.subplots()
x = list(site_scores[:,0])
y = list(site_scores[:,1])
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
plt.xlabel('DCA1')
plt.ylabel('DCA2')
plt.tight_layout()
plt.show()