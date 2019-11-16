# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from adjustText import adjust_text
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA

to_print = True

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

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

features = variaveis.dtypes.index.tolist()
samples = matriz.dtypes.index.tolist()

# Análise discriminante linear
# por meio da função lda() do pacote "sklearn"
X = variaveis
y = np.array([1,1,1,2,2,3,1,2,3])
lda = LDA(n_components = 2)
data_projected = lda.fit_transform(X, y)

# Saída dos resultados
print("Group means:")
print(lda.means_)
print("Coefficients of linear discriminants:")
print(lda.coef_)
print("Proportion of trace:")
print(lda.explained_variance_ratio_)

# Diagrama de dispersão
markers = ['s','^','o']
if to_print:
    colors = ['k','k','k']
else:
    colors = ['r','g','b']
f, ax = plt.subplots()
for l,m,c in zip(np.unique(y), markers, colors):   
    ax.scatter(data_projected[:,0][y==l],data_projected[:,1][y==l],c=c,marker=m)
x = list(data_projected[:,0])
y = list(data_projected[:,1])
texts = []
for i, txt in enumerate(list(variaveis.index)):
    texts.append(ax.text(x[i], y[i], txt))
adjust_text(texts)
plt.axhline(y=0, color='lightgray', linestyle='--')
plt.axvline(x=0, color='lightgray', linestyle='--')
plt.xlabel('CV1 (' + str(round(lda.explained_variance_ratio_[0]*100,1)) + '%)')
plt.ylabel('CV2 (' + str(round(lda.explained_variance_ratio_[1]*100,1)) + '%)')
plt.tight_layout()
plt.show()
