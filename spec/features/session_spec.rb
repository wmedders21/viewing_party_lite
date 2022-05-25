require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'When I visit the landing page' do
    it 'I see a link to login that takes me to the session login form' do
      visit '/'

      click_link 'Log In'

      expect(current_path).to eq('/login')
    end
  end

  it 'I see a form to login with my unique email and password' do
    user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
    visit '/login'

    fill_in :email, with: "meg@test.com"
    fill_in :password, with: "password123"
    click_button "Submit"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Welcome, #{user.email}")
  end
end
