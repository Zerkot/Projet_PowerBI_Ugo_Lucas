install.packages(c('shiny', 'leaflet', 'shinydashboard', 'httr', 'jsonlite', 'ggplot2','leaflet.extras','shinyjs','rsconnect','writexl'))
library(shiny)
library(leaflet)
library(shinydashboard)
library(httr)
library(jsonlite)
library(ggplot2)
library(leaflet.extras)
library(shinyjs)
library(rsconnect)
library(writexl)

# Lecture du fichier CSV local
adresse <- read.csv2(file = "adresses-89.csv.gz", header = TRUE, sep = ";", dec = ".")

# Variables et URLs API
code_postal <- "89*"
size <- 10000
df_existants <- data.frame()
df_neufs <- data.frame()
Date_existants <- 2021
Date_neufs <- 2021
base_url_existants <- "https://data.ademe.fr/data-fair/api/v1/datasets/dpe-v2-logements-existants/lines"
base_url_neufs <- "https://data.ademe.fr/data-fair/api/v1/datasets/dpe-v2-logements-neufs/lines"

# Récupération des données depuis l'API
# Pour logements existants
repeat {
  params <- list(
    page = 1,
    size = size,
    select = "N°DPE,Date_réception_DPE,N°_DPE_remplacé,Etiquette_GES,Etiquette_DPE,Type_bâtiment,Type_installation_chauffage,Coordonnée_cartographique_X_(BAN),Coordonnée_cartographique_Y_(BAN),Conso_5_usages_é_finale,Conso_chauffage_é_primaire,Emission_GES_5_usages,Emission_GES_5_usages_par_m²,Emission_GES_chauffage,Emission_GES_chauffage_dépensier,Emission_GES_refroidissement,Type_énergie_n°1,Coût_total_5_usages,Coût_chauffage,Qualité_isolation_enveloppe,Qualité_isolation_murs,Qualité_isolation_plancher_bas",
    q = code_postal,
    q_fields = "Code_postal_(BAN)",
    qs = paste0("Date_réception_DPE:[", Date_existants, "-01-01 TO ", Date_existants, "-12-31]")
  )
  
  url_encoded <- modify_url(base_url_existants, query = params)
  response <- GET(url_encoded, timeout(60))
  
  if (status_code(response) != 200) {
    stop("Erreur dans la requête : ", status_code(response))
  }
  
  content <- fromJSON(rawToChar(response$content), flatten = FALSE)
  data <- content$result
  df_existants <- rbind(df_existants, data)
  
  Date_existants <- Date_existants + 1
  if (Date_existants == 2030) {
    break
  }
  Sys.sleep(2)
}

# Pour logements neufs
repeat {
  params <- list(
    page = 1,
    size = size,
    select = "N°DPE,Date_réception_DPE,N°_DPE_remplacé,Etiquette_GES,Etiquette_DPE,Type_bâtiment,Type_installation_chauffage,Coordonnée_cartographique_X_(BAN),Coordonnée_cartographique_Y_(BAN),Conso_5_usages_é_finale,Conso_chauffage_é_primaire,Emission_GES_5_usages,Emission_GES_5_usages_par_m²,Emission_GES_chauffage,Emission_GES_chauffage_dépensier,Emission_GES_refroidissement,Type_énergie_n°1,Coût_total_5_usages,Coût_chauffage,Qualité_isolation_enveloppe,Qualité_isolation_murs,Qualité_isolation_plancher_bas",
    q = code_postal,
    q_fields = "Code_postal_(BAN)",
    qs = paste0("Date_réception_DPE:[", Date_neufs, "-01-01 TO ", Date_neufs, "-12-31]")
  )
  
  url_encoded <- modify_url(base_url_neufs, query = params)
  response <- GET(url_encoded, timeout(60))
  
  if (status_code(response) != 200) {
    stop("Erreur dans la requête : ", status_code(response))
  }
  
  content <- fromJSON(rawToChar(response$content), flatten = FALSE)
  data <- content$result
  df_neufs <- rbind(df_neufs, data)
  
  Date_neufs <- Date_neufs + 1
  if (Date_neufs == 2030) {
    break
  }
  Sys.sleep(2)
}

df_existants$type_logement <- "Existant"
df_neufs$type_logement <- "Neufs"
df_logement <- rbind(df_existants, df_neufs)
df_logement <- df_logement[!is.na(df_logement$'Coordonnée_cartographique_X_(BAN)') &
                             !is.na(df_logement$'Coordonnée_cartographique_Y_(BAN)'), ]

# Transformation des coordonnées en numérique pour les deux dataframes
df_logement$'Coordonnée_cartographique_X_(BAN)' <- as.numeric(df_logement$'Coordonnée_cartographique_X_(BAN)')
df_logement$'Coordonnée_cartographique_Y_(BAN)' <- as.numeric(df_logement$'Coordonnée_cartographique_Y_(BAN)')

adresse$x <- as.numeric(adresse$x)  
adresse$y <- as.numeric(adresse$y)  

# Jointure entre df_logement et adresse sur les colonnes de coordonnées
df_principale <- merge(df_logement, adresse, 
                       by.x = c("Coordonnée_cartographique_X_(BAN)", "Coordonnée_cartographique_Y_(BAN)"), 
                       by.y = c("x", "y"), 
                       all.x = TRUE)

chemin_fichier <- "F:/BUT/IUT/R Shiny/df_principale.xlsx"
write_xlsx(df_principale, chemin_fichier)