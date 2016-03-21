#!/bin/bash

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

source $(dirname $0)/../common/env.sh

# Clean-up and set correct permissions on $PATH_FILE
echo > "$PATH_FILE"
chmod 644 "$PATH_FILE"

# Install dependencies
apt-get -y -qq install rpm2cpio python-matplotlib
#apt-get -y -qq install libxi6 libxtst6 libxi6:i386 libxtst6:i386

# Install BIO tools available as official packages
apt-get -y -qq install Picard-tools samtools default-jre FastQC Trimmomatic

# Install GenomeAnalysisTK BWA
# See http://gatkforums.broadinstitute.org/wdl/discussion/2899/howto-install-all-software-packages-required-to-follow-the-gatk-best-practices
wget http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.13.tar.bz2 -P "$TEMP_PATH"
tar -jxf "$TEMP_PATH/bwa-0.7.13.tar.bz2" -C "$INSTALL_PATH/"
cd "$INSTALL_PATH/bwa-0.7.13/"
make
rm "$TEMP_PATH/bwa-0.7.13.tar.bz2"
echo "export PATH=\$PATH:$INSTALL_PATH/bwa-0.7.13" >> "$PATH_FILE"

# Install MuTect
# See https://www.broadinstitute.org/cancer/cga/mutect_download
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/mutect/muTect-1.1.4-bin.zip -P "$TEMP_PATH"
mkdir "$INSTALL_PATH/muTect"
unzip "$TEMP_PATH/muTect-1.1.4-bin.zip" -d "$INSTALL_PATH/muTect"
rm "$TEMP_PATH/muTect-1.1.4-bin.zip"
# No PATH here, just muTect-1.1.4.jar

# Install BCFtools
wget https://github.com/samtools/bcftools/releases/download/1.3/bcftools-1.3.tar.bz2 -P "$TEMP_PATH"
tar -jxf "$TEMP_PATH/bcftools-1.3.tar.bz2" -C "$INSTALL_PATH"
cd "$INSTALL_PATH/bcftools-1.3"
make
rm "$TEMP_PATH/bcftools-1.3.tar.bz2"
echo "export PATH=\$PATH:$INSTALL_PATH/bcftools-1.3" >> "$PATH_FILE"

# Install Newbler
# See http://jeff.wintersinger.org/posts/2013/07/how-to-run-454s-gs-de-novo-assembler-newbler-v28-in-ubuntu-1204/
wget http://454.com/downloads/DataAnalysis_2.9_All_20130530_1559.tgz -P "$TEMP_PATH"
tar -xzf "$TEMP_PATH/DataAnalysis_2.9_All_20130530_1559.tgz" -C "$TEMP_PATH"
cd /
for RPM_PKG in "$TEMP_PATH"/DataAnalysis_2.9_All/packages/*.rpm; do rpm2cpio $RPM_PKG | cpio -idmv; done
cd /
rm -rf "$TEMP_PATH"/DataAnalysis_2.9_All*
echo "export PATH=\$PATH:$INSTALL_PATH/454/apps/assembly/bin" >> "$PATH_FILE"

# Install SOAP2-denovo
# See https://github.com/aquaskyline/SOAPdenovo2
git clone https://github.com/aquaskyline/SOAPdenovo2.git "$INSTALL_PATH/SOAPdenovo2"
cd "$INSTALL_PATH/SOAPdenovo2"
make
echo "export PATH=\$PATH:$INSTALL_PATH/SOAPdenovo2" >> "$PATH_FILE"

# Install GapCloser
# See http://www.vcru.wisc.edu/simonlab/bioinformatics/programs/install/soapgapcloser.htm
wget http://downloads.sourceforge.net/project/soapdenovo2/GapCloser/bin/r6/GapCloser-bin-v1.12-r6.tgz -P "$TEMP_PATH"
mkdir "$INSTALL_PATH/GapCloser-1.12"
tar -xzf "$TEMP_PATH/GapCloser-bin-v1.12-r6.tgz" -C "$INSTALL_PATH/GapCloser-1.12"
rm "$TEMP_PATH/GapCloser-bin-v1.12-r6.tgz"
echo "export PATH=\$PATH:$INSTALL_PATH/GapCloser-1.12" >> "$PATH_FILE"

# Install SPADES
wget http://spades.bioinf.spbau.ru/release3.7.0/SPAdes-3.7.0-Linux.tar.gz -P "$TEMP_PATH"
tar -xzf "$TEMP_PATH/SPAdes-3.7.0-Linux.tar.gz" -C "$INSTALL_PATH"
rm "$TEMP_PATH/SPAdes-3.7.0-Linux.tar.gz"
echo "export PATH=\$PATH:$INSTALL_PATH/SPAdes-3.7.0-Linux/bin" >> "$PATH_FILE"

# Install QUAST
wget https://downloads.sourceforge.net/project/quast/quast-3.2.tar.gz -P "$TEMP_PATH"
tar -xzf "$TEMP_PATH/quast-3.2.tar.gz" -C "$INSTALL_PATH"
cd "$INSTALL_PATH/quast-3.2"
rm "$TEMP_PATH/quast-3.2.tar.gz"
echo "export PATH=\$PATH:$INSTALL_PATH/quast-3.2" >> "$PATH_FILE"
