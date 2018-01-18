require "rails_helper"
module CapybaraHelpers
  def create_user(name: "Bruce", email: "bruce@email.com", password: "password", confirm_pw: "password")
    visit root_path unless current_path == root_path
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_confirm_pw", with: confirm_pw
    click_button "Create"
  end
  def create_user2(name: "Joe", email: "joe@email.com", password: "password", confirm_pw: "password")
    visit root_path unless current_path == root_path
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_confirm_pw", with: confirm_pw
    click_button "Create"
  end
  def create_admin(name: "Bruce", email: "bruce@email.com", password: "password", confirm_pw: "password", admin: "XIXI")
    visit root_path unless current_path == root_path
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_confirm_pw", with: confirm_pw
    fill_in "admin_code", with: admin
    click_button "Create"
  end
  def login_user(email: "bruce@email.com", password: "password")
    visit root_path unless current_path == root_path
    fill_in "login_email", with: email
    fill_in "login_password", with: password
    click_button "Sign In"
  end
end
