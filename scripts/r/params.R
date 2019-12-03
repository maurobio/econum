#==============================================================================#
#   Parameters - Computes frequency and dominance from ecological survey data  #
#                                                                              # 
#   Requirements:                                                              #
#      R language and environment for statistical computing and graphics,      #
#      available from the R Project for Statistical Computing at               #
#      http://www.r-project.org                                                #
#                                                                              #
#   Description:                                                               #
#      Computes frequency and dominance from ecological survey data            #
#                                                                              #
#   Usage:                                                                     #
#      df <- read.table("dados.txt", header=TRUE, sep="", na.strings="NA",     #
#                       dec=".", strip.white=TRUE, as.is=TRUE)                 #
#      params <- parameters(df,freq=TRUE,dom=FALSE,tofile=TRUE)                #
#                                                                              #
#   Arguments:                                                                 #
#      df: data frame, with species in rows and samples in columns             #
#      freq: frequency/constancy table (default = TRUE)                        #
#      dom: abundance/dominance table (default = TRUE)                         #
#      tofile: write results to output file in plain text format               #
#              (default = FALSE)                                               #
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
#      Version 0.92, 24th Nov 13 - Initial release                             #
#      Version 0.93, 12th Jun 14 - Added counts of constant, accessory, and    #
#                                  accidental species                          #
#      Version 0.94, 30th Dec 18 - Changed first function parameter to accept  #
#                                  a data frame instead of a file name
#==============================================================================#

parameters <- function(X, freq=TRUE, dom=TRUE, tofile=FALSE) {

	nrows <- nrow(x)
	ncols <- ncol(x) - 1
  #nrow(x); ncol(x)
	
	if (tofile) {
	  outfile <- file(description="Parameters.txt", open="w")
		cat(file=outfile, "PARAMS Versao 0.94")
		cat(file=outfile, "\n\n")
		cat(file=outfile, toString(nrows), "Especies", "x", toString(ncols), "Amostras")
		cat(file=outfile, "\n\n")
		cat(file=outfile, "PARAMETROS")
		cat(file=outfile, "\n")
	}	
	
	if (freq) {
		species <- vector(length=nrows)
		frequency <- vector(length=nrows)
		constancy <- vector(length=nrows)
		category <- vector(length=nrows)
		if (tofile) {
			cat(file=outfile, "\n")
			cat(file=outfile, formatC("Especie", width=50, flag="-"), " Frequencia ", " Constancia ", " Categoria ")
			cat(file=outfile, "\n")
		}
		c1 <- 0
		c2 <- 0
		c3 <- 0
		for (i in 1:nrows) {
			n <- 0
			c <- 0
			for (j in 1:ncols) {
				if (x[i,j+1] > 0) {n <- n + 1}
			}
			if (n > 0) {c <- (n / ncols) * 100.0}
			
			if (c > 50.0) {
				cons <- "Constante"
				c1 <- c1 + 1
			} else if ((c >= 25.0) & (c <= 50.0)) {
				cons <- "Acessoria"
				c2 <- c2 + 1
			} else if (c < 25.0) {
				cons <- "Acidental"
				c3 <- c3 + 1
			}
			species[i] <- x[i,1]
			frequency[i] <- n
			constancy[i] <- c
			category[i] <- cons
			if (tofile) {
				cat(file=outfile, formatC(species[i], width=30, flag="-"), formatC(n, width=31, format="d", flag="#"), paste(formatC(c, width=11, digits=2, format="f", flag="#"), "%", sep=""), rep(" ", 1), cons)
				cat(file=outfile, "\n")
			}
		}
		result <- data.frame(species, frequency, constancy, category)
		
		if (tofile) {
			cat(file=outfile, "\n")
			cat(file=outfile, "ESPECIES CONSTANTES = ", c1)
			cat(file=outfile, "\n")
			cat(file=outfile, "ESPECIES ACESSORIAS = ", c2)
			cat(file=outfile, "\n")
			cat(file=outfile, "ESPECIES ACIDENTAIS = ", c3)
			cat(file=outfile, "\n")
			cat(file=outfile, "TOTAL DE ESPECIES   = ", nrows)
			cat(file=outfile, "\n")
		}	
	}
	
	if (dom) {
		species <- vector(length=nrows)
		abundance <- vector(length=nrows)
		dominance <- vector(length=nrows)
		di <- vector(length=nrows)
		if (tofile) {
			cat(file=outfile, "\n")
			cat(file=outfile, formatC("Especie", width=50, flag="-"), " Abundancia ", " Dominancia ")
			cat(file=outfile, "\n")
		}	
		for (i in 1:nrows) {
			ni <- 0
			d <- 0
			for (j in 1:ncols) {
				ni <- ni + x[i,j+1]
			}	
			di[i] <- ni
		}
		n <- 0
		s <- sum(di)
		for (i in 1:nrows) {
			ni <- di[i]
			n <- n + ni
			d <- (ni / s) * 100.0
			species[i] <- x[i,1]
			abundance[i] <- di[i]
			dominance[i] <- d
			if (tofile) {
				cat(file=outfile, formatC(species[i], width=30, flag="-"), formatC(ni, width=32, format="d", flag="#"), paste(formatC(d, width=12, digits=2, format="f", flag="#")), "%", sep="")
				cat(file=outfile, "\n")
			}
		}
		
    if (freq) {
        result <- data.frame(result, abundance, dominance)
    } else {
        result <- data.frame(species, abundance, dominance)
    }
		
		if (tofile) {
			cat(file=outfile, "\n")
			cat(file=outfile, "TOTAL DE INDIVIDUOS = ", n)
		}	
	}
	
	if (tofile) {
		close(outfile)
	}
	
	return(result)
}