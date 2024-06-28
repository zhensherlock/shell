#!/bin/bash
#
# Author: MichaelSun
# Date: 2023/03/18
# Description: QFK Axure Shell Script
#

CONFIG_FILE="qfk_axure.conf"
CONFIG_DIR="/etc/apache2/other/"

echo 'Create the qfk apache configuration file.'

if [[ -e ${CONFIG_DIR}${CONFIG_FILE} ]]; then
  echo "The file already exists. Exiting."
  exit 1
else
  sudo touch ${CONFIG_DIR}${CONFIG_FILE}
fi

if [ $? -ne 0 ]; then
    echo "Failed to create the qfk apache configuration file. Exiting."
    exit 1
fi

sudo sh -c "echo '<FilesMatch \"\.(css|js|swf|php|htm|html)$\">' >> ${CONFIG_DIR}${CONFIG_FILE}"
sudo sh -c "echo '    Header set Cache-Control \"private,no-cache,no-store,proxy-revalidate,no-transform\"' >> ${CONFIG_DIR}${CONFIG_FILE}"
sudo sh -c "echo '    Header set Pragma \"no-cache\"' >> ${CONFIG_DIR}${CONFIG_FILE}"
sudo sh -c "echo '</FilesMatch>' >> ${CONFIG_DIR}${CONFIG_FILE}"

echo "The qfk apache configuration file is created successfully. The file path is ${CONFIG_DIR}${CONFIG_FILE}"

echo 'Apache restarting.'
sudo apachectl restart

echo '/Library/WebServer/Documents'