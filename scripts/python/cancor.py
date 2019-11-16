# -*- coding: utf-8 -*-
import pandas as pd
from sklearn.cross_decomposition import CCA
from scipy.stats import pearsonr

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

#Leitura da matriz de dados ambientais
variaveis = pd.read_csv("variaveis.csv", header=0, index_col=0, encoding="utf8")

# Conversão das variáveis categóricas 
# para fatores numéricos
variaveis["DLU"] = variaveis.DLU.astype('category')
variaveis["Exot"] = variaveis.Exot.astype('category')
factors = variaveis.select_dtypes(['category']).columns
variaveis[factors] = variaveis[factors].apply(lambda x: x.cat.codes)

# Transposição da matriz de dados de abundância
matriz = matriz.transpose()

# Análise de correlação canônica
# utilizando a função CCA() do pacote scikit-learn
cc = CCA(n_components=1, scale=True).fit(matriz, variaveis)
Xc, Yc = cc.transform(matriz, variaveis)
corrcoef, p_value = pearsonr(Xc, Yc)
print("r = ", corrcoef, ',', "p = ", p_value)
