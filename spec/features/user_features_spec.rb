# require 'rails_helper'
# feature 'User features ' do
#   feature "user sign-up" do
#     scenario 'visits sign-up page'
#     scenario "with improper inputs, redirects back to sign in and shows validations"
#     scenario "with proper inputs, create user and redirects to login page"
#   end
#   feature "user dashboard" do 
#     scenario "displays user information" 
#   end
# end


require 'rails_helper'
feature 'User features ' do
  before do
    # calling factory girl create method
    @user = create(:user)
  end
  feature "user sign-up" do
    before(:each) do
      visit "/register"
    end
    scenario 'visits sign-up page' do
      expect(page).to have_field('name')
      expect(page).to have_field('email')
      expect(page).to have_field('password')
      expect(page).to have_field('password_confirmation')
    end
    scenario "with improper inputs, redirects back to sign in and shows validations" do
      click_button 'Register'
      expect(current_path).to eq('/register')
      expect(page).to have_text("Password can't be blank")
    end
    scenario "with proper inputs, create user and redirects to show page" do 
      fill_in 'email', with: 'curry@warriors.com'
      fill_in 'name', with: 'curry'
      fill_in 'password', with:  'password'
      fill_in 'password_confirmation', with: 'password'
      click_button 'Register'
      expect(current_path).to eq(user_path @user.id+1)
    end
  end
  feature "user dashboard" do 
    before do
      login
    end  
    scenario "displays user information" do 
      expect(page).to have_text("#{@user.name}")
      expect(page).to have_link('Edit Profile')
    end
  end
end

require 'rails_helper'
feature 'User Settings features ' do
  before do
    @user = create(:user)
    login
  end
  feature "User Settings Dashboard" do
    before(:each) do 
      visit "/edit/#{@user.id}"
    end
    scenario "visit users edit page" do
      expect(page).to have_field('email')
      expect(page).to have_field('name')
    end
    scenario "inputs filled out correctly" do 
      expect(find_field('name').value).to eq(@user.name)
      expect(find_field('email').value).to eq(@user.email)      
    end    
    scenario "incorrectly updates information" do
      fill_in 'name', with: 'Another'      
      fill_in 'email', with: 'incorrect email format'
      click_button 'Update'
      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).to have_text("Email is invalid")      
    end    
    scenario "correctly updates information" do 
      fill_in 'Name', with: 'Another'
      fill_in 'Email', with: 'correct@email.com'
      click_button 'Update'
      expect(page).to have_text('Another')
    end
    scenario "destroys user and redirects to registration page" do
      click_button 'Delete Account'
      expect(current_path).to eq('/users/new')
      # Make sure that you're clearing session on destroy
    end
  end
end