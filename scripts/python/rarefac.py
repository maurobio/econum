# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import ecopy as ep

# Leitura da matriz de dados de abundância
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transposição da matriz de dados
matriz = matriz.transpose()

# Cálculo da curva de rarefação 
# usando a função "rarefy" do pacote "ecopy"
r = ep.rarefy(matriz, 'rarefy')

# Saída dos resultados
print(r)

# Curva de rarefação
ep.rarefy(matriz, 'rarecurve')