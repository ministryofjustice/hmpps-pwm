#!/bin/bash

echo 'Generating configuration...'
echo "${CONFIG_XML_BASE64}" | base64 -d > PwmConfiguration.xml.tpl
CONFIG_PASSWORD_HASH=$(htpasswd -bnBC 10 "" "${CONFIG_PASSWORD}" | tr -d ':\n') \
  envsubst <PwmConfiguration.xml.tpl >"${PWM_APPLICATIONPATH}/PwmConfiguration.xml"

echo 'Checking logs for errors...'
# This is required due to a possible timing issue with the 'saveConfigOnStart' option in PWM, that causes it to
# intermittently fail on startup.
# See https://github.com/pwm-project/pwm/issues/557
#
# To workaround the issue, we automatically restart Tomcat if the error occurs in the log
(tail -f "${PWM_APPLICATIONPATH}/logs/PWM.log" | sed '/5053 ERROR_APP_UNAVAILABLE/q' > /dev/null && (
  echo 'Application unavailable. Restarting...'
  mv "${PWM_APPLICATIONPATH}/logs/PWM.log" "${PWM_APPLICATIONPATH}/logs/PWM.log.$(date '+%s%N')"
  catalina.sh stop
)) &

echo 'Starting PWM...'
while true; do catalina.sh run; done
