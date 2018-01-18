require "rails_helper"


# def create_food(name: "Hamburger", description: "A giant hamburger", price: 10.15)


feature "Admin creates food for menu" do
  #fails once Course field/table was required.
  scenario "successful food addition" do
    create_admin
    create_food
    expect(page).to have_content "Hamburger"
    expect(page).to have_current_path(root_path)
  end
  scenario "admin forgets to add food name" do
    create_admin
    create_food name: ""
    expect(page).to have_content "Name can't be blank"
  end
  scenario "admin forgets to add food description" do
    create_admin
    create_food description: ""
    expect(page).to have_content "Description can't be blank"
  end
  scenario "food name does not meet length requirements" do
    create_admin
    create_food name: ""
    expect(page).to have_content "Name is too short (minimum is 2 characters)"
  end
  scenario "food description is too short" do
    create_admin
    create_food description: "adf"
    expect(page).to have_content "Description is too short (minimum is 8 characters)"
  end
  #fails
  scenario "user is not admin" do
    create_user
    create_food
    page.should have_no_css('#food_form')
    #find(:css, "#food_form").should_not be_visible
    #expect(page).to find_field("food_name", {disabled: true})
  end
end
