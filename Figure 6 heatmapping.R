#for heatmap(), input needs to be a numeric matrix
#here, normalised data before using R for heatmapping (each parameter scaled to between 0 and 1). Each represented in 2 columns, LPS- and LPS+

#to reorder the matrix as desired:
final_mat<-clean_mat[,c(9,10,13,14,3,4,5,6,7,8,1,2,11,12)]

#to generate names for labelling
names <- as.matrix(clean_data[1])

#to generate names list to only show DMSO and BAY61 (NA has already been filtered from entire matrix)
ctrl_names <- gsub("ARUK*?([0-9]+).*", NA, names)

#to plot
library(viridis)
heatmap(final_mat, Colv=NA, scale = "none", col = viridis(256), labRow = ctrl_names)

#to save (viridis must be loaded first)
png("230613 full heatmap ctrl names only.png", height = 6, width = 6, units = 'in', res = 600)
heatmap(final_mat, Colv=NA, scale = "none", col = viridis(256), labRow = ctrl_names)
dev.off()

#to alter colnames so they fit on plot
colnames(f_mat) <- c("Neuron -", "Neuron +", "Microglia -", "Microglia +", "Astrocyte -", "Astrocyte +", "Necrotic -", "Necrotic +", "Cond -", "Cond +", "Other -", "Other +", "Debris -", "Debris +", "M Morph -", "M Morph +")

#TO GENERATE HEATMAP OF HITS ONLY::::

#load in hit list of ARUK IDs (ID CONVERSION folder)
hits_ARUK <- read.csv("Hits ARUK IDs.csv", header = FALSE)
#convert from factors to characters
hits_ARUK_char <- data.frame(lapply(hits_ARUK, as.character), stringsAsFactors=FALSE)
#filter f_mat by rownames matching hit list
hit_mat <- f_mat[rownames(f_mat) %in% hits_ARUK_char$V1,]
#plot new hm
heatmap(hit_mat, Colv=NA, scale = "none", col = viridis(256))


#Adding colour labels to hits heatmap
setwd("C:/Users/timjy/OneDrive - University of Cambridge/CAMBRIDGE PHD/Biochemistry/Experiments/ADDI HTS/FINAL SCREEN DATA AND ANALYSIS")
ARUKID_to_labels <- read.csv("Hit ARUK IDs to target type label.csv")
hits_ARUK_char_labels <- left_join(hits_ARUK_char, ARUKID_to_labels, by = c("V1" = "Treatment"))
hits_ARUK_char_labels_cols <- hits_ARUK_char_labels %>% mutate(Colour = case_when(startsWith(Label, "Other") ~ "azure2", startsWith(Label, "Steroid") ~ "cadetblue2", startsWith(Label, "Adrenergic") ~ "coral2", startsWith(Label, "MAPK") ~ "darkorchid2"))
heatmap(hit_mat, Colv=NA, scale = "none", col = viridis(256), RowSideColors = hits_ARUK_char_labels_cols$Colour)

#was not able to get legend to work on heatmap. Plotted separately - can edit in
png("230613 hits heatmap legend plot.png", height = 6, width = 6, units = 'in', res = 600)
plot(1,1)
legend(x="top", legend = c("Other", "Adrenergic signalling", "Steroid signalling", "MAPK signalling"), fill = c("azure2", "coral2", "cadetblue2", "darkorchid2"), cex = 1, bty = "n")
dev.off()

#replacing ARUK IDs with RecodeIDs
setwd("C:/Users/timjy/OneDrive - University of Cambridge/CAMBRIDGE PHD/Biochemistry/Experiments/ADDI HTS/FINAL SCREEN DATA AND ANALYSIS/ID CONVERSIONS")
IDtable <- read.csv("Hits All IDs.csv")
hits_all_labels_colours <- left_join(hits_ARUK_char_labels_cols, IDtable, by = c("V1" = "ARUK.ID"))
heatmap(hit_mat, Colv=NA, scale = "none", col = viridis(256), RowSideColors = hits_all_labels_colours$Colour, labRow = hits_all_labels_colours$RecodeID)

#reran most of above but including DMSO in original 'Hit ARUK IDs' to eventually include in hit heatmap


