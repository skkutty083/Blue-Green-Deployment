# ---- Stage 1: Build the application ----
FROM eclipse-temurin:17-jdk-jammy AS builder

WORKDIR /usr/src/app

# Copy everything
COPY . .

# Ensure mvnw is executable
RUN chmod +x mvnw

# Build the JAR (skip tests for faster CI builds)
RUN ./mvnw clean package -DskipTests

# ---- Stage 2: Run the application ----
FROM eclipse-temurin:17-jdk-jammy

ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME

# Copy only the JAR from the builder stage
COPY --from=builder /usr/src/app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
