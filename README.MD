# PWM - Password Manager

Configurable Docker image for [pwm](https://github.com/pwm-project/pwm) - an open-source password self-service application.

## Build/Run
To build and run the image:
```shell script
docker build -t pwm .
docker run --rm -e "CONFIG_XML_BASE64=$(cat PwmConfiguration.xml.tpl | base64)" pwm
```

## Arguments/Environment
* `CONFIG_XML_BASE64` - Use this environment variable to inject a base64-encoded PwmConfiguration.xml file. 
Any references to other environment variables within the XML will also be substituted at startup.
Default:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<PwmConfiguration pwmVersion="${PWM_VERSION}" xmlVersion="4" createTime="1970-01-01T00:00:00Z">
  <properties type="config">
    <property key="saveConfigOnStart">true</property>
  </properties>
  <settings>
    <setting key="pwm.securityKey" syntax="PASSWORD">
      <label>Security Key</label>
      <value plaintext="true">12345678901234567890123456789012</value>
    </setting>
  </settings>
</PwmConfiguration>
```