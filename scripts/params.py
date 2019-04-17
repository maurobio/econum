# -*- coding: utf-8 -*-
#==============================================================================#
#   Parameters - Computes frequency and dominance from ecological survey data  #
#                                                                              # 
#   Requirements:                                                              #
#      Python 3.6+ (www.python.org)                                            #
#      Pandas 0.2+ (pandas.pydata.org)                                         #
#                                                                              #
#   Description:                                                               #
#      Computes frequency and dominance from ecological survey data            #
#                                                                              #
#   Usage:                                                                     #
#      import pandas as pd                                                     #
#      df = pd.read.csv("dados.txt")                                           #
#      params = parameters(df, freq=True, dom=False, tofile=True)              #
#                                                                              #
#   Arguments:                                                                 #
#      df: data frame, with species in rows and samples in columns             #
#      freq: frequency/constancy table (default = True)                        #
#      dom: abundance/dominance table (default = True)                         #
#      tofile: write results to output file in plain text format               #
#              (default = False)                                               #
#                                                                              #
#   Value:                                                                     #                                                   
#      parameters: dataframe with species in rows and parameters in columns    #
#                                                                              #
#   Author:                                                                    #
#     Mauro J. Cavalcanti (maurobio@gmail.com)                                 #
#                                                                              #
#   License:                                                                   #
#      This program is free software: you can redistribute it and/or modify    #
#      it under the terms of the GNU General Public License as published by    #
#      the Free Software Foundation, either version 3 of the License, or       #
#      (at your option) any later version.                                     #
#                                                                              #
#      This program is distributed in the hope that it will be useful,         #
#      but WITHOUT ANY WARRANTY; without even the implied warranty of          #
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           #
#      GNU General Public License for more details.                            #
#                                                                              #
#      You should have received a copy of the GNU General Public License       #
#      along with this program. If not, see <http://www.gnu.org/licenses/>.    #
#                                                                              #
#   REVISION HISTORY:                                                          #
#      Version 0.95, 27th Jan 19 - Initial release                             #
#==============================================================================#

import numpy as np
import pandas as pd

__version__ = "0.95"

def parameters(x, freq=True, dom=True, tofile=False):
    nrows = x.shape[0]
    ncols = x.shape[1]
    result = pd.DataFrame()
    
    if (tofile):
        outfile = open("Parameters.txt", "w")
        outfile.write("PARAMS Versao " + __version__)
        outfile.write("\n\n")
        outfile.write(str(nrows) + " Especies" + " x " + str(ncols - 1) + " Amostras")
        outfile.write("\n\n")
        outfile.write("PARAMETROS")
        outfile.write("\n")
    
    if (freq):
        species = np.asarray(x.index.tolist())
        frequency = np.zeros(nrows, dtype=int)
        constancy = np.zeros(nrows, dtype=float)
        category = np.empty(nrows, dtype=object)
        if (tofile):
            outfile.write("\n")
            outfile.write('{:40}'.format("Especie") + " Frequencia " + 
                          "  Constancia " + " Categoria ")
            outfile.write("\n")
        c1 = 0
        c2 = 0
        c3 = 0
        for i in range(nrows):
            n = 0
            c = 0
            for j in range(ncols):
                if (x.iloc[i, j] > 0):
                    n = n + 1
            if (n > 0):
                c = (n / ncols) * 100.0
            
            if (c > 50.0):
                cons = "Constante"
                c1 = c1 + 1
            elif ((c >= 25.0) & (c <= 50.0)):
                cons = "Acessoria"
                c2 = c2 + 1
            elif (c < 25.0):
                cons = "Acidental"
                c3 = c3 + 1
            
            frequency[i] = n
            constancy[i] = c
            category[i] = cons
            if (tofile):
                outfile.write('{:30}'.format(species[i]) + '{:21}'.format(n) +  
                              '{:12.2f}'.format(c) + "%" + '{:^14}'.format(cons))
                outfile.write("\n")
            
        result = pd.DataFrame({'species':species, 'frequency':frequency, 
                               'constancy':constancy, 'category':category})
            
        if (tofile):
            outfile.write("\n")
            outfile.write("ESPECIES CONSTANTES = " + str(c1))
            outfile.write("\n")
            outfile.write("ESPECIES ACESSORIAS = " + str(c2))
            outfile.write("\n")
            outfile.write("ESPECIES ACIDENTAIS = " + str(c3))
            outfile.write("\n")
            outfile.write("TOTAL DE ESPECIES   = " + str(nrows))
            outfile.write("\n")
                
    if (dom):
        species = np.asarray(x.index.tolist())
        abundance = np.zeros(nrows, dtype=int)
        dominance = np.zeros(nrows, dtype=float)
        di = np.zeros(nrows, dtype=float)
        if (tofile):
            outfile.write("\n")
            outfile.write('{:40}'.format("Especie") + 
                                  " Abundancia " + "  Dominancia ")
            outfile.write("\n")
            
        for i in range(nrows):
            ni = 0
            d = 0
            for j in range(ncols):
                ni = ni + x.iloc[i, j]
            di[i] = ni
        n = 0
        s = sum(di)
        for i in range(nrows):
            ni = di[i]
            n = n + ni
            d = (ni / s) * 100.0
            abundance[i] = di[i]
            dominance[i] = d
            if (tofile):
                outfile.write('{:30}'.format(species[i]) + 
                              '{:21}'.format(int(ni)) + 
                              '{:12.2f}'.format(d) + "%")
                outfile.write("\n")
    
        if result.empty:
            result = pd.DataFrame({'species':species, 'abundance':abundance, 
                               'dominance':dominance})
        else:
            result = pd.DataFrame({'species':species, 'frequency':frequency, 
                               'constancy':constancy, 'category':category, 
                               'abundance':abundance, 'dominance':dominance})
        
        if (tofile):
            outfile.write("\n")
            outfile.write("TOTAL DE INDIVIDUOS = " + str(int(n)))
            
    if (tofile):
        outfile.close()
            
    return(result)
    
if __name__ == '__main__':
    df = pd.read_csv("especies.csv", header=0, index_col=0)
    params = parameters(df, freq=True, dom=True, tofile=True)