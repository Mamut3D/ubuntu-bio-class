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

source $(dirname $0)/install_common.sh

# Install dependencies
apt-get -y -qq install wget git libc6-dev cpp gcc g++ zlib1g-dev devscripts build-essential \
                       rpm2cpio cpio libgstreamer-plugins-base0.10-0 libgstreamer0.10-0 libjpeg62 \
                       liborc-0.4-0 libxslt1-dev libedit2 curl libcurl4-openssl-dev

# Install R
apt-get -y -qq install r-base r-base-dev

# Install RStudio and RStudio-server (from a local repository, see `install_repos.sh`)
apt-get -y -qq install rstudio rstudio-server

# Configure RServer to start in an environment without AppArmor
echo "server-app-armor-enabled=0" >> /etc/rstudio/rserver.conf
