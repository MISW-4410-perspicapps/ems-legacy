#!/bin/bash

# Maven Build Script for EMS
# This script provides convenient Maven commands for building the EMS application

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Maven is installed
check_maven() {
    if ! command -v mvn >/dev/null 2>&1; then
        print_error "Maven is not installed. Please install Maven and try again."
        print_status "You can install Maven using:"
        echo "  - Ubuntu/Debian: sudo apt-get install maven"
        echo "  - CentOS/RHEL: sudo yum install maven"
        echo "  - macOS: brew install maven"
        exit 1
    fi
    print_success "Maven is available: $(mvn -version | head -1)"
}

# Function to clean the project
clean_project() {
    print_status "Cleaning project..."
    mvn clean
    print_success "Project cleaned"
}

# Function to compile the project
compile_project() {
    print_status "Compiling project..."
    mvn compile
    print_success "Project compiled"
}

# Function to run tests
run_tests() {
    print_status "Running tests..."
    mvn test
    print_success "Tests completed"
}

# Function to package the application
package_application() {
    print_status "Packaging application..."
    mvn package
    print_success "Application packaged successfully"
    echo ""
    print_status "WAR file location: target/ems.war"
}

# Function to install dependencies
install_dependencies() {
    print_status "Installing dependencies..."
    mvn dependency:resolve
    print_success "Dependencies resolved"
}

# Function to display dependency tree
show_dependencies() {
    print_status "Dependency tree:"
    mvn dependency:tree
}

# Function to run full build
full_build() {
    print_status "Running full build..."
    mvn clean compile test package
    print_success "Full build completed"
    echo ""
    print_status "Build artifacts:"
    echo "  - WAR file: target/ems.war"
    echo "  - Classes: target/classes/"
    echo "  - Test results: target/surefire-reports/"
}

# Function to deploy to local Tomcat (if CATALINA_HOME is set)
deploy_local() {
    if [ -z "$CATALINA_HOME" ]; then
        print_warning "CATALINA_HOME is not set. Cannot deploy to local Tomcat."
        print_status "To deploy manually:"
        echo "  1. Copy target/ems.war to your Tomcat webapps directory"
        echo "  2. Restart Tomcat"
        return 1
    fi
    
    print_status "Deploying to local Tomcat..."
    mvn package
    cp target/ems.war "$CATALINA_HOME/webapps/"
    print_success "Deployed to local Tomcat: $CATALINA_HOME/webapps/ems.war"
}

# Function to generate project reports
generate_reports() {
    print_status "Generating project reports..."
    mvn site
    print_success "Reports generated in target/site/"
}

# Main script logic
case "$1" in
    "clean")
        check_maven
        clean_project
        ;;
    "compile")
        check_maven
        compile_project
        ;;
    "test")
        check_maven
        run_tests
        ;;
    "package")
        check_maven
        package_application
        ;;
    "install-deps")
        check_maven
        install_dependencies
        ;;
    "deps")
        check_maven
        show_dependencies
        ;;
    "build")
        check_maven
        full_build
        ;;
    "deploy")
        check_maven
        deploy_local
        ;;
    "reports")
        check_maven
        generate_reports
        ;;
    "docker-build")
        print_status "Building Docker image with Maven..."
        docker build -t ems-app .
        print_success "Docker image built: ems-app"
        ;;
    *)
        echo "EMS Maven Build Script"
        echo ""
        echo "Usage: $0 {clean|compile|test|package|install-deps|deps|build|deploy|reports|docker-build}"
        echo ""
        echo "Commands:"
        echo "  clean        - Clean the project"
        echo "  compile      - Compile source code"
        echo "  test         - Run unit tests"
        echo "  package      - Create WAR file"
        echo "  install-deps - Download and install dependencies"
        echo "  deps         - Show dependency tree"
        echo "  build        - Full build (clean + compile + test + package)"
        echo "  deploy       - Deploy to local Tomcat (requires CATALINA_HOME)"
        echo "  reports      - Generate project reports"
        echo "  docker-build - Build Docker image"
        echo ""
        echo "Examples:"
        echo "  $0 build                # Full build"
        echo "  $0 package              # Create WAR file"
        echo "  $0 deps                 # Show dependencies"
        echo "  $0 docker-build         # Build Docker image"
        exit 1
        ;;
esac
