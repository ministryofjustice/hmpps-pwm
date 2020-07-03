#!/bin/bash

echo 'Generating configuration...'
echo "${CONFIG_XML_BASE64}" | base64 -d > PwmConfiguration.xml.tpl
CONFIG_PASSWORD_HASH=$(htpasswd -bnBC 10 "" "${CONFIG_PASSWORD}" | tr -d ':\n') \
  envsubst <PwmConfiguration.xml.tpl >"${PWM_APPLICATIONPATH}/PwmConfiguration.xml"

echo 'Starting PWM...'
catalina.sh run
