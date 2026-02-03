# First Feature Tutorial: Building a Farm Management System

This tutorial will guide you through creating your first feature in the JRF_Farming Rails application.

## What We'll Build

A simple Farm resource with CRUD (Create, Read, Update, Delete) operations.

## Prerequisites

- Rails application created and running
- Database created and migrated
- Development server accessible at http://localhost:3000

## Step 1: Generate the Farm Scaffold

Run the following command to generate a complete Farm resource:

```bash
rails generate scaffold Farm name:string location:string size:decimal crop_type:string
```

This creates:
- Model (`app/models/farm.rb`)
- Controller (`app/controllers/farms_controller.rb`)
- Views (`app/views/farms/`)
- Migration (`db/migrate/XXXXXX_create_farms.rb`)
- Tests
- Routes

## Step 2: Run the Migration

```bash
rails db:migrate
```

This creates the `farms` table in your database.

## Step 3: Check the Routes

```bash
rails routes | grep farm
```

You should see:
```
    farms GET    /farms(.:format)          farms#index
          POST   /farms(.:format)          farms#create
 new_farm GET    /farms/new(.:format)      farms#new
edit_farm GET    /farms/:id/edit(.:format) farms#edit
     farm GET    /farms/:id(.:format)      farms#show
          PATCH  /farms/:id(.:format)      farms#update
          PUT    /farms/:id(.:format)      farms#update
          DELETE /farms/:id(.:format)      farms#destroy
```

## Step 4: Start the Server (if not running)

```bash
rails server
```

## Step 5: Test Your New Feature

1. Visit http://localhost:3000/farms
2. Click "New Farm" button
3. Fill in the form:
   - Name: "Green Valley Farm"
   - Location: "California"
   - Size: 100.5
   - Crop Type: "Wheat"
4. Click "Create Farm"
5. You should see your new farm listed!

## Step 6: Understanding What Was Created

### Model (`app/models/farm.rb`)
```ruby
class Farm < ApplicationRecord
  # Add validations
  validates :name, presence: true
  validates :size, numericality: { greater_than: 0 }
end
```

### Controller (`app/controllers/farms_controller.rb`)
Handles all CRUD operations:
- `index` - List all farms
- `show` - Display a single farm
- `new` - Form for new farm
- `create` - Save new farm
- `edit` - Form to edit farm
- `update` - Save farm changes
- `destroy` - Delete farm

### Views (`app/views/farms/`)
- `index.html.erb` - List of all farms
- `show.html.erb` - Details of one farm
- `_form.html.erb` - Form partial (used by new and edit)
- `new.html.erb` - New farm page
- `edit.html.erb` - Edit farm page

## Step 7: Customize the Model with Validations

Edit `app/models/farm.rb`:

```ruby
class Farm < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :size, numericality: { greater_than: 0 }, allow_nil: true
  validates :crop_type, presence: true
  
  # Scopes (for querying)
  scope :by_crop_type, ->(crop_type) { where(crop_type: crop_type) }
  scope :large_farms, -> { where("size > ?", 100) }
  
  # Instance methods
  def display_name
    "#{name} (#{location})"
  end
end
```

## Step 8: Add Seed Data

Edit `db/seeds.rb`:

```ruby
# Create sample farms
Farm.create([
  {
    name: "Green Valley Farm",
    location: "California",
    size: 150.5,
    crop_type: "Wheat"
  },
  {
    name: "Sunny Acres",
    location: "Oregon",
    size: 75.0,
    crop_type: "Corn"
  },
  {
    name: "Mountain View Ranch",
    location: "Colorado",
    size: 200.0,
    crop_type: "Barley"
  }
])

puts "Created #{Farm.count} farms"
```

Run the seeds:
```bash
rails db:seed
```

## Step 9: Test in Rails Console

```bash
rails console
```

Try these commands:
```ruby
# Get all farms
Farm.all

# Create a new farm
farm = Farm.new(name: "Test Farm", location: "Texas", size: 50, crop_type: "Cotton")
farm.save

# Find a farm
farm = Farm.find(1)

# Update a farm
farm.update(size: 175)

# Delete a farm
farm.destroy

# Query farms
Farm.where(crop_type: "Wheat")
Farm.large_farms
```

## Step 10: Add a Home Page

Set the farms index as your home page by editing `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  resources :farms
  
  # Set root path
  root "farms#index"
end
```

Now http://localhost:3000 will show your farms list!

## Step 11: Enhance the Views (Optional)

Edit `app/views/farms/index.html.erb` to add styling or filters.

Example enhancement:
```erb
<h1>Farms</h1>

<div class="mb-4">
  <%= link_to "New Farm", new_farm_path, class: "btn btn-primary" %>
</div>

<table class="table">
  <thead>
    <tr>
      <th>Name</th>
      <th>Location</th>
      <th>Size (acres)</th>
      <th>Crop Type</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
    <% @farms.each do |farm| %>
      <tr>
        <td><%= farm.name %></td>
        <td><%= farm.location %></td>
        <td><%= number_with_precision(farm.size, precision: 2) %></td>
        <td><%= farm.crop_type %></td>
        <td>
          <%= link_to "View", farm, class: "btn btn-sm btn-info" %>
          <%= link_to "Edit", edit_farm_path(farm), class: "btn btn-sm btn-warning" %>
          <%= button_to "Delete", farm, method: :delete, 
                        data: { confirm: "Are you sure?" }, 
                        class: "btn btn-sm btn-danger" %>
        </td>
      </tr>
    <% end %>
  </tbody>
</table>
```

## Step 12: Write Tests

Edit `test/models/farm_test.rb`:

```ruby
require "test_helper"

class FarmTest < ActiveSupport::TestCase
  test "should not save farm without name" do
    farm = Farm.new(location: "California", size: 100, crop_type: "Wheat")
    assert_not farm.save, "Saved farm without a name"
  end
  
  test "should save valid farm" do
    farm = Farm.new(
      name: "Test Farm",
      location: "California",
      size: 100,
      crop_type: "Wheat"
    )
    assert farm.save, "Could not save valid farm"
  end
  
  test "size should be greater than 0" do
    farm = Farm.new(
      name: "Test Farm",
      location: "California",
      size: -10,
      crop_type: "Wheat"
    )
    assert_not farm.save, "Saved farm with negative size"
  end
end
```

Run tests:
```bash
rails test test/models/farm_test.rb
```

## Next Steps

Now that you have a basic Farm resource, you can:

1. Add more models (Crops, Harvests, Employees)
2. Create relationships between models
3. Add authentication with Devise gem
4. Add search and filtering
5. Add charts and statistics
6. Deploy to production

## Common Next Features

### Adding Relationships
```bash
# Create a Crop model related to Farm
rails generate model Crop name:string planted_date:date farm:references
rails db:migrate
```

In `app/models/farm.rb`:
```ruby
class Farm < ApplicationRecord
  has_many :crops, dependent: :destroy
end
```

In `app/models/crop.rb`:
```ruby
class Crop < ApplicationRecord
  belongs_to :farm
end
```

### Adding Authentication
```bash
# Add Devise gem
bundle add devise
rails generate devise:install
rails generate devise User
rails db:migrate
```

## Resources

- [Rails Guides](https://guides.rubyonrails.org/)
- [Rails API Docs](https://api.rubyonrails.org/)
- [Active Record Associations](https://guides.rubyonrails.org/association_basics.html)
- [Active Record Validations](https://guides.rubyonrails.org/active_record_validations.html)

Happy coding! 🌾
