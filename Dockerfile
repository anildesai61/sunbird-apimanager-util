FROM openjdk:8-jre-alpine

ENV APP_HOME=/opt/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY ./*.jar $APP_HOME/*.jar

EXPOSE 4000

ENTRYPOINT /usr/bin/java ${JAVA_OPTS} -jar adminutil.jar
