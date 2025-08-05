# Essential Development Commands

## Development Setup
```bash
# Initial setup
mix setup

# Install dependencies only
mix deps.get

# Setup database
mix ash.setup

# Setup assets
mix assets.setup
mix assets.build
```

## Development Server
```bash
# Start Phoenix server
mix phx.server

# Start with IEx console
iex -S mix phx.server
```

## Code Quality & Testing
```bash
# Run tests
mix test

# Format code
mix format

# Compile and check for warnings
mix compile

# Compile with warnings as errors
mix compile --warnings-as-errors
```

## Asset Management
```bash
# Build assets for development
mix assets.build

# Build assets for production
mix assets.deploy

# Install asset dependencies
mix assets.setup
```

## Database Operations
```bash
# Run migrations
mix ecto.migrate

# Reset database
mix ecto.reset

# Generate migration
mix ash.codegen

# Setup Ash resources
mix ash.setup
```

## Code Generation
```bash
# Generate Ash resource
mix ash.gen.resource

# Generate Phoenix LiveView
mix phx.gen.live

# Generate authentication components
mix ash_authentication.gen.sign_in
```

## Useful Darwin System Commands
```bash
# Find files
find . -name "*.ex" -type f

# Search in files
grep -r "pattern" lib/

# List directory contents
ls -la

# Change directory
cd path/to/directory

# Copy files
cp source destination

# Move/rename files
mv source destination
```