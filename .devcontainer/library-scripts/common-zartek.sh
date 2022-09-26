#!/usr/bin/env bash

# Syntax: ./common-zartek.sh [install eggnet] [username] [user UID] [user GID] [upgrade packages flag] [install Oh My Zsh! flag] [Add non-free packages]

set -e

INSTALL_EGGNET=${1:-"false"}
SCRIPT_DIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
# Optionally install and configure zsh and Oh My Zsh!
if [ "${INSTALL_EGGNET}" = "true" ]; then

    if [ "${EGGNET_ALREADY_INSTALLED}" != "true" ]; then
        EGGNET_ALREADY_INSTALLED="true"
    fi
    EGGNET_install_dir="${W}/eggnet"
    if [ ! -d "${EGGNET_install_dir}" ]; then
        umask g-w,o-w
        mkdir -p ${EGGNET_install_dir}
        git clone --depth=1 \
            -c core.eol=lf \
            -c core.autocrlf=false \
            -c fsck.zeroPaddedFilemode=ignore \
            -c fetch.fsck.zeroPaddedFilemode=ignore \
            -c receive.fsck.zeroPaddedFilemode=ignore \
            "https://github.com/ohmyzsh/ohmyzsh" "${EGGNET_install_dir}" 2>&1
        # Shrink git while still enabling updates
        cd "${EGGNET_install_dir}"
        git repack -a -d -f --depth=1 --window=1
        # Copy to non-root user if one is specified
        # if [ "${USERNAME}" != "root" ]; then
        #     cp -rf "${user_rc_file}" "${oh_my_install_dir}" /root
        #     chown -R ${USERNAME}:${group_name} "${user_rc_path}"
        # fi
    fi
fi