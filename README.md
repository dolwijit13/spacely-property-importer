# Spacely Property Importer

A Rails application for importing and managing property data from CSV files.

## Overview

This application allows you to:
- Import property data from CSV files containing Japanese property information
- View and browse imported properties with pagination
- Handle different property types (アパート, マンション, 一戸建て)
- Process large CSV files efficiently using background jobs

## Requirements

- Ruby 3.3.8
- Rails 7.1.6
- MySQL
- Redis (for Sidekiq background jobs)

## Setup

1. **Install dependencies**
   ```bash
   bundle install
   ```

2. **Setup database**
   ```bash
   rails db:create
   rails db:migrate
   ```

3. **Start the application**
   ```bash
   # Start Rails server
   rails server

   # Start Sidekiq (for background jobs)
   bundle exec sidekiq

   # Start asset server (optional)
   ./bin/shakapacker-dev-server
   ```

4. **Access the application**

   Once all services are running, you can access the application:

   - **Web Interface**: Open your browser and visit http://localhost:3000
     - View the property dashboard with paginated listings
     - Browse imported properties with search and filtering capabilities

## Usage

**CSV Format:**
```csv
ユニークID,物件名,住所,部屋番号,賃料,広さ,建物の種類
1,シーサイドアパート,福岡県福岡市94-31,830,188000,91.0,アパート
```

**Required columns:**
- `ユニークID` - Unique property ID
- `物件名` - Property name
- `住所` - Address
- `部屋番号` - Room number (optional for 一戸建て)
- `賃料` - Rent amount
- `広さ` - Size in square meters
- `建物の種類` - Property type (アパート/マンション/一戸建て)

### Viewing Properties
Visit the root URL to see a paginated list of all imported properties.

## Testing

Run the test suite:
```bash
bundle exec rspec
```

## Continuous Integration

This project uses GitHub Actions for automated testing and code quality checks. The CI pipeline runs on:
- Every push to any branch
- Every pull request targeting the `main` branch

### CI Pipeline Features:
- **Automated Testing**: Runs the full RSpec test suite
- **Code Linting**: Executes RuboCop for code style and quality checks

The workflow file is located at `.github/workflows/rubyonrails.yml` and ensures code quality and functionality before merging changes.

## Future Improvements

The following enhancements are planned to improve the application's functionality and user experience:

### 1. **Enhanced Property Search and Filtering**
- Implement search functionality by property name, address, and property type
- Add advanced filtering options (price range, size range, property type)
- Include sorting capabilities (by price, size, date added)
- Add full-text search across multiple fields (unique_id, name, address)

### 2. **Import Error Handling and Reporting**
- Display detailed import status and progress tracking
- Show comprehensive error reports for failed CSV rows

### 3. **Containerization with Docker**
- Create multi-stage Docker build for optimized production images
- Add docker-compose.yml for easy local development setup
- Include Redis and MySQL services in Docker composition
