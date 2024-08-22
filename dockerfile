# Use a Maven image with JDK 17
FROM maven AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files to the container
COPY pom.xml ./

COPY src ./src

# Build the project
RUN mvn clean install -DskipTests


# Use an OpenJDK image to run the app
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
COPY --from=build /app/target/springboot-thymeleaf-crud-web-app-0.0.1-SNAPSHOT.jar app.jar

# Expose the port the application will run on
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
