#!/bin/bash

# Replace this with your actual webhook URL for testing
WEBHOOK_URL="your-webhook-url-here"

# Test with simple content
curl -H "Content-Type: application/json" -X POST \
  --data '{"content": "📢 **Test Message**"}' \
  $WEBHOOK_URL

# Test with code block
curl -H "Content-Type: application/json" -X POST \
  --data '{"content": "```diff\n+ Added line\n- Removed line\n```"}' \
  $WEBHOOK_URL
