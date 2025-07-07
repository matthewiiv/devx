# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal development environment configuration repository (`devx`) that centralizes shell configurations, editor settings, and development utilities. It uses symlinks to distribute configurations to their proper locations on the system.

## Common Commands

### Repository Management
- `rl` - Reload .zshrc configuration
- `rlw` - Reload .zshrc and auto-commit changes with AI-generated message
- `git_commit_devx "<message>"` - Commit changes to this devx repository

### Development Workflow Commands (for use in other repositories)
- `dev` - Start development server (`nvm use; yarn dev`)
- `drl` - Development with Doppler local config
- `drs` - Development with Doppler staging config
- `drd` - Development with Doppler dev config
- `drp` - Development with Doppler prod config
- `t` - Run tests (`yarn test`)
- `tt` - Run tests in watch mode (`yarn test -t`)
- `gen` - Generate types (`nvm use; yarn gen`)
- `containers()` - Start Redis and SQS containers using Doppler

### Version Control (Graphite/Git)
- `gtc` - Create new Graphite branch
- `gtcs` - Create branch and submit PR
- `sc` - Sync with Graphite
- `ss` - Submit stack
- `ams` - Add all, modify, and submit stack
- `trunk` - Checkout main branch

### Repository Shortcuts
- `devx` - Open this repository in Cursor
- `web` - Open web repository in Cursor
- `backend` - Open backend repository in Cursor
- `shared` - Open shared repository in Cursor

## Architecture

### Key Files
- `.zshrc` - Main shell configuration containing all aliases, functions, and environment setup
- `cursor/settings.json` - Cursor/VS Code editor settings
- `.env.example` - Template for environment variables (create `.env` from this)

### Core Integrations
1. **Graphite (gt)** - Git workflow management tool used for branching and PR submission
2. **Doppler** - Secrets management for different environments
3. **NVM** - Node.js version management
4. **OpenAI API** - Used for AI-powered commit message generation

### Important Functions
- `generate-commit-message()` - Uses OpenAI to generate commit messages from git diff
- `gt_create()` / `gt_create_and_submit()` - Graphite branch creation workflows
- `containers()` - Manages Docker containers for local development services

### Setup Requirements
1. Install jq: `brew install jq`
2. Symlink .zshrc: `ln -s ~/code/personal/devx/.zshrc ~/.zshrc`
3. Symlink Cursor settings: `ln -s ~/code/personal/devx/cursor/settings.json ~/Library/Application\ Support/Cursor/User/settings.json`
4. Create `.env` file from `.env.example` with required API keys

## Development Notes
- Always use `gt` (Graphite) for source control operations instead of raw git commands
- The repository contains shortcuts and configurations for JavaScript/TypeScript projects using Yarn
- Doppler is used for managing environment-specific configurations and secrets
- Commit message generation requires OPENAI_API_KEY in `.env` file