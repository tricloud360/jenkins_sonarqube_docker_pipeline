# Use an official Nginx image as the base
FROM nginx

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy the website files (HTML, CSS, JS) to the working directory
COPY . /usr/share/nginx/html

# Expose port 80 to allow external connections to the container
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]