FROM alpine:3.7
MAINTAINER leo.lou@gov.bc.ca

ENV SS_VER=3.2.0.1227 \
    SS_HOME=/sonar-scanner

ARG sonarToken \
    gitURL \
    gitTag \
    projectKey

RUN apk update \
  && apk add --no-cache --virtual .dev wget unzip git \
  && git config --global url.https://github.com/.insteadOf git://github.com/ \
  && wget -O /tmp/ss.zip https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$ENV SS_VER-linux.zip \
  && unzip /tmp/ss.zip -d /tmp \
  && mv /tmp/sonar-scanner-$SS_VER-linux/ $SS_HOME \
  && export JAVA_HOME=$SS_HOME/jre \
  && export PATH=$SS_HOME/bin:$SS_HOME/jre/bin:$PATH \
  && export LD_LIBRARY_PATH=$SS_HOME/lib:$SS_HOME/jre/lib:$LD_LIBRARY_PATH \
  && chmod -R 755 $SS_HOME/bin $SS_HOME/jre/bin $SS_HOME/lib:$SS_HOME/jre/lib
  && apk del .dev
  
CMD sonar-scanner
