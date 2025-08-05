# Superdupernova Project Overview

## Purpose
Superdupernova is a Phoenix LiveView application built as a greenfield project implementing a comprehensive lego-brick UI system. The system is designed to be AI-agent-friendly and focuses on:
- Predictable 4pt (0.25rem) atomic unit-based grid system
- 12-column layout with standardized widget sizes
- Tight integration with Ash Framework for data modeling and validation
- DaisyUI styling components
- Phoenix LiveView native form components

## Technology Stack
- **Framework**: Phoenix 1.8.0-rc.4 with LiveView 1.1.0-rc.0
- **Database**: PostgreSQL with Ecto
- **Styling**: Tailwind CSS with DaisyUI components
- **Authentication**: Ash Authentication with Phoenix integration
- **Data Layer**: Ash Framework 3.0 with Postgres adapter
- **Background Jobs**: Oban with Ash integration
- **Icons**: Heroicons
- **Build Tools**: esbuild, Tailwind
- **Additional Tools**: Ash Admin, Ash AI, Ash Events, State Machine support

## Project Structure
- `lib/superdupernova/` - Core business logic and Ash resources
- `lib/superdupernova_web/` - Phoenix web layer
- `lib/superdupernova_web/components/` - UI components (future widget location)
- `assets/` - Frontend assets (CSS, JS)
- `config/` - Application configuration
- `test/` - Test files
- `priv/` - Static files and database migrations

## Key Features
- User authentication system already implemented
- DaisyUI theming with light/dark mode support
- Ash framework integration for data modeling
- Ready for lego-brick UI widget implementation

## Current State
- Basic Phoenix application with authentication
- DaisyUI styling configured
- No custom widgets implemented yet
- Ready for lego-brick UI system implementation