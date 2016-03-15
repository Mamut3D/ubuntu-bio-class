FROM ubuntu:14.04

MAINTAINER Radim Janca <janca@ics.muni.cz>

# FedCloud stuff
ADD InstallScript.sh /tmp/InstallScript.sh
RUN /tmp/InstallScript.sh

# Expose RStudio web default port
EXPOSE 8787

