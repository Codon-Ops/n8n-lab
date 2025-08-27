#!/bin/sh

# entrypoint.sh

echo "Waiting for ngrok to start..."
# Use curl to poll the ngrok API until it's ready
until curl -s http://ngrok:4040/api/tunnels > /dev/null; do
  sleep 1
done

echo "ngrok is ready. Fetching public URL..."

# Fetch the public URL from the ngrok API and export it
# The jq command parses the JSON to get the first tunnel's public_url
export WEBHOOK_URL=$(curl -s http://ngrok:4040/api/tunnels | jq -r ".tunnels[0].public_url")

if [ -z "$WEBHOOK_URL" ]; then
    echo "Failed to fetch ngrok URL. Exiting."
    exit 1
fi

echo "Public URL found: $WEBHOOK_URL"
echo "Starting n8n..."

# Execute the original n8n command
exec n8n