require "rails_helper"
module CapybaraHelpers
  def register_user(name: 'Homer Simpson', email: "donuts@mmm.com", password: 'password', password_confirmation: 'password')
    visit new_register_path unless current_path == new_register_path
    fill_in "name", with: name
    fill_in "email", with: email
    fill_in "password", with: password
    click_button "Register"
  end
  def login(email: "donuts@mmm.com", password: "password")
    visit new_login_path unless current_path == new_login_path
    fill_in "email", with: email
    fill_in "password", with: password
    click_button "Login"
  end
end