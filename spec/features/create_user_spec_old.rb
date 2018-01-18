require "rails_helper"

#adding administrator tests here as well

feature "Visitor attempts to create a user account" do
  scenario "successful account creation" do
    create_user
    expect(page).to have_content "You have successfully registered"
    expect(page).to have_current_path(users_new_path)
  end
  scenario "successful admin creation" do
    create_admin
    expect(page).to have_content "You have successfully registered as an administrator"
    expect(page).to have_current_path(users_new_path)
  end
  scenario "create two users successfully" do
    create_user
    create_user2
    expect(page).to have_content "You have successfully registered"
    expect(page).to have_current_path(users_new_path)
  end
  scenario "user enters a non-unique email" do
    create_user
    create_user2 email: "bruce@email.com"
    expect(page).to have_content "Email has already been taken"
    expect(page).to have_current_path(users_new_path)
  end
  scenario "user enters wrong admin code" do
    create_admin admin: "123"
    expect(page).to have_content "you do not have admin authorization"
    expect(page).to have_current_path(users_new_path)
  end
  scenario "user leaves name field blank" do
    create_user name: ""
    expect(page).to have_content "Name can't be blank"
  end
  scenario "user leaves password fields blank" do
    create_user password: "", confirm_pw: ""
    expect(page).to have_content "Password can't be blank"
  end
  scenario "user leaves email field blank" do
    create_user email: ""
    expect(page).to have_content "Email can't be blank"
  end
  scenario "user passwords do not match" do
    create_user password: ""
    expect(page).to have_content "passwords do not match"
  end
  scenario "user leaves confirm_pw field blank" do
    create_user confirm_pw: ""
    expect(page).to have_content "passwords do not match"
  end
  scenario "user name does not meet length requirements" do
    create_user name: "a"
    expect(page).to have_content "Name is too short (minimum is 2 characters)"
  end
  scenario "user name is too long" do
    create_user name: "aadfasdfaadwrwr43kjslkfjsakldjfakldjfk"
    expect(page).to have_content "Name is too long (maximum is 10 characters)"
  end
  scenario "user email does not meet format requirements" do
    create_user email: "aadfasdfa.net"
    expect(page).to have_content "Email is invalid"
  end
  scenario "email entered is too long" do
    create_user email: "aadfasdfaadfadfsadfadfadfasfasfsfasf@afsdfasdfasfasfasdfs.net"
    expect(page).to have_content "Email is too long (maximum is 40 characters)"
  end
end

feature "Existing user signs into account" do
  scenario "successful sign in" do
    create_user
    login_user
    expect(page).to have_content "Welcome #{User.first.name}"
  end
  scenario "user enters wrong email" do
    create_user
    login_user email:"wrong@email.com"
    expect(page).to have_content "Email not found"
  end
  scenario "user enters incorrect password " do
    create_user
    login_user password:"wrong"
    expect(page).to have_content "Invalid password"
  end
end
