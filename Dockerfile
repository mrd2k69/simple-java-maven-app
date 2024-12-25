# Stage 1: Build the Java app
FROM maven:3.9.5-eclipse-temurin-17 as build

WORKDIR /app

# Copy source code and build the JAR
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the app in a lightweight image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Command to run the JAR
CMD ["java", "-jar", "app.jar"]
