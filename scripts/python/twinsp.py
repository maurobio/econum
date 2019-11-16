# -*- coding: utf-8 -*-
import pandas as pd
import cornpy as cp

# Leitura dos dados
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Análise de espécies indicadoras
# utilizando a função twinspan()
# do pacote CEPy
output = cp.twinspan(matriz)

# Saída dos resultados
print(output)
