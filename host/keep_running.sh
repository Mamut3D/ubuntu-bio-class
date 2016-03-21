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

# Paths
PASS_FILE="/root/ubuntu-bio-class.pass"
LOCAL_SHARED="/data/shared"
CONTAINER_SHARED="/data/shared"
LOCAL_PERSISTENT="/data/permanent"
CONTAINER_PERSISTENT="/home/$USERNAME"
LOCAL_AUTH_KEYS_FILES="/root/.ssh/authorized_keys $HOME/.ssh/authorized_keys"
CONTAINER_AUTH_KEYS_FILE_BASE="$LOCAL_PERSISTENT/.ssh"
CONTAINER_AUTH_KEYS_FILE="$CONTAINER_AUTH_KEYS_FILE_BASE/authorized_keys"
CONTAINER_BASHRC="$LOCAL_PERSISTENT/.bashrc"
CONTAINER_PROFILE="$LOCAL_PERSISTENT/.profile"

# Docker
DOCKER_APPLIANCE="arax/ubuntu-bio-class"

# Read password from a file, if not already set and the file is available
if [ -z "$PASSWORD" ] && [ -f "$PASS_FILE" ] ; then
    PASSWORD=$(tr -d '\n' < "$PASS_FILE")
fi

# Move .ssh/authorized_keys, if necessary
for LOCAL_AUTH_KEYS_FILE in $LOCAL_AUTH_KEYS_FILES ; do
    if [ -f "$LOCAL_AUTH_KEYS_FILE" ] && [ ! -f "$CONTAINER_AUTH_KEYS_FILE" ] ; then
        mkdir -p "$CONTAINER_AUTH_KEYS_FILE_BASE"
        chmod 755 "$CONTAINER_AUTH_KEYS_FILE_BASE"

        cp "$LOCAL_AUTH_KEYS_FILE" "$CONTAINER_AUTH_KEYS_FILE"
        chmod 600 "$CONTAINER_AUTH_KEYS_FILE"
        break
    fi
done

# Add profile
if [ ! -f "$CONTAINER_PROFILE" ] ; then
    cat > "$CONTAINER_PROFILE" <<- EOF
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "\$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "\$HOME/.bashrc" ]; then
    . "\$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "\$HOME/bin" ] ; then
    PATH="\$HOME/bin:\$PATH"
fi
EOF
fi

# Load custom paths
if [ ! -f "$CONTAINER_BASHRC" ] ; then
    cat > "$CONTAINER_BASHRC" <<- EOF
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case \$- in
    *i*) ;;
      *) return;;
esac

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Force UTF-8 locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Load custom paths for BIO software
if [ -f "$PATH_FILE" ]; then
    source "$PATH_FILE"
fi
EOF
fi

# Wait for resources
until /usr/bin/docker info > /dev/null 2>&1 ; do
    echo "Waiting for docker services to initialize ..."
    sleep 5
done

# Run ubuntu-bio-class, reinitialize after failure (cannot use --restart=always)
#
# Forwarding:
#  => 22   (SSH)
#  => 8787 (RStudio-server)
#
# Mounts:
#  => $LOCAL_SHARED     to $CONTAINER_SHARED     (ro)
#  => $LOCAL_PERSISTENT to $CONTAINER_PERSISTENT (rw)
while /bin/true ; do
    /usr/bin/docker run --rm \
                        -p 2222:22 -p 8787:8787 \
                        -v "$LOCAL_SHARED:$CONTAINER_SHARED:ro" -v "$LOCAL_PERSISTENT:$CONTAINER_PERSISTENT" \
                        -e "PASSWORD=$PASSWORD" \
                        "$DOCKER_APPLIANCE" || /bin/true
    sleep 5 # prevent quick restarts
done
