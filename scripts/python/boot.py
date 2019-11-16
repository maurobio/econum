# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import pyper as pr

# Leitura dos dados
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Transformação logarítmica
matriz_log = matriz.apply(lambda x: np.log10(x + 1)) # Logaritmos decimais

# Teste de significância dos agrupamentos
r = pr.R(RCMD='C:\\Program Files\\R\\R-3.5.2\\bin\\R', use_pandas=True)
r.assign('rdata', matriz_log)
r('library(pvclust)')
r('result <- pvclust(rdata, method.dist="euclidean", method.hclust="average", nboot=1000)')
r('png("boot.png"); plot(result); dev.off()')
r('pvrect(result, alpha=0.95)')
print(r('result'))
