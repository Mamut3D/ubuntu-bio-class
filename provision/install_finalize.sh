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

# Fix locales (attempt)
locale-gen en_US || /bin/true
locale-gen en_US.UTF-8 || /bin/true
update-locale || /bin/true

if [ ! -d "/home/$USERNAME" ] ; then
    echo "User account for $USERNAME does not exist or is missing a home directory"
    exit 1
fi

# Load custom paths
cat >> "/home/$USERNAME/.bashrc" <<- EOF
# Force UTF-8 locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Load custom paths for BIO software
if [ -f "$PATH_FILE" ]; then
    source "$PATH_FILE"
fi
EOF
