

# Load all the necessary libraries 
library(dplyr)
library(magrittr)
library(deSolve)
library(NMF)

# Set the working directory to the specified path
setwd("C:/Users/...")

# Read the data from the CSV file and store it in a data frame
data <- read.csv("######.csv", header = TRUE, row.names = 1)

# Convert the data frame into a matrix for NMF processing
mat <- as.matrix(data)

# Identify columns that have a sum of zero (i.e., all zero values)
i0 <- which(colSums(mat) == 0)

# Identify columns that contain NA values (colSums of NA indicators > 0)
i_na <- which(colSums(is.na(mat)) > 0)

# Perform Non-negative Matrix Factorization on the filtered matrix
# Using 4 components and the 'brunet' algorithm with the 'minvol' constraint
# and a specified random seed for reproducibility
res <- nmf(mat[, -c(i0, i_na)], 4, 'brunet', .options = list(constr = "minvol"), seed = 123456)

# Extract the coefficient matrix (H) and basis matrix (W) from the NMF result
H <- coef(res)
W <- basis(res)

# Calculate the progression of each signal over added H2 by normalizing each column of W
# so that its maximum value becomes 1
progression <- apply(W, 2, function(x) x / max(x))

# Calculate the significance of each attribute in the signals by normalizing each row of H
# so that its maximum value becomes 1
significance <- apply(H, 1, function(x) x / max(x))

# --- Plotting the progression of the signals over H2 ---
# Plot the first signal (red line) and then add additional signals
plot(0:49, progression[,1],
     xlab = "Time", ylab = "Signals",
     type = 'l', col = 'red', lwd = 2, cexCol = 8, cexRow = 8)
lines(0:49, progression[,2], col = 'cyan', lwd = 2)
lines(0:49, progression[,3], col = 'brown', lwd = 2)
lines(0:49, progression[,4], col = 'blue', lwd = 2)

# Reorder the rows of the coefficient matrix for custom naming and structure
m_resx <- coef(res)[c(1,4,3,2),]
# Rename rows to indicate different reactive signals 
rownames(m_resx) <- c('RS_1','RS_2','RS_3','RS_4')
# Rename columns to indicate attributes 
colnames(m_resx) <- c("pH","Ca","Mg","Ba","Si","K","S","Quartz","K_Feldspar",
                      "Barite","Pyrite","Dolomite","Anhydrite","Calcite","Illite",
                      "pyrrhotite","H2(g)","H2S(g)")

# --- Heatmap of the reordered coefficient matrix without dendrogram clustering ---
heatmap(t(m_resx),           # Transpose so rows become columns for visualization
        Rowv = NA,           # Disable row clustering
        Colv = NA,           # Disable column clustering
        cexCol = 1.0,
        cexRow = 1.0)








