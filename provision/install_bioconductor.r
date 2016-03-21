#!/usr/bin/Rscript

# -------------------------------------------------------------------------- #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #

source("https://www.bioconductor.org/biocLite.R")
biocLite(ask = FALSE)
biocLite(c("Biobase","biomaRt","GOstats","GOsummaries","RColorBrewer","ReportingTools","affy","annotate","arrayQualityMetrics","beadarray","genefilter","gplots","grid","gtools","hwriter","lattice","limma","lumi","made4","oligo","parallel","preprocessCore","qvalue","vsn","xtable"), ask = FALSE)
biocLite(c("hgu133plus2","hgu133plus2cdf","hgu133plus2probe","Heatplus"), ask = FALSE)
biocLite(c("org.Hs.eg.db","org.Mm.eg.db","org.Rn.eg.db"), ask = FALSE)

library(BiocInstaller)
biocValid()
