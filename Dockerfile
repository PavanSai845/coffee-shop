# Use Nginx base image
FROM nginx:latest

# Remove default content
RUN rm -rf /usr/share/nginx/html/*

# Copy your HTML files
COPY . /usr/share/nginx/html/

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]