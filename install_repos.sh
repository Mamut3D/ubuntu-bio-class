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

# Add repositories
echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/rstudio-trusty.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -

# Create a local repository for rstudio* packages
mkdir -p "$LOCAL_REPO"
echo "deb file:$LOCAL_REPO/ ./" > /etc/apt/sources.list.d/local-rstudio-repo.list
wget https://download1.rstudio.org/rstudio-0.99.892-amd64.deb -P "$LOCAL_REPO"
wget https://download2.rstudio.org/rstudio-server-0.99.892-amd64.deb -P "$LOCAL_REPO"
dpkg-scanpackages "$LOCAL_REPO" | gzip > "$LOCAL_REPO/Packages.gz"

# Update index
apt-get update
