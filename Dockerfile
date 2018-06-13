FROM maven:3.3.9-jdk-8

ENV JAVA_OPTS=""

EXPOSE 8080

ADD src/test/java/no/difi/dificamp/demodifi $MAVEN_HOME


RUN cd $MAVEN_HOME \
 && mvn -B clean package \
 && app=$(ls $MAVEN_HOME/target/*.jar | head -1) \
 && mv $app /app.jar \
 && rm -r $MAVEN_HOME

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar"]
