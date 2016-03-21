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

# Paths
INSTALL_PATH="/opt"
TEMP_PATH="/tmp"
PATH_FILE="$INSTALL_PATH/bio_paths.sh"
LOCAL_REPO="/var/local-rstudio-repo"
CHPASSWD="/tmp/chpasswd.xp"

# User details
USERNAME="student"
#PASSWORD=""
