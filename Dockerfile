# Use a lightweight Nginx image
FROM nginx:alpine

# Copy your static files to the Nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
