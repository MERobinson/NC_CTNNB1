


Sys.setenv(PATH=paste(Sys.getenv("PATH"), "/Users/mer92/opt/miniconda3/bin", sep=":"))
bedfiles <- list.files(".", pattern = ".bed")
names(bedfiles) <- sub("^(Bcat|Ik13)_.+_(UP|DN|WT|UN|denovo|lost).bed$", "\\1_\\2", bedfiles)
bwfiles <- list.files("../../tracks", pattern = ".bw", 
                      recursive = T, full.names = T)
bwfiles <- bwfiles[grep("peakscaled|input", bwfiles)]
bwfiles <- bwfiles[grep("rxscaled|public", bwfiles, invert = T)]
names(bwfiles) <- sub("^.+BcatGOF_(.+)_ChIP.+(r[0-9]).+$", "\\1_\\2", bwfiles)
names(bwfiles)[29:30] <- c("pooled_input","bcat_input")
system(paste("computeMatrix reference-point",
             "--regionsFileName", paste(bedfiles[c(1,5,4,2,3)], collapse = " "),
             "--scoreFileName", paste(bwfiles[c(30,27,25,19,20)], collapse = " "),
             "-a 2000 -b 2000 --referencePoint center",
             "-o Bcat_DB_regions_covmatrix.mat"))
system(paste("plotHeatmap -m Bcat_DB_regions_covmatrix.mat -o Bcat_DB_regions_heatmap.svg",
             "--colorList 'white,grey,black' 'white,#eed8d8,#800000' 'white,#ffd5d5,#d43c3c'",
             "'white,#e8f3e8,#003300' 'white,#e8f3e8,#003300'"))