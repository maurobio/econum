# -*- coding: utf-8 -*-
import pandas as pd
import cepy as cp

# Leitura do arquivo de dados
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")
names = cp.make_cepnames(matriz.index)
names = [name[0:4] + ' ' + name[4:8] for name in names]
matriz.index = names

# Chamada da função definida pelo usuário parameters()
from params import parameters
p = parameters(matriz, freq=True, dom=True, tofile=False)

# Número total de indivíduos
t = p['abundance'].sum()

# Número total de espécies
s = len(matriz)

# Total de espécies por categoria
a = len(p[p['category'] == "Acessoria"])
d = len(p[p['category'] == "Acidental"])
c = len(p[p['category'] == "Constante"])

# Saída dos resultados
from tabulate import tabulate
print(tabulate(p, headers='keys', tablefmt='psql', showindex=False, 
               floatfmt=("%s", "%d", ".2f", "%s", "%d", ".2f")))

print("Total de indivíduos = " + str(t))
print("Total de espécies   = " + str(s))
print("Espécies constantes = " + str(c))
print("Espécies acessórias = " + str(a))
print("Espécies acidentais = " + str(d))