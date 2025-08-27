FROM n8nio/n8n

# Switch to the root user to install packages
USER root

# Install curl for making HTTP requests and jq for parsing JSON
RUN apk add --no-cache curl jq

# Copy the custom entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Switch back to the default node user
USER node

# Set the new entrypoint for the container
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]