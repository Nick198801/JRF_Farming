# Quick Start Guide for JRF_Farming

This is a quick reference guide to get you started with Ruby on Rails development.

## Installation Steps (Quick Version)

### 1. Install Ruby (macOS with Homebrew)
```bash
brew install rbenv ruby-build
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
source ~/.zshrc
rbenv install 3.2.0
rbenv global 3.2.0
```

### 2. Install Rails
```bash
gem install rails -v 7.0.8
```

### 3. Install Node.js and Yarn
```bash
brew install node@16
npm install -g yarn
```

### 4. Install PostgreSQL
```bash
brew install postgresql@14
brew services start postgresql@14
```

### 5. Create the Rails Application
```bash
# If starting fresh, run:
rails new JRF_Farming --database=postgresql --css=tailwind
cd JRF_Farming

# If working with existing code:
bundle install
yarn install
```

### 6. Setup Database
```bash
rails db:create
rails db:migrate
```

### 7. Start the Server
```bash
rails server
```

Visit: http://localhost:3000

## Daily Development Workflow

```bash
# Start development server
rails server

# Run tests
rails test

# Check routes
rails routes

# Open Rails console
rails console

# Create a new migration
rails generate migration AddFieldToModel field:type

# Run migrations
rails db:migrate
```

## Generating Resources

```bash
# Generate a full scaffold (model, views, controller, tests)
rails generate scaffold Product name:string description:text price:decimal

# Generate just a model
rails generate model Crop name:string season:string

# Generate just a controller
rails generate controller Farms index show
```

## Helpful Commands

```bash
# Reset database (WARNING: deletes all data)
rails db:reset

# Rollback last migration
rails db:rollback

# View pending migrations
rails db:migrate:status

# Seed database with sample data
rails db:seed
```

## Next Steps

1. Read the main README.md for detailed setup instructions
2. Explore the Rails Guides: https://guides.rubyonrails.org/
3. Start building your farming management features!

## Common First Features to Build

- User authentication (sign up, login, logout)
- Farm management (CRUD operations)
- Crop tracking
- Harvest records
- Dashboard with statistics

## File Structure Quick Reference

- `app/controllers/` - Handle HTTP requests
- `app/models/` - Database models and business logic
- `app/views/` - HTML templates (ERB files)
- `config/routes.rb` - URL routing
- `db/migrate/` - Database migrations
- `test/` - Test files
