require "rails_helper"
module CapybaraHelpers
  def create_admin(name: "Bruce", email: "bruce@email.com", password: "password", confirm_pw: "password", admin: "XIXI")
    visit root_path unless current_path == root_path
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_confirm_pw", with: confirm_pw
    fill_in "admin_code", with: admin
    click_button "Create"
  end
  def create_food(name: "Hamburger", description: "A giant hamburger", price: 10.15)
    visit root_path unless current_path == root_path
    fill_in "food_name", with: name
    fill_in "food_description", with: description
    fill_in "food_price", with: price
    select "Entree", from: "food_course"
    #select ("Entree", :from => "food_course").select_option
    #find("#food_course").find(:xpath, "option[3]").select_option
    click_button "Add Item"
  end
end
