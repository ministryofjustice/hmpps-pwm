FROM tomcat:9
EXPOSE 8080

RUN apt-get update -y
RUN apt-get install gettext-base apache2-utils -y

ARG VERSION=1.9.1
ARG BUILD='v1.9.1'
ARG RELEASE_TYPE=release

ENV PWM_VERSION         ${VERSION}
ENV PWM_APPLICATIONPATH /usr/local/pwm
ENV CONFIG_XML_BASE64   'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPFB3bUNvbmZpZ3VyYXRpb24gcHdtVmVyc2lvbj0iJHtQV01fVkVSU0lPTn0iIHhtbFZlcnNpb249IjQiIGNyZWF0ZVRpbWU9IjE5NzAtMDEtMDFUMDA6MDA6MDBaIj4KICA8cHJvcGVydGllcyB0eXBlPSJjb25maWciPgogICAgPHByb3BlcnR5IGtleT0ic2F2ZUNvbmZpZ09uU3RhcnQiPnRydWU8L3Byb3BlcnR5PgogIDwvcHJvcGVydGllcz4KICA8c2V0dGluZ3M+CiAgICA8c2V0dGluZyBrZXk9InB3bS5zZWN1cml0eUtleSIgc3ludGF4PSJQQVNTV09SRCI+CiAgICAgIDxsYWJlbD5TZWN1cml0eSBLZXk8L2xhYmVsPgogICAgICA8dmFsdWUgcGxhaW50ZXh0PSJ0cnVlIj4xMjM0NTY3ODkwMTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjwvdmFsdWU+CiAgICA8L3NldHRpbmc+CiAgPC9zZXR0aW5ncz4KPC9Qd21Db25maWd1cmF0aW9uPg=='

# COPY pwm-1.9.1.war "${CATALINA_HOME}/webapps/ROOT.war"
RUN curl -f https://www.pwm-project.org/artifacts/pwm/${RELEASE_TYPE}/${BUILD}/pwm-${VERSION}.war -o "${CATALINA_HOME}/webapps/ROOT.war"
RUN mkdir -p "${PWM_APPLICATIONPATH}/logs"
RUN echo 'Initializing PWM...' > "${PWM_APPLICATIONPATH}/logs/PWM.log"
COPY startup.sh .
CMD ["./startup.sh"]