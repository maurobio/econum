# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import ecopy as ep
import matplotlib.pyplot as plt

to_print = True

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

# Estandardização das variáveis e cálculo das matrizes de distância
variaveis = variaveis.apply(lambda x: (x - x.mean())/x.std(), axis=0)
dist1 = ep.distance(matriz, method="bray") 
dist2 = ep.distance(variaveis, method="euclidean")

# Teste de Mantel
# por meio da função Mantel() do pacote "ecopy"
test = ep.Mantel(dist1, dist2, test="pearson", nperm=9999)

# Saída dos resultados
print(test.summary())

# Diagrama de dispersão
fig, ax = plt.subplots()
if to_print:
    plt.scatter(dist1, dist2, color="black")
else:
    plt.scatter(dist1, dist2)
plt.xlabel("Distância de Bray-Curtis") 
plt.ylabel("Distância Euclideana")
ax.set_xlim(dist1.min()+0.3, dist1.max()+0.05)
ax.set_ylim(dist2.min()+3.0, dist2.max()+0.5)
plt.tight_layout()
plt.show()