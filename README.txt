== README


General:

    Project was designed to maintain a single page app design, still under development


    To Do:

        Styling & Formatting
        Add Capybara tests for Purchasing, Tip, Receipt
        Javascript/Async for partials


    Done:

        Create Purchase functionality: create/view/edit order
        Tip functionality/recalculate
        Receipt, order confirmation
        Secure Login
        Food creation and display
        Admin functions:
          separate login
          create/edit/delete items
          
        Testing:
          models and associations
          controller view features, aside from future functionality.
        Partial display logic for existing features


Login/Register:

    Create a user account using Register link.
    Two types of users;

      1. Visitors: leave admin code blank. Can order food but cannot edit/add menu items
      2. Administrators: admin code is "XIXI". Admins can add and edit menu items but cannot place orders.


Database Tables: (see model files for associations)

    User
    Admin
    Food
    Order
    Purchase


Test commands:

    Capybara
    rspec ./spec/features/create_user_spec.rb
    rspec ./spec/features/create_food_spec.rb

    Factory Girl
    rspec ./spec/models/admin_spec.rb
    rspec ./spec/models/course_spec.rb
    rspec ./spec/models/food_spec.rb
    rspec ./spec/models/order_spec.rb
    rspec ./spec/models/purchase_spec.rb
    rspec ./spec/models/user_spec.rb


Gems used (aside from default):

    Capybara
    Factory Girl
    Bcrypt
    Hirb


Version:

    Ruby 2.3.1
    Rails 4.2.7


Development Environment:

    Vagrant ubuntu/trusty64
