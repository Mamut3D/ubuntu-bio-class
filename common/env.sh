## Not executable

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

# End on any non-zero return code
set -e

# Container details
APPLIANCE_NAME="ubuntu-bio-class"
DOCKER_APPLIANCE="arax/$APPLIANCE_NAME"

# User details
USERNAME="student"
#PASSWORD=""

# Paths
INSTALL_PATH="/opt"
TEMP_PATH="/tmp"
PATH_FILE="$INSTALL_PATH/bio_paths.sh"

LOCAL_REPO="/var/local-rstudio-repo"

CHPASSWD="/tmp/chpasswd.xp"
PASS_FILE="/root/$APPLIANCE_NAME.pass"

LOCAL_SHARED="/data/shared"
CONTAINER_SHARED="/data/shared"
LOCAL_PERSISTENT="/data/permanent"
CONTAINER_PERSISTENT="/home/$USERNAME"
LOCAL_AUTH_KEYS_FILES="/root/.ssh/authorized_keys $HOME/.ssh/authorized_keys"

CONTAINER_AUTH_KEYS_FILE_BASE="$LOCAL_PERSISTENT/.ssh"
CONTAINER_AUTH_KEYS_FILE="$CONTAINER_AUTH_KEYS_FILE_BASE/authorized_keys"
CONTAINER_BASHRC="$LOCAL_PERSISTENT/.bashrc"
CONTAINER_PROFILE="$LOCAL_PERSISTENT/.profile"

CI_BASE_DIR="/var/lib/cloud"
CI_PER_BOOT_SCRIPT_BASE="$CI_BASE_DIR/scripts/per-boot"
CI_PER_BOOT_SCRIPT="$CI_PER_BOOT_SCRIPT_BASE/kickstart_$APPLIANCE_NAME.sh"
CI_SCRIPT_PATH="/root/$APPLIANCE_NAME/host/keep_running.sh"
