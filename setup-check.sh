#!/bin/bash

echo "🌾 JRF Farming - Ruby on Rails Setup Script 🌾"
echo "================================================"
echo ""

# Check if Ruby is installed
if command -v ruby &> /dev/null; then
    echo "✅ Ruby is installed: $(ruby -v)"
else
    echo "❌ Ruby is not installed. Please install Ruby first."
    echo "   Visit: https://www.ruby-lang.org/en/documentation/installation/"
    exit 1
fi

# Check if Rails is installed
if command -v rails &> /dev/null; then
    echo "✅ Rails is installed: $(rails -v)"
else
    echo "⚠️  Rails is not installed. Installing Rails..."
    gem install rails -v 7.0.8
fi

# Check if Node.js is installed
if command -v node &> /dev/null; then
    echo "✅ Node.js is installed: $(node -v)"
else
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

# Check if Yarn is installed
if command -v yarn &> /dev/null; then
    echo "✅ Yarn is installed: $(yarn -v)"
else
    echo "⚠️  Yarn is not installed. Installing Yarn..."
    npm install -g yarn
fi

# Check if PostgreSQL is installed
if command -v psql &> /dev/null; then
    echo "✅ PostgreSQL is installed: $(psql --version)"
else
    echo "❌ PostgreSQL is not installed. Please install PostgreSQL first."
    echo "   macOS: brew install postgresql@14"
    echo "   Ubuntu: sudo apt-get install postgresql postgresql-contrib"
    exit 1
fi

echo ""
echo "================================================"
echo "All prerequisites are installed! 🎉"
echo ""
echo "Next steps:"
echo "1. Create your Rails app: rails new JRF_Farming --database=postgresql --css=tailwind"
echo "2. Navigate to your app: cd JRF_Farming"
echo "3. Install dependencies: bundle install && yarn install"
echo "4. Create database: rails db:create"
echo "5. Start server: rails server"
echo ""
echo "For more details, see README.md"
echo "================================================"
