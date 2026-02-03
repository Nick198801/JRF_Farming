# JRF_Farming

A Ruby on Rails application for farming management.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Ruby** (version 3.2.0 or higher recommended)
- **Rails** (version 7.0 or higher)
- **Node.js** (version 16.x or higher) - for JavaScript runtime
- **Yarn** (version 1.x) - for managing JavaScript dependencies
- **PostgreSQL** (version 12 or higher) - for database
- **Git** - for version control

## Ruby on Rails Setup Guide

### 1. Install Ruby

#### On macOS (using rbenv):
```bash
# Install rbenv and ruby-build
brew install rbenv ruby-build

# Add rbenv to bash/zsh so that it loads every time you open a terminal
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc  # For bash
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc    # For zsh

# Restart your terminal or run
source ~/.bashrc  # or source ~/.zshrc

# Install Ruby 3.2.0
rbenv install 3.2.0
rbenv global 3.2.0

# Verify installation
ruby -v
```

#### On Ubuntu/Debian:
```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y git curl libssl-dev libreadline-dev zlib1g-dev \
  autoconf bison build-essential libyaml-dev libreadline-dev \
  libncurses5-dev libffi-dev libgdbm-dev

# Install rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash

# Add to PATH
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Install Ruby 3.2.0
rbenv install 3.2.0
rbenv global 3.2.0

# Verify installation
ruby -v
```

#### On Windows:
```bash
# Download and install RubyInstaller from https://rubyinstaller.org/
# Choose Ruby 3.2.0 with DevKit
# Follow the installation wizard
# Verify installation
ruby -v
```

### 2. Install Rails

```bash
# Install Rails gem
gem install rails -v 7.0.8

# Verify installation
rails -v
```

### 3. Install Node.js and Yarn

#### On macOS:
```bash
# Install Node.js
brew install node@16

# Install Yarn
npm install -g yarn

# Verify installations
node -v
yarn -v
```

#### On Ubuntu/Debian:
```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Yarn
npm install -g yarn

# Verify installations
node -v
yarn -v
```

### 4. Install PostgreSQL

#### On macOS:
```bash
# Install PostgreSQL
brew install postgresql@14

# Start PostgreSQL service
brew services start postgresql@14

# Verify installation
psql --version
```

#### On Ubuntu/Debian:
```bash
# Install PostgreSQL
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib libpq-dev

# Start PostgreSQL service
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Verify installation
psql --version
```

### 5. Create New Rails Application

If you haven't created the Rails app yet:

```bash
# Navigate to your projects directory
cd /path/to/your/projects

# Create a new Rails application with PostgreSQL
rails new JRF_Farming --database=postgresql --css=tailwind

# Navigate into the application
cd JRF_Farming
```

### 6. Configure Database

Edit `config/database.yml` and update the development database settings:

```yaml
development:
  adapter: postgresql
  encoding: unicode
  database: jrf_farming_development
  pool: 5
  username: <%= ENV['DATABASE_USERNAME'] || 'postgres' %>
  password: <%= ENV['DATABASE_PASSWORD'] || '' %>
  host: localhost
```

Create the database:
```bash
rails db:create
rails db:migrate
```

### 7. Install Dependencies

```bash
# Install Ruby gems
bundle install

# Install JavaScript packages
yarn install
```

### 8. Start the Development Server

```bash
# Start the Rails server
rails server

# Or use the shorthand
rails s
```

The application will be available at: `http://localhost:3000`

### 9. Running in Development Mode

```bash
# Start Rails server
rails server

# In a separate terminal, start asset compilation (if using Tailwind CSS or other assets)
bin/dev
```

## Project Structure

```
JRF_Farming/
├── app/                    # Application code
│   ├── controllers/        # Request handlers
│   ├── models/             # Database models
│   ├── views/              # Templates
│   ├── helpers/            # View helpers
│   ├── assets/             # Images, stylesheets, JavaScript
│   └── mailers/            # Email handlers
├── config/                 # Configuration files
│   ├── routes.rb           # URL routing
│   ├── database.yml        # Database configuration
│   └── environments/       # Environment-specific settings
├── db/                     # Database files
│   ├── migrate/            # Database migrations
│   └── seeds.rb            # Seed data
├── test/                   # Test files
├── tmp/                    # Temporary files
├── log/                    # Log files
├── public/                 # Static files
├── Gemfile                 # Ruby dependencies
└── config.ru               # Rack configuration
```

## Common Rails Commands

```bash
# Generate a new controller
rails generate controller ControllerName

# Generate a new model
rails generate model ModelName field:type

# Generate a scaffold (model, views, controller)
rails generate scaffold ResourceName field:type

# Create database migration
rails generate migration MigrationName

# Run database migrations
rails db:migrate

# Rollback last migration
rails db:rollback

# Drop database
rails db:drop

# Create database
rails db:create

# Reset database (drop, create, migrate, seed)
rails db:reset

# Seed database with data
rails db:seed

# Open Rails console
rails console

# Run tests
rails test

# View routes
rails routes
```

## Running Tests

```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/example_test.rb

# Run specific test
rails test test/models/example_test.rb:10
```

## Deployment

For production deployment, consider using:
- **Heroku** - Simple deployment platform
- **AWS** - Elastic Beanstalk or EC2
- **DigitalOcean** - App Platform or Droplets
- **Render** - Modern cloud platform

### Deploying to Heroku:
```bash
# Install Heroku CLI
# Visit: https://devcenter.heroku.com/articles/heroku-cli

# Login to Heroku
heroku login

# Create Heroku app
heroku create jrf-farming

# Add PostgreSQL
heroku addons:create heroku-postgresql:mini

# Deploy
git push heroku main

# Run migrations
heroku run rails db:migrate

# Open application
heroku open
```

## Environment Variables

Create a `.env` file in the root directory (don't commit this file):

```
DATABASE_USERNAME=your_db_username
DATABASE_PASSWORD=your_db_password
SECRET_KEY_BASE=your_secret_key
```

Generate a secret key:
```bash
rails secret
```

## Troubleshooting

### Port already in use
```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
kill -9 PID
```

### Bundle install fails
```bash
# Update bundler
gem install bundler

# Clear cache and reinstall
bundle clean --force
bundle install
```

### Database connection errors
```bash
# Check if PostgreSQL is running
# On macOS:
brew services list

# On Ubuntu:
sudo systemctl status postgresql

# Restart PostgreSQL if needed
# On macOS:
brew services restart postgresql

# On Ubuntu:
sudo systemctl restart postgresql
```

## Additional Resources

- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [Rails API Documentation](https://api.rubyonrails.org/)
- [Ruby Documentation](https://ruby-doc.org/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).