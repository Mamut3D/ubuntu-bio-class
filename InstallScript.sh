#!/bin/bash  
#Poznámky k instalaci
#
#Software, pro který nebyl k dispozici instalační balíček je nainstalován v /opt/
#
#Programy s grafickým (např fastqc) rozhraním je možno spouštet přes SSH a X11 prostřednictvím parametru -Y
#	ssh root@147.251.253.** -X
#
#Newbler
#Spouští se graficky ssh -X, s příkazem gsAssembler

set -e

#Add repos and stuff
echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
apt-get update



#Install wget and stuff
apt-get install wget -y
apt-get install git -y
apt-get install libc6-dev cpp gcc g++ zlib1g-dev -y
apt-get install  devscripts build-essential -y

apt-get install rpm2cpio cpio -y 

#apt-get install autofs -y
#echo 'X11Forwarding yes' >> /etc/ssh/sshd_config
#/etc/init.d/ssh restart

#RStudio
apt-get install r-base r-base-dev -y
cd
apt-get install libgstreamer-plugins-base0.10-0 libgstreamer0.10-0 libjpeg62 liborc-0.4-0 libxslt1-dev libedit2 -y
wget https://download1.rstudio.org/rstudio-0.99.892-amd64.deb -P $HOME/
dpkg -i $HOME/rstudio-0.99.892-amd64.deb
rm -rf $HOME/rstudio-0.99.892-amd64.deb

#BioConductor packages for R
cd
cat > install_update_bioconductor.r <<- EOM
#!/usr/bin/Rscript
### BioC Packages for R.
source("http://www.bioconductor.org/biocLite.R")
biocLite()
biocLite("made4")
biocLite("hgu133plus2")
biocLite("hgu133plus2cdf")
biocLite("hgu133plus2probe")
biocLite("Heatplus")
biocLite("biomaRt")
EOM
chmod +x install_update_bioconductor.r
./install_update_bioconductor.r

#Server install
#apt-get install gdebi-core -y
wget https://download2.rstudio.org/rstudio-server-0.99.892-amd64.deb -P $HOME/
dpkg -i $HOME/rstudio-server-0.99.892-amd64.deb
echo "server-app-armor-enabled=0" >> /etc/rstudio/rserver.conf
#Run server
/usr/lib/rstudio-server/bin/rserver


#Add test user...
useradd -m testuser -s /bin/bash
echo -e "Asdf1234.\nAsdf1234." | (passwd testuser)

#Piacrd-tools
apt-get install Picard-tools -y

#Samtools
apt-get install samtools -y

#FastQC
apt-get install default-jre FastQC -y


apt-get install Trimmomatic -y

#GenomeAnalysisTK BWA
#http://gatkforums.broadinstitute.org/wdl/discussion/2899/howto-install-all-software-packages-required-to-follow-the-gatk-best-practices
cd
wget http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.13.tar.bz2 -P $HOME/
tar -jxf $HOME/bwa-0.7.13.tar.bz2 -C /opt/
rm -rf $HOME/bwa-0.7.13.tar.bz2
cd /opt/bwa-0.7.13/
make
echo "export PATH=\$PATH:/opt/bwa-0.7.13" >> $HOME/.bashrc

#MuTect
#instals Java jar to /opt/muTect...
#https://www.broadinstitute.org/cancer/cga/mutect_download
cd
wget http://www.broadinstitute.org/cancer/cga/sites/default/files/data/tools/mutect/muTect-1.1.4-bin.zip -P $HOME/
mkdir /opt/muTect
unzip muTect-1.1.4-bin.zip -d /opt/muTect/
rm -rf $HOME//muTect-1.1.4-bin.zip


#BCFtools
cd
wget https://github.com/samtools/bcftools/releases/download/1.3/bcftools-1.3.tar.bz2 -P $HOME/
tar -jxf $HOME/bcftools-1.3.tar.bz2 -C $HOME
rm -rf $HOME/bcftools-1.3.tar.bz2
cd $HOME/bcftools-1.3
make
make prefix=/opt/bcftools install
echo "export PATH=\$PATH:/opt/bcftools/bin" >> $HOME/.bashrc


#Newbler
#http://jeff.wintersinger.org/posts/2013/07/how-to-run-454s-gs-de-novo-assembler-newbler-v28-in-ubuntu-1204/
# Install 32-bit version of libs needed for JRE packaged with Newbler
#apt-get install libxi6 libxtst6 -y
#apt-get install libxi6:i386 libxtst6:i386 rpm2cpio -y
cd
wget http://454.com/downloads/DataAnalysis_2.9_All_20130530_1559.tgz -P $HOME/
tar -xzf $HOME/DataAnalysis_2.9_All_20130530_1559.tgz -C /opt
rm -rf $HOME/DataAnalysis_2.9_All_20130530_1559.tgz
cd /opt/DataAnalysis_2.9_All/packages
# Extract RPMs
for foo in *.rpm; do rpm2cpio $foo | cpio -idmv; done
echo "export PATH=\$PATH:/opt/DataAnalysis_2.9_All/packages/opt/454/apps/assembly/bin" >> $HOME/.bashrc


#SOAP2-denovo
#https://github.com/aquaskyline/SOAPdenovo2
cd /opt
git clone https://github.com/aquaskyline/SOAPdenovo2.git SOAPdenovo2
cd SOAPdenovo2
make 
echo "export PATH=\$PATH:/opt/SOAPdenovo2" >> $HOME/.bashrc

#GapCloser
#http://www.vcru.wisc.edu/simonlab/bioinformatics/programs/install/soapgapcloser.htm
cd
wget http://downloads.sourceforge.net/project/soapdenovo2/GapCloser/bin/r6/GapCloser-bin-v1.12-r6.tgz -P $HOME/
mkdir /opt/GapCloser
tar -xzf $HOME/GapCloser-bin-v1.12-r6.tgz -C /opt/GapCloser
rm -rf $HOME/GapCloser-bin-v1.12-r6.tgz
echo "export PATH=\$PATH:/opt/GapCloser" >> $HOME/.bashrc


#SPADES
cd
wget http://spades.bioinf.spbau.ru/release3.7.0/SPAdes-3.7.0-Linux.tar.gz -P $HOME/
tar -xzf $HOME/SPAdes-3.7.0-Linux.tar.gz -C /opt/
rm -rf $HOME/SPAdes-3.7.0-Linux.tar.gz
echo "export PATH=\$PATH:/opt/SPAdes-3.7.0-Linux/bin" >> $HOME/.bashrc



#QUAST
cd
apt-get install python-matplotlib -y
wget https://downloads.sourceforge.net/project/quast/quast-3.2.tar.gz -P $HOME/
tar -xzf $HOME/quast-3.2.tar.gz -C /opt/
rm -rf $HOME/quast-3.2.tar.gz
cd /opt/quast-3.2
./install_full.sh








