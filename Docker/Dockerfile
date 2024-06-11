# Use the latest version of the Apache HTTP server image from the Docker Hub
FROM httpd:latest

# Copy the local index.html file to the Apache document root
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 to allow traffic to the Apache server
EXPOSE 80

LABEL version="{{VERSION}}"
