# Stage 1: Bygg applikasjonen med Maven
FROM maven:3.8-eclipse-temurin-17 as builder

# Sett arbeidskatalog
WORKDIR /app

# Kopier pom.xml og src-filer til arbeidskatalogen
COPY pom.xml ./
COPY src ./src

# Bygg JAR-filen
RUN mvn package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

# Miljøvariabel for SQS køen
ENV SQS_QUEUE_URL="https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36"

# Sett arbeidskatalog
WORKDIR /app

# Kopier JAR-filen fra builder-stagen
COPY --from=builder /app/target/*.jar /app/application.jar

# Sett opp entrypoint for å kjøre applikasjonen
ENTRYPOINT ["java", "-jar", "/app/application.jar"]
