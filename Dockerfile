# Use a multi-arch compatible JDK image
FROM eclipse-temurin:17-jdk-jammy

EXPOSE 8080

ENV APP_HOME /usr/src/app
WORKDIR $APP_HOME

# Copy the application JAR
COPY target/*.jar app.jar

# Run the JAR
CMD ["java", "-jar", "app.jar"]
