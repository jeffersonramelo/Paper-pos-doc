library(tidyr)
library(dplyr)

# Lê o arquivo XLSX
dados <- read_excel('dados originais_modificados.xlsx')

# Lista de prefixos das variáveis
variaveis <- c("VM", "PU", "Retorno", "PL", "LL", "AT")

# Lista de sufixos de anos
anos <- c("2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022")

# Inicializa uma lista para armazenar os data frames intermediários
dados_intermediarios <- list()

# Loop para criar data frames intermediários para cada variável
for (var in variaveis) {
  cols <- grep(paste0("^", var), names(dados), value = TRUE)
  df <- dados[, c("id", "Nome", "Classe", "Código", "setorbovespa", "subsetor", "setoreconomatica", cols)]
  df <- pivot_longer(df, cols = cols, names_to = "ano", values_to = var)
  dados_intermediarios[[var]] <- df
}

# Combina os data frames intermediários em um único data frame
dados_reorganizados <- bind_rows(dados_intermediarios)

View(dados_reorganizados)

#exportar em xlsx
write_xlsx(dados_reorganizados,path = "C:/Users/jeffe/Downloads/dados2.xlsx")






