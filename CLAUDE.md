# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a PHP learning project for GitHub Actions that implements a ReactPHP socket server. The codebase uses:

- **Language**: PHP 8.4
- **Main Dependencies**: ReactPHP (socket and HTTP components)
- **Architecture**: Simple socket server with echo functionality
- **Deployment**: Docker-based with Alpine Linux

## Development Commands

### Building and Running
- `make build` - Full build process (install dependencies + start containers)
- `make start` - Start Docker containers with build and force recreate
- `make stop` - Stop running containers
- `make restart` - Restart containers
- `make destroy` - Remove containers completely
- `make rebuild` - Full rebuild with cache clearing

### Dependencies
- `make deps` - Install Composer dependencies
- `make composer-install` - Install Composer packages
- `make composer-require` - Add new Composer packages (interactive)
- `make composer-update` - Update Composer packages

### Docker Management
- `make status` - Show container status
- `make doco DOCKER_COMMAND="<command>"` - Run custom docker-compose commands

## Architecture

The project consists of:

1. **Main Application** (`src/socket-server.php`): ReactPHP socket server that echoes received data back to clients
2. **Docker Setup**: PHP 8.4 Alpine container exposing port 8080
3. **Build System**: Makefile-based with Docker Compose integration
4. **Dependencies**: Managed via Composer with PSR-4 autoloading under `Zacarias\LearnGithubActions\` namespace

## Key Configuration

- **Namespace**: `Zacarias\LearnGithubActions\`
- **Port**: 8080 (Docker exposed)
- **TLS Support**: Available with certificate at `etc/localhost.pem`
- **Socket Options**: Supports TCP, TLS, Unix domain sockets, and systemd socket activation

## Docker Workflow

The project uses Docker containers for all operations including Composer dependency management. All composer commands run inside Docker containers to ensure consistent environment.