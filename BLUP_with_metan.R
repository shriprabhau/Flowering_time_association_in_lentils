library(tidyverse)
library(metan)
data = read.table("DTF_covariate.txt",header = T, sep = "\t")

#Remove missing values
data = data %>% filter(!is.na(DTF))

#Plot phenotype distribution
plot(density(data$DTF), main = "Phenotype value distribution",
          xlab = "Phenotype, N = 15591",
	       ylab = "Density",
	       col = "red") #Three different regions??
par(
      family = "serif",  # Change to "sans", "mono", or other font families as needed
        font.main = 2,     # Bold main title
        font.lab = 2,      # Plain axis labels
	  font.axis = 1,     # Plain axis numbers
	  cex.main = 1.3,    # Increase main title size
	    cex.lab = 1.1,     # Increase axis label size
	    cex.axis = 1       # Increase axis number size
	    )

plot(
       density(data$DTF),
         main = "Phenotype value distribution",
         xlab = "Phenotype values (N = 15591)",
	   ylab = "Density",
	   col = "red",
	     lwd = 2
	     )
grid()


#BLUP

data$ENV = paste0(data$Location_x,"_",data$Year_x)

mixed_mod = gamem_met(data, env = ENV, gen = Name,
		                            rep=Rep, resp = DTF,
					                          random = "gen",
					                          verbose = T)
plot(mixed_mod)
mm_dt = get_model_data(mixed_mod,"lrt")
print.table(mm_dt)

BLUPS=print.table(mixed_mod$DTF$BLUPgen)
dim(BLUPS)
head(BLUPS)
#Plot BLUP value distribution
plot(density(BLUPS$BLUPg), main = "Density Plot of BLUP  pre outlier removal", 
          xlab = "BLUPg", 
	       ylab = "Density",
	       col = "red",
	            lwd = 2) 

#Remove outliers
m=mean(BLUPS$BLUPg)
s=sd((BLUPS$BLUPg))
gbv = BLUPS$BLUPg
index = which(gbv<(m-3*s))

gbv = gbv[-index]

#Plot BLUP value distribution after removing outliers

par(
      family = "serif",  # Change to "sans", "mono", or other font families as needed
        font.main = 2,     # Bold main title
        font.lab = 2,      # Plain axis labels
	  font.axis = 1,     # Plain axis numbers
	  cex.main = 1.3,    # Increase main title size
	    cex.lab = 1.1,     # Increase axis label size
	    cex.axis = 1       # Increase axis number size
	    )

plot(density(gbv),
          main="BLUP value distribution",
	       xlab = "BLUP values (N = 322)",
	       ylab = "Density",
	            col = "red",
	            lwd = 2)


