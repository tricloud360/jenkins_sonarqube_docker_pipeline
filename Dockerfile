FROM nginx:alpine

# Create necessary directories with the correct permissions
RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R nginx:nginx /var/cache/nginx

# Set working directory inside container
WORKDIR /usr/share/nginx/html


# sonar-ignore-next-line
COPY . /usr/share/nginx/html

# Change ownership to nginx user
RUN chown -R nginx:nginx /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

# Set user to nginx to avoid running as root
USER nginx
