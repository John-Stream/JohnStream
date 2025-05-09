# JohnStream

GitHub Actions workflow test repository for automated PR creation from develop to master branch.

## Workflow Features

- Automatically creates PR from develop to master when changes are pushed to develop
- Prevents duplicate PRs with an existence check
- Notifies the data team via Discord webhook when database-related files are merged into master
- Tracks changes in:
  - Database schema files (`db/schema.rb`)
  - Database migrations in `db/migrate` directory

## Setup Instructions

### 1. Repository Setup

Make sure your repository has both `develop` and `master` branches.

### 2. Discord Webhook

1. Create a Discord webhook in your server:
   - Go to Server Settings → Integrations → Webhooks
   - Click "New Webhook"
   - Name it appropriately (e.g., "Model Change Alerts")
   - Copy the webhook URL

2. Add the webhook URL as a repository secret:
   - Go to your GitHub repository
   - Navigate to Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `DISCORD_WEBHOOK_URL`
   - Value: Paste your Discord webhook URL
   - Click "Add secret"

### 3. GitHub Workflow Permissions

For this workflow to create pull requests, ensure that GitHub Actions has the necessary permissions:

- Go to your repository on GitHub
- Navigate to Settings → Actions → General
- Scroll down to "Workflow permissions"
- Select "Read and write permissions"
- Save changes

## How It Works

### PR Creation Workflow

1. When code is pushed to the `develop` branch, the workflow triggers
2. It verifies if a PR from `develop` to `master` already exists
3. If no PR exists, it creates one

### Alert Workflow

1. When a PR is merged into the `master` branch, a separate workflow triggers
2. It checks if any database-related files were changed in the merged PR
3. If database changes are detected, it sends a detailed notification to Discord containing:
   - PR title, number and link
   - Name of the person who merged the PR
   - List of migration files changed
   - Preview of schema changes with diff formatting
   - Direct link to view all file changes in the PR

## Troubleshooting

If you encounter the "Resource not accessible by integration" error:

- Verify that you've set the workflow permissions as described above
- Make sure the workflow has the `permissions` block with appropriate rights
- Check that the GitHub token has the necessary access

## Directory Structure

- `.github/workflows/` - GitHub Actions workflow configuration
- `app/models/` - Application models directory (for testing model change detection)
- `spec/models/` - Model specifications directory (for testing model change detection)
- `db/` - Database files, including schema and migrations
