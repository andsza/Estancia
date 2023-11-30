library(tidyverse)
library(RColorBrewer)  #paletas de colores (al final no las utilicé)
library(viridis)  # más paletas de colores  (al final no se utilizó)
library(pheatmap)  # para hacer el heatmap


# cargar la tabla

df <- read.csv("heatmap.csv", header=TRUE)

data <- data.matrix(df[ , 2:(ncol(df)-2)])  # solo columnas de los organismos
rownames(data) <- as.vector(df[,1])
#data <- as.numeric(data)

metadata <- df[ , (ncol(df)-1) : ncol(df)]

metadata$Diagnóstico <- ifelse(metadata$Diagnóstico == 0, 'Sano', 'Enfermo')

rownames(metadata) <- as.vector(df[,1])

#Cambiar colores a las barras de anotaciones

group_df = data.frame(Diagnosis=as.factor(metadata$Diagnóstico), Sexo=as.factor(metadata$Sexo))
rownames(group_df) <- rownames(metadata)

annotation_cols <- list(
  Diagnosis = c(Sano="green", Enfermo="black"),
  Sexo = c(male="blue", female="magenta"))


# Generar heatmap

pdf("images/heatmap_2.pdf",width=1500, height=800, pointsize=9)  # para guardar la figura
pheatmap(data,
         color = colorRampPalette(c("blue4","brown2"))(2), 
         legend_breaks = c(1, 0),   # Para separar en dos colores
         legend_labels = c("Presente", "Ausente"), # Para las etiquetas
         cluster_rows = FALSE,   # Para clusterizar por filas
         cluster_cols = TRUE,    # Para clusterizar por columnas
         clustering_method="ward.D", # El método de clusterización
         #cutree_rows = 2,   # Número de clusters de filas
         cutree_cols = 2,    # Número de clusters en columnas
         border_color="black", 
         gaps_row = c(100),
         cellwidth = 2,
         cellheight = 2,
         fontsize = 2,
         treeheight_col = 6,
         treeheight_row = 0,
         annotation_row = group_df,
         annotation_colors = annotation_cols
)

dev.off()   # para concluir el proceso de guardar la figura

getwd()
# Ignora la soguiente parte

# Para obtener las etiquetas de los clusters:
#mat.order <- cbind(data[c(res$tree_row[["order"]]),res$tree_col[["order"]]],cluster=cutree(res$tree_col, k=6)[res$tree_col[["order"]]])





