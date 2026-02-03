# Contributing to JRF_Farming

Thank you for considering contributing to JRF_Farming! Here are some guidelines to help you get started.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/JRF_Farming.git
   cd JRF_Farming
   ```

3. **Set up the development environment**:
   ```bash
   # Install dependencies
   bundle install
   yarn install
   
   # Set up the database
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Workflow

1. Make your changes in your feature branch
2. Write or update tests for your changes
3. Run the test suite to ensure nothing broke:
   ```bash
   rails test
   ```
4. Run the linter (if configured):
   ```bash
   rubocop
   ```
5. Commit your changes with a clear message:
   ```bash
   git commit -m "Add feature: description of your changes"
   ```

## Pull Request Process

1. **Update documentation** if needed
2. **Ensure all tests pass**
3. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```
4. **Open a Pull Request** on GitHub with:
   - A clear title and description
   - Reference to any related issues
   - Screenshots (if UI changes)

## Coding Standards

- Follow Ruby style guide: https://rubystyle.guide/
- Write meaningful commit messages
- Keep methods small and focused
- Write tests for new features
- Comment complex logic

## Code Review Process

- Maintainers will review your PR
- Address any feedback or requested changes
- Once approved, your PR will be merged

## Questions?

Feel free to open an issue for questions or discussions!

Thank you for contributing! 🌾
