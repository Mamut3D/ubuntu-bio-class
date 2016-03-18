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

# Add a non-root user account
adduser "$USERNAME" --shell /bin/bash  --disabled-login

# Load custom paths
cat >> "/home/$USERNAME/.bashrc" <<- EOF

# Load custom paths for BIO software
if [ -f "$PATH_FILE" ]; then
	source "$PATH_FILE"
fi
EOF