FROM ubuntu:14.04

MAINTAINER MetaCloud Team <cloud@metacentrum.cz>
LABEL name="ubuntu-bio-class" version="1.0" build="Sat Mar 19 17:38:52 CET 2016" license="Apache License, Version 2.0, January 2004"

# Stage environment
RUN mkdir -p /opt/ubuntu-bio-class/common
RUN mkdir -p /opt/ubuntu-bio-class/provision
RUN mkdir -p /opt/ubuntu-bio-class/run

# Copy scripts
ADD common /opt/ubuntu-bio-class/common/
ADD provision /opt/ubuntu-bio-class/provision/
ADD run /opt/ubuntu-bio-class/run/

# Install software
RUN /opt/ubuntu-bio-class/provision/install_repos.sh
RUN /opt/ubuntu-bio-class/provision/install_sshd.sh
RUN /opt/ubuntu-bio-class/provision/install_rstudio.sh
RUN /opt/ubuntu-bio-class/provision/install_ext.sh
RUN /opt/ubuntu-bio-class/provision/install_users.sh
RUN /opt/ubuntu-bio-class/provision/install_finalize.sh

# Install bioconductor
RUN /opt/ubuntu-bio-class/provision/install_bioconductor.r

# Expose RStudio + SSH
EXPOSE 8787 22

# Start rstudio-server by default
CMD /opt/ubuntu-bio-class/run/run_rstudio.sh
