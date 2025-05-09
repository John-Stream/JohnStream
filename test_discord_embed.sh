#!/bin/bash
# Test script for database changes notification workflow

# Create test files
cat > test_schema_preview.txt << 'EOT'
+ t.string "username"
+ t.newname "newname"
+ t.embedding "yes_an_embedding"
- t.string "old_column"
- t.removed "column_name"
+ add_index "users", ["username"], name: "index_users_on_username"
EOT

# Create JSON payload
cat > test_discord_payload.json << 'EOT'
{
  "embeds": [
    {
      "title": "📢 Database Changes in Master",
      "description": "[View PR changes](https://github.com/your-repo/pull/123/files)",
      "color": 3447003,
      "fields": []
    }
  ]
}
EOT

# Add migration files field
MIGRATION_FILES="• \`db/migrate/20230509123456_create_users.rb\`\\n• \`db/migrate/20230510000000_add_columns.rb\`"
jq --arg files "$MIGRATION_FILES" '.embeds[0].fields += [{"name": "Migration Files Changed", "value": $files}]' test_discord_payload.json > temp.json && mv temp.json test_discord_payload.json

# Add schema changes field
SCHEMA_CONTENT=$(cat test_schema_preview.txt | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
SCHEMA_VALUE="\`\`\`diff\\n${SCHEMA_CONTENT}\\n\`\`\`"
jq --arg changes "$SCHEMA_VALUE" '.embeds[0].fields += [{"name": "Schema Changes", "value": $changes}]' test_discord_payload.json > temp.json && mv temp.json test_discord_payload.json

# Add footer
jq '.embeds[0].footer = {"text": "💡 You may need to update your local database"}' test_discord_payload.json > temp.json && mv temp.json test_discord_payload.json

echo "=== Final Discord JSON Payload ==="
cat test_discord_payload.json

echo ""
echo "=== To test with your Discord webhook, run: ==="
echo "curl -H \"Content-Type: application/json\" -X POST -d @test_discord_payload.json YOUR_WEBHOOK_URL"
