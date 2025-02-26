# Stage 1: Build the site with Zola
FROM alpine:3.21.3 as builder

# Install Zola
RUN apk add --no-cache zola=0.19.2-r0

# Create and set working directory
WORKDIR /site

# Copy the site content
COPY . .

# Build the site
RUN zola build

# Stage 2: Setup Nginx to serve the site
FROM nginx:alpine

# Copy the built site from the builder stage
COPY --from=builder /site/public /usr/share/nginx/html

# Copy custom Nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Add health check for Coolify
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

# Expose port 80
EXPOSE 80

# Nginx runs automatically in the nginx:alpine image