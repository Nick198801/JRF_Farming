# Troubleshooting Guide for JRF_Farming

Common issues and solutions when setting up and running Ruby on Rails.

## Installation Issues

### Ruby Installation Fails

**Problem**: `rbenv install 3.2.0` fails

**Solutions**:
```bash
# On macOS - Install Xcode Command Line Tools first
xcode-select --install

# On Ubuntu - Install build dependencies
sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev

# Try again
rbenv install 3.2.0
```

### Rails Installation Fails

**Problem**: `gem install rails` fails with permission error

**Solution**:
```bash
# Never use sudo with gem commands when using rbenv
# Make sure rbenv is properly initialized
rbenv rehash

# Try installing again
gem install rails
```

### PostgreSQL Connection Issues

**Problem**: `could not connect to server: Connection refused`

**Solutions**:
```bash
# Check if PostgreSQL is running
# macOS:
brew services list
brew services start postgresql@14

# Ubuntu:
sudo systemctl status postgresql
sudo systemctl start postgresql

# Check PostgreSQL is listening
psql -h localhost -U postgres -c "SELECT version();"
```

## Database Issues

### Database Creation Fails

**Problem**: `rails db:create` fails with authentication error

**Solution**:
```bash
# Edit database.yml to match your PostgreSQL setup
# For local development, you might need:
development:
  adapter: postgresql
  database: jrf_farming_development
  host: localhost
  username: postgres
  password:  # Leave empty if no password set

# Or set environment variables
export DATABASE_USERNAME=postgres
export DATABASE_PASSWORD=your_password
```

### Migration Fails

**Problem**: Migration fails with syntax error

**Solutions**:
```bash
# Check the migration file for errors
# If needed, rollback and fix
rails db:rollback

# Edit the migration file
# Run again
rails db:migrate

# If completely stuck, reset database (WARNING: loses all data)
rails db:drop db:create db:migrate
```

### Database Already Exists

**Problem**: `database already exists` error

**Solution**:
```bash
# If you want to recreate it
rails db:drop
rails db:create
rails db:migrate

# Or just run migrations on existing database
rails db:migrate
```

## Server Issues

### Port Already in Use

**Problem**: `Address already in use - bind(2) for "127.0.0.1" port 3000`

**Solutions**:
```bash
# Find what's using port 3000
lsof -i :3000

# Kill the process (replace PID with actual process ID)
kill -9 PID

# Or run Rails on a different port
rails server -p 3001
```

### Server Won't Start

**Problem**: Rails server crashes on startup

**Solutions**:
```bash
# Check for errors in log file
tail -f log/development.log

# Ensure all dependencies are installed
bundle install
yarn install

# Clear cache and restart
rails tmp:cache:clear
rails server
```

### Asset Compilation Fails

**Problem**: Assets not loading or compilation errors

**Solutions**:
```bash
# Clear asset cache
rails assets:clobber

# Precompile assets
rails assets:precompile

# For development, ensure webpack/tailwind is running
bin/dev
```

## Dependency Issues

### Bundle Install Fails

**Problem**: `bundle install` fails with gem compilation errors

**Solutions**:
```bash
# Update bundler
gem install bundler
gem update --system

# Clean and retry
bundle clean --force
bundle install

# If pg gem fails (PostgreSQL adapter)
# macOS:
brew install postgresql@14
gem install pg -- --with-pg-config=/opt/homebrew/opt/postgresql@14/bin/pg_config

# Ubuntu:
sudo apt-get install libpq-dev
bundle install
```

### Yarn Install Fails

**Problem**: `yarn install` fails or hangs

**Solutions**:
```bash
# Clear yarn cache
yarn cache clean

# Remove node_modules and try again
rm -rf node_modules
yarn install

# Update yarn
npm install -g yarn@latest
```

## Code Issues

### Missing Template Error

**Problem**: `Missing template` error when accessing a page

**Solution**:
```bash
# Ensure the view file exists in the correct location
# For example: app/views/farms/index.html.erb

# Check controller action returns correct response
# In app/controllers/farms_controller.rb:
def index
  @farms = Farm.all
  # render 'index' is implicit
end
```

### Routing Error

**Problem**: `No route matches [GET] "/farms"`

**Solution**:
```bash
# Check routes
rails routes | grep farm

# Ensure routes are defined in config/routes.rb
resources :farms

# Restart server after changing routes
```

### ActiveRecord Error

**Problem**: `ActiveRecord::RecordInvalid` or validation errors

**Solutions**:
```ruby
# Check model validations in app/models/
# Use console to debug
rails console

# Try creating record to see actual error
farm = Farm.new(name: "Test")
farm.save  # returns false if validation fails
farm.errors.full_messages  # shows validation errors
```

## Performance Issues

### Slow Queries

**Problem**: Database queries are slow

**Solutions**:
```bash
# Check query logs
tail -f log/development.log

# Add database indexes for frequently queried columns
rails generate migration AddIndexToFarms name location

# In migration file:
add_index :farms, :name
add_index :farms, :location
```

### Memory Issues

**Problem**: High memory usage

**Solutions**:
```bash
# Use pagination for large datasets
# Add kaminari or pagy gem

# In controller:
@farms = Farm.page(params[:page]).per(25)

# Eager load associations to avoid N+1 queries
@farms = Farm.includes(:crops).all
```

## Testing Issues

### Tests Fail

**Problem**: Test suite fails

**Solutions**:
```bash
# Ensure test database is set up
rails db:test:prepare

# Run specific test to debug
rails test test/models/farm_test.rb

# Check test logs
tail -f log/test.log

# Clear test cache
rails tmp:cache:clear RAILS_ENV=test
```

## Environment Issues

### Wrong Ruby Version

**Problem**: Application uses wrong Ruby version

**Solution**:
```bash
# Check current Ruby version
ruby -v

# Ensure using correct version
rbenv local 3.2.0

# Verify
ruby -v
```

### Missing Environment Variables

**Problem**: Application can't find environment variables

**Solutions**:
```bash
# Create .env file from example
cp .env.example .env

# Edit .env with your values
# Add to .gitignore to avoid committing secrets

# Install dotenv-rails gem
bundle add dotenv-rails

# Restart server
```

## Deployment Issues

### Heroku Deployment Fails

**Problem**: Push to Heroku fails

**Solutions**:
```bash
# Ensure Gemfile.lock is committed
git add Gemfile.lock
git commit -m "Add Gemfile.lock"

# Check Heroku logs
heroku logs --tail

# Ensure database is set up
heroku run rails db:migrate
```

## Still Stuck?

1. **Check Rails Guides**: https://guides.rubyonrails.org/
2. **Search Stack Overflow**: Most errors have been encountered before
3. **Check GitHub Issues**: Search the repository for similar issues
4. **Rails Console**: Use `rails console` to debug interactively
5. **Logs**: Check `log/development.log` for detailed error messages

## Getting Help

When asking for help, include:
- Ruby version (`ruby -v`)
- Rails version (`rails -v`)
- Operating system
- Full error message
- Relevant code snippets
- What you've already tried

## Useful Debugging Commands

```bash
# Check environment
rails about

# Rails console
rails console

# Database console
rails dbconsole

# Check routes
rails routes

# View all rake tasks
rails -T

# Check for missing migrations
rails db:migrate:status

# View database schema
cat db/schema.rb
```

Good luck! 🌾
