# -*- coding: utf-8 -*-
import pandas as pd
# Leitura da matriz de dados de abundância a partir de um arquivo de texto
# delimitado por vírgulas
matriz = pd.read_csv("especies.csv", header=0, index_col=0, encoding="utf8")

# Leitura da matriz de variáveis ambientais  a partir de um arquivo de texto
# delimitado por vírgulas
variaveis = pd.read_csv("variaveis.csv", header=0, index_col=0, encoding="utf8")

# Se os valores numéricos decimais estiverem representados por vírgulas 
# ao invés de pontos e os delimitadores por ponto-e-vírgula, 
# deve-se indicar o separador e o delimitador de campos  
matriz_dec = pd.read_csv("especies.csv", header=0, index_col=0, 
                         sep=';', decimal=',', encoding="utf8")

# Os dados também podem ser lidos de um arquivo de texto delimitado por tabulações
#matriz_txt = pd.read_csv("especies.txt", sep= "\t", encoding="utf8")
matriz_txt = pd.read_table("especies.txt", header=0, index_col=0, encoding="utf8")

# Também é possível ler os dados diretamente de uma planilha eletrônica, 
# nos formatos do Excel (.xls, .xlsx)
matriz_xl = pd.read_excel("especies.xlsx", header=0, index_col=0, sheet=0)

# Leitura dos dados uma tabela do sistema gerenciador de banco de dados SQLite
import sqlite3
connection = sqlite3.connect("bahamas.db")
matriz = pd.read_sql_table("bahamas", connection)
variaveis = pd.read_sql_table("bahamas_env", connection)

# É possível também retornar os dados de uma consulta ao banco de dados
matriz = pd.read_sql_query("select * from bahamas", connection)
variaveis = pd.read_sql_query("select * from bahamas_env", connection)