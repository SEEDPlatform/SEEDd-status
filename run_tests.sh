
 # SEED Node Status Copyright (C) 2019
 #
 # File Test script for PHP errors and PEAR standards
 # Craig Watson <craig@cwatson.org>
 # SEED Project <info@seednetwork.io>
 # https://www.apache.org/licenses/LICENSE-2.0 Apache License, Version 2.0
 # https://github.com/craigwatson/bitcoind-status
 # https://github.com/SEEDPlatform/SEEDd-status


#!/bin/bash

composer update

PHP_FILES=$(find . -path ./vendor -prune -o -type f -iname "*.php" -print)

echo "--- PHP Syntax"
for PHP_FILE in ${PHP_FILES}; do
  php -l ${PHP_FILE}
  if [ $? -ne 0 ]; then
    exit 1
  fi
done

echo "--- PHP Standards"
for PHP_FILE in ${PHP_FILES}; do
  BASENAME=$(basename ${PHP_FILE})
  if [ "${BASENAME}" != "easybitcoin.php" ]; then
    ./vendor/bin/phpcs --colors -n ${PHP_FILE}
    if [ $? -ne 0 ]; then
      exit 1
    else
      echo "No PEAR standards failures in ${PHP_FILE}"
    fi
  fi
done
