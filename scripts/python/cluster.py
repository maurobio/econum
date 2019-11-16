# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import ecopy as ep
from scipy.cluster.hierarchy import linkage, dendrogram, cophenet, set_link_color_palette
from scipy.spatial.distance import squareform
import matplotlib.pyplot as plt

to_print = True

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Transformação logarítmica
matriz_log = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais

# Cálculo da distância de Bray-Curtis entre as amostras
# por meio da função distance() do pacote "ecopy"
dist = ep.distance(matriz_log, method="bray")

# Análise de agrupamentos, cálculo da correlação cofenética e construção do dendrogama
# mediante a função linkage() do pacote SciPy

# Ligação simples
if to_print:
    set_link_color_palette(['k', 'k', 'k', 'k', 'k'])
    col = 'k'
else:
    set_link_color_palette(['b', 'b', 'b', 'b', 'b'])
    col = 'b'
hc = linkage(dist, method="single")
dc = cophenet(hc, squareform(dist))[0]
dendrogram(hc, labels=list(matriz.index), orientation="left", color_threshold=0, above_threshold_color=col)
plt.title("SLM (r = " + "{:.4f}".format(dc) + ")")
plt.ylabel("Amostras")
plt.xlabel(u"Distância de Bray-Curtis")
plt.tight_layout()
plt.show()

# Ligação completa
hc = linkage(dist, method="complete")
dc = cophenet(hc, squareform(dist))[0]
dendrogram(hc, labels=list(matriz.index), orientation="left", color_threshold=0, above_threshold_color=col)
plt.title("CLM (r = " + "{:.4f}".format(dc) + ")")
plt.ylabel("Amostras")
plt.xlabel(u"Distância de Bray-Curtis")
plt.tight_layout()
plt.show()

# Média ponderada
hc = linkage(dist, method="weighted")
dc = cophenet(hc, squareform(dist))[0]
dendrogram(hc, labels=list(matriz.index), orientation="left", color_threshold=0, above_threshold_color=col)
plt.title("WPGMA (r = " + "{:.4f}".format(dc) + ")")
plt.ylabel("Amostras")
plt.xlabel(u"Distância de Bray-Curtis")
plt.tight_layout()
plt.show()

# Média não-ponderada
hc = linkage(dist, method="average")
dc = cophenet(hc, squareform(dist))[0]
dendrogram(hc, labels=list(matriz.index), orientation="left", color_threshold=0, above_threshold_color=col)
plt.title("UPGMA (r = " + "{:.4f}".format(dc) + ")")
plt.ylabel("Amostras")
plt.xlabel(u"Distância de Bray-Curtis")
plt.tight_layout()
plt.show()

# Método de Ward
hc = linkage(dist, method="ward")
dc = cophenet(hc, squareform(dist))[0]
dendrogram(hc, labels=list(matriz.index), orientation="left", color_threshold=0, above_threshold_color=col)
plt.title("Ward (r = " + "{:.4f}".format(dc) + ")")
plt.ylabel("Amostras")
plt.xlabel(u"Distância de Bray-Curtis")
plt.tight_layout()
plt.show()
