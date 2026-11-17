# Step 1: Build stage using Maven and Java 17
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and source code to compile
COPY pom.xml .
COPY src ./src

# Package application into an executable JAR file (skipping tests)
RUN mvn clean package -DskipTests

# Step 2: Runtime stage using lightweight JRE 17
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/app.jar app.jar

# Expose port 8080
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
