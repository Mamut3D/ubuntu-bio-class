FROM ubuntu:14.04

MAINTAINER MetaCloud Team <cloud@metacentrum.cz>
LABEL version="1.0" build="Fri Mar 18 17:30:22 CET 2016"

# Copy installation scripts
ADD install_* /tmp/
ADD install_bioconductor.r /opt/

# Install software
RUN /tmp/install_repos.sh
RUN /tmp/install_sshd.sh
RUN /tmp/install_rstudio.sh
RUN /tmp/install_ext.sh
RUN /tmp/install_users.sh
RUN /tmp/install_finalize.sh

# Expose RStudio + SSH
EXPOSE 8787 22

# Start rstudio-server by default
CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize", "0"]
