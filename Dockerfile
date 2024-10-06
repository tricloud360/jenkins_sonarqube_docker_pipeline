# Use an official Nginx image as the base
FROM nginx:alpine

# Create a non-root user and group with IDs 1001
RUN addgroup -g 1001 -S nginx_group && adduser -u 1001 -S nginx_user -G nginx_group

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy the website files (HTML, CSS, JS) to the working directory
COPY . /usr/share/nginx/html

# Change ownership of the working directory to the non-root user
RUN chown -R nginx_user:nginx_group /usr/share/nginx/html

# Switch to the non-root user
USER nginx_user

# Expose port 80 to allow external connections to the container
EXPOSE 80
