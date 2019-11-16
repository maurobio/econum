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

# Análise de componentes principais (modo-Q)
# utilizando a função pca() do pacote EcoPy
pc = ep.pca(matriz_log, scale=True)

# Cálculo da variância explicada pelos componentes
pcavar = (pc.evals / sum(pc.evals)) * 100

# Variância explicada pelos componentes
std = np.sqrt(pc.evals)
var = (pc.evals / sum(pc.evals))
cum = np.cumsum(pc.evals)
cum /= cum[-1]
lab = []
for i in range(len(pc.evals)):
    lab.append('PC' + str(i+1))
 
summary = pd.DataFrame(data={'Standard deviation':std, 'Proportion of variance':var, 
                             'Cumulative proporation':cum}, index=lab)

print('Importance of components:')
with pd.option_context('precision', 3, 'display.expand_frame_repr', False):
    print(summary.transpose())

print()

# Coeficientes dos autovetores
rot = pc.summary_rot()
print(rot.loc[:,['PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6']])

# Gráfico de declividade
if to_print:
    plt.plot(np.arange(len(pc.evals)) + 1, np.sqrt(pc.evals)*10, color="black", marker='o')
else:
    plt.plot(np.arange(len(pc.evals)) + 1, np.sqrt(pc.evals)*10, color="red", marker='o')
plt.xlabel('Autovetor')
plt.ylabel(u'Variância (%)')
plt.show()

# Diagrama de dispersão
fig, ax = plt.subplots()
x = list(pc.scores[:,0])
y = list(pc.scores[:,1])
if to_print:
    plt.scatter(x, y, color="black")
else:
    plt.scatter(x, y, color="blue")
texts = []
for i, txt in enumerate(list(matriz.index)):
    texts.append(ax.text(x[i], y[i], txt))
adjust_text(texts)
plt.xlabel('PC1 (' + str(round(summary["Proportion of variance"][0]*100,1)) + '%)')
plt.ylabel('PC2 (' + str(round(summary["Proportion of variance"][1]*100,1)) + '%)')
plt.tight_layout()
plt.show()
