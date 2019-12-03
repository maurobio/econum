# Leitura da matriz de dados de abundância a partir de um arquivo de texto
# delimitado por vírgulas
matriz <- read.csv("especies.csv", row.names=1)

# Leitura da matriz de variáveis ambientais  a partir de um arquivo de texto
# delimitado por vírgulas
variaveis <- read.csv("variaveis.csv", row.names=1)

# Se os valores numéricos decimais estiverem representados por vírgulas 
# ao invés de pontos e os delimitadores por ponto-e-vírgula, deve-se usar 
# a função read.csv2() 
matriz <- read.csv2("especies.csv", row.names=1)

# Os dados também podem ser lidos de um arquivo de texto delimitado por tabulações
matriz <- read.table(file="especies.txt", sep= "\t", row.names=1)

# Também é possível ler os dados diretamente de uma planilha eletrônica, 
# nos formatos do Excel (.xls, .xlsx), com os pacotes "XLConnect", "xlsx" ou "readxl"
library(XLConnect)
matriz <- readWorksheetFromFile("especies.xlsx", sheet=1)
# library(readxl)
# matriz <- as.data.frame("especies.xlsx")
# ...ou no formato do LibreOffice (.ods) com o pacote "readODS"
library(readODS)
matriz <- read.ods("especies.ods", sheet=1)

# Leitura dos dados uma tabela do sistema gerenciador de banco de dados SQLite
library(RSQLite)
db <- dbConnect(dbDriver("SQLite"), dbname="especies.db")
matriz <- dbReadTable(db, "especies")
variaveis <- dbReadTable(db, "variaveis")