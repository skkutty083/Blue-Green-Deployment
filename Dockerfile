# -------- Build stage --------
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# -------- Runtime stage --------
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /usr/src/app
EXPOSE 8080
COPY --from=build /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
