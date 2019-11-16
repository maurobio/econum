import numpy as np
import pandas as pd
import ecopy as ep
import matplotlib.pyplot as plt
from adjustText import adjust_text
from sklearn.cluster import KMeans

to_print = True

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Transformação logarítmica
matriz_log = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais

# Cálculo da distância de Bray-Curtis entre as amostras
# utilizando a função distance() do pacote "ecopy"
X = ep.distance(matriz_log, method="bray")

# Número de agrupamentos 
kmeans_model = KMeans(n_clusters=9)

# Ajuste dos dados de entrada
kmeans_model.fit(X)

# Obtenção dos rótulos dos agrupamentos
labels = kmeans_model.predict(X)

# Valores dos centroides
centroids = kmeans_model.cluster_centers_

# Saída dos resultados
print(labels)
print(centroids)

# Diagrama de dispersão
fig, ax = plt.subplots()
x = list(centroids[:,0])
y = list(centroids[:,1])
if to_print:
    plt.scatter(x, y, color="black", s=20)
else:
    plt.scatter(x, y, color="blue", s=20)
texts = []
for i, txt in enumerate(list(matriz.index)):
    texts.append(ax.text(x[i], y[i], txt, size=7))
adjust_text(texts)
plt.tight_layout()
plt.show()
