#!/bin/bash

# Exit immediately if a command fails
set -e  

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Create application.properties file with environment variables
log "Creating application.properties..."
sudo tee /opt/csye6225/webapp/application.properties > /dev/null <<EOT
# Application Configuration
spring.datasource.url=jdbc:postgresql://localhost:5432/${DB_NAME}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
spring.jpa.hibernate.ddl-auto=update
server.port=8080
EOT

# Set up systemd service
sudo systemctl daemon-reload
sudo systemctl enable webapp.service

# Set proper permissions for application.properties
log "Setting proper permissions for application.properties..."
sudo chown csye6225:csye6225 /opt/csye6225/webapp/application.properties
sudo chmod 600 /opt/csye6225/webapp/application.properties

log "Setup complete!"