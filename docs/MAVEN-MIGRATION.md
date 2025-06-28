# Maven Migration Guide for EMS

This document explains how the Employee Management System has been migrated from NetBeans Ant to Maven build system.

## Why Maven?

The migration to Maven solves several issues:

1. **Dependency Management**: No more manual JAR management
2. **Build Reproducibility**: Consistent builds across environments
3. **Docker Compatibility**: Better containerization support
4. **IDE Independence**: Works with any IDE that supports Maven
5. **Standard Project Structure**: Follows Maven conventions

## Project Structure

```
ems-legacy/
├── pom.xml                 # Maven configuration
├── src/                    # Source code (unchanged)
│   └── com/EMS/
├── WebContent/             # Web resources (unchanged)
│   ├── WEB-INF/
│   └── *.jsp
├── target/                 # Maven build output
│   ├── classes/
│   ├── ems.war
│   └── ...
├── mvn-build.sh           # Maven build helper script
└── docker/                # Docker configuration
```

## Dependencies Resolved

Maven automatically handles these dependencies:

- **MySQL Connector**: `mysql-connector-j-8.0.33`
- **Servlet API**: `javax.servlet-api-4.0.1`
- **JSP API**: `javax.servlet.jsp-api-2.3.3`
- **JSTL**: `jstl-1.2`
- **File Upload**: `commons-fileupload-1.4`

## Build Commands

### Using Maven directly:
```bash
# Clean project
mvn clean

# Compile
mvn compile

# Run tests
mvn test

# Create WAR file
mvn package

# Full build
mvn clean package
```

### Using the helper script:
```bash
# Full build
./mvn-build.sh build

# Just package
./mvn-build.sh package

# Show dependencies
./mvn-build.sh deps

# Clean project
./mvn-build.sh clean
```

## Docker Build

The Dockerfile now uses Maven instead of Ant:

```dockerfile
# Build stage with Maven
FROM maven:3.8.6-openjdk-8-slim AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
COPY WebContent ./WebContent
RUN mvn clean package -DskipTests=true

# Runtime stage with Tomcat
FROM tomcat:9.0-jdk8-openjdk-slim
COPY --from=builder /app/target/ems.war /usr/local/tomcat/webapps/ems.war
```

## Migration Benefits

1. **No More NetBeans Dependencies**: 
   - No `org-netbeans-modules-java-j2seproject-copylibstask.jar` needed
   - No NetBeans-specific build configuration

2. **Automatic Dependency Resolution**:
   - MySQL connector downloaded automatically
   - All JEE dependencies managed by Maven
   - Transitive dependencies resolved automatically

3. **Better Docker Builds**:
   - Layer caching for dependencies
   - Smaller final images
   - Reproducible builds

4. **IDE Flexibility**:
   - Works with IntelliJ IDEA
   - Works with Eclipse
   - Works with VS Code
   - Still works with NetBeans

## Configuration Files

### pom.xml
The main Maven configuration file that defines:
- Project metadata
- Dependencies
- Build plugins
- Profiles (dev/prod)

### mvn-build.sh
Helper script that provides convenient commands for common Maven operations.

## Troubleshooting

### Common Issues:

1. **Maven not found**:
   ```bash
   # Install Maven
   sudo apt-get install maven  # Ubuntu/Debian
   sudo yum install maven      # CentOS/RHEL
   brew install maven          # macOS
   ```

2. **Compilation errors**:
   ```bash
   # Check dependencies
   ./mvn-build.sh deps
   
   # Clean and rebuild
   ./mvn-build.sh clean
   ./mvn-build.sh build
   ```

3. **Docker build issues**:
   ```bash
   # Build Docker image
   ./mvn-build.sh docker-build
   ```

## Legacy Ant Support

The original Ant build files are preserved for backward compatibility:
- `build.xml`
- `nbproject/`

You can still use Ant if needed, but Maven is recommended for new development and Docker deployments.

## Next Steps

1. **Use Maven for all builds**: Gradually phase out Ant usage
2. **Add unit tests**: Maven makes testing easier with JUnit integration
3. **Consider Spring Migration**: Maven simplifies adding Spring Framework
4. **Database Migrations**: Consider adding Flyway or Liquibase for database versioning

## Examples

### Build and Deploy with Docker:
```bash
docker compose up -d
```

### Local Development:
```bash
./mvn-build.sh build
./mvn-build.sh deploy  # If CATALINA_HOME is set
```

### Check Dependencies:
```bash
./mvn-build.sh deps
```

This migration provides a solid foundation for modernizing the EMS application while maintaining compatibility with existing code.
