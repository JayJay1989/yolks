#!/bin/bash

#
# Copyright (c) 2021 Matthew Penner
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $NF;exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

sleep .05
printf ""
sleep .05
printf " ____  _            _        _           _          ____               _    \n"
sleep .05
printf "| __ )| | ___   ___| | _____| |__   __ _(_)_ __    / ___|_ __ ___  ___| | __\n"
sleep .05
printf "|  _ \| |/ _ \ / __| |/ / __| '_ \ / _' | | '_ \  | |   | '__/ _ \/ _ \ |/ /\n"
sleep .05
printf "| |_) | | (_) | (__|   < (__| | | | (_| | | | | | | |___| | |  __/  __/   < \n"
sleep .05
printf "|____/|_|\___/ \___|_|\_\___|_| |_|\__,_|_|_| |_|  \____|_|  \___|\___|_|\_\\"
sleep .05
printf "\n"
sleep .05

# Print Java version
printf "\033[1m\033[33mBlockchain Creek]: \033[0mJava version: "
java -version 2>&1 | fgrep -i version | cut -d'"' -f2 | sed -e 's/^1\./1\%/' -e 's/\..*//' -e 's/%/./'
printf "\n"
# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mBlockchain Creek]: \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}
