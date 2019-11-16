# -*- coding: utf-8 -*-
import pandas as pd
import ecopy as ep
import cornpy as cp
import matplotlib.pyplot as plt
from adjustText import adjust_text

to_print = True

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()
names = cp.make_cepnames(matriz.dtypes.index)

# Análise de correspondências
# utilizando a função ca() do pacote "ecopy"
corresp = ep.ca(matriz, spNames=names)

# Saída dos resulttados
print(corresp.summary())

# Biplot
fig, ax = plt.subplots()
x = list(corresp.siteScores.iloc[:,0])
y = list(corresp.siteScores.iloc[:,1])
sites = matriz.index.tolist()
if to_print:
    plt.scatter(x, y, color="black")
else:
    plt.scatter(x, y, color="blue")
texts = []
for i, txt in enumerate(sites):
    texts.append(ax.text(x[i], y[i], txt))
adjust_text(texts)
plt.plot(corresp.spScores.iloc[:,0], corresp.spScores.iloc[:,1], 'r^', ms=0)
if to_print:
    [ax.text(x,y,s, fontsize=9, color='k', ha='center', va='center')
        for x,y,s in zip(corresp.spScores.iloc[:,0], corresp.spScores.iloc[:,1], names)]
else:
    [ax.text(x,y,s, fontsize=9, color='r', ha='center', va='center')
        for x,y,s in zip(corresp.spScores.iloc[:,0], corresp.spScores.iloc[:,1], names)]
plt.axhline(y=0, color='gray', linestyle='--')
plt.axvline(x=0, color='gray', linestyle='--')
plt.xlabel('Eixo 1 (' + str(round(corresp.summary()["CA Axis 1"][1]*100,1)) + '%)')
plt.ylabel('Eixo 2 (' + str(round(corresp.summary()["CA Axis 2"][1]*100,1)) + '%)')
plt.show()
