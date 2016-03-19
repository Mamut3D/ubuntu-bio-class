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

source $(dirname $0)/../common/env.sh

if [ ! -x "/usr/bin/apg" ] || [ ! -x "/usr/bin/expect" ] || [ ! -x  "/usr/bin/passwd" ] ; then
    echo "Required binaries not present in the container: apg, expect, passwd"
    exit 1
fi

# Generate a new password if not set
if [ -z "$PASSWORD" ]; then
    PASSWORD=$(/usr/bin/apg -m 25 -n 1)
    echo "**********************************************"
    echo "**********************************************"
    echo "Generated password:  $PASSWORD"
    echo "**********************************************"
    echo "**********************************************"
fi

# Set password
cat > "$CHPASSWD" <<-EOF
#!/usr/bin/expect

spawn /usr/bin/passwd "$USERNAME"

expect "Enter new UNIX password:"
send "$PASSWORD\r"

expect "Retype new UNIX password:"
send "$PASSWORD\r"

interact
EOF

chmod +x "$CHPASSWD"
eval "$CHPASSWD" > /dev/null 2>&1

# Clean-up
rm "$CHPASSWD"
unset PASSWORD
