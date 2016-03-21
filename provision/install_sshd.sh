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

COMFY_CONFIG_URL="https://raw.githubusercontent.com/CESNET/comfy/master/lib/templates/ubuntu/files/sshd_config"
LOCAL_SSHD_CONFIG="/etc/ssh/sshd_config"

# Install
apt-get -y -qq install openssh-server openssh-client

# Configure
wget "$COMFY_CONFIG_URL" -O "$LOCAL_SSHD_CONFIG"

# Restart services
/usr/sbin/service ssh restart
