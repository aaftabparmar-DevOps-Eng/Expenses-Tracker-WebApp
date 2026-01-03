#——— Stage 1: Build the JAR ———
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

# Copy source code
COPY . /app

# Build the application and skip tests
RUN mvn clean install -DskipTests=true

#——— Stage 2: Run the app ———
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy the built jar from builder stage
COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

# Expose the app port
EXPOSE 8080

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/target/expenseapp.jar"]

