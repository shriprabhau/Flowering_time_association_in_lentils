library(rMVP)
genotype <- attach.big.matrix("fmvp.geno.desc")
phenotype <- read.table("fmvp.phe",head=TRUE)
map <- read.table("fmvp.geno.map" , head = TRUE)

fMVP <- MVP(
	         phe=phenotype,
		    geno=genotype,
		    map=map,
	 		  #K=Kinship,
			  #CV.GLM=Covariates,     ##if you have additional covariates, please keep there open.
			  #CV.MLM=Covariates,
			  #CV.FarmCPU=Covariates,
			  nPC.GLM=5,      ##if you have added PC into covariates, please keep there closed.
			  nPC.MLM=3,
			  nPC.FarmCPU=3,
			  priority="memory",       ##for Kinship construction
			  #ncpus=10,
                          vc.method="BRENT",      ##only works for MLM
			  maxLoop=10,
		          method.bin="static",      ## "FaST-LMM", "static" (#only works for FarmCPU)
					#permutation.threshold=TRUE,
					#permutation.rep=100,
					threshold=0.05,
					method=c("GLM", "MLM", "FarmCPU"),
					out="dtf_result"
							)
