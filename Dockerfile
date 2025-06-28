# Multi-stage Dockerfile for Employee Management System
# Stage 1: Build the application with Maven
FROM maven:3.8.6-openjdk-8-slim AS builder

# Set working directory
WORKDIR /app

# Copy Maven configuration first (for better layer caching)
COPY pom.xml .

# Download dependencies (this layer will be cached unless pom.xml changes)
RUN mvn dependency:go-offline -B

# Copy source code and build files
COPY src ./src
COPY WebContent ./WebContent

# Build the application
RUN mvn clean package -DskipTests=true

# Stage 2: Runtime
FROM tomcat:9.0-jdk8-openjdk-slim

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from builder stage
COPY --from=builder /app/target/ems.war /usr/local/tomcat/webapps/ems.war

# Configure Tomcat (copy config files if they exist)
COPY docker/server.xml /usr/local/tomcat/conf/server.xml
COPY docker/context.xml /usr/local/tomcat/conf/context.xml

# Set JVM environment variables
ENV CATALINA_OPTS="-Xmx1536m -Xms512m -server -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:G1HeapRegionSize=16m -XX:+UseStringDeduplication -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+DisableExplicitGC"
ENV JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF-8 -Djava.net.preferIPv4Stack=true"

# Database connection environment variables
ENV DB_HOST=ems_mysql_db
ENV DB_PORT=3306
ENV DB_NAME=ems_database
ENV DB_USER=ems_user
ENV DB_PASSWORD=ems_password

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/ems/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
