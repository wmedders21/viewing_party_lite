require 'rails_helper'

RSpec.describe 'registration page' do
  it 'displays nav bar, title of application, and registration header' do
    visit '/register'

    expect(page).to have_link('Home')
    expect(page).to have_content('Viewing Party Lite')
    expect(page).to have_content('Register a New User')
  end

  it 'displays a user registration form' do
    visit '/register'

    fill_in :name, with: "George"
    fill_in :email, with: "george@mail.com"
    fill_in :password, with: "test1"
    fill_in :password_confirmation, with: "test1"
    click_button "Create a New User"

    george = User.all[0]
    expect(current_path).to eq("/users/#{george.id}")
    user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq('password123')
  end

  describe 'flash messages' do
    xit 'requires unique email' do
      visit '/register'

      fill_in :name, with: "George"
      fill_in :email, with: "george@mail.com"
      click_button "Create a New User"

      visit '/register'

      fill_in :name, with: "Other George"
      fill_in :email, with: "george@mail.com"
      click_button "Create a New User"

      expect(current_path).to eq('/register')
      expect(page).to have_content('Sorry. That email address is not available.')
    end

    it 'rejects empty fields' do
      visit '/register'

      fill_in :name, with: ""
      fill_in :email, with: "billy@mail.com"
      click_button "Create a New User"

      expect(current_path).to eq('/register')
      expect(page).to have_content('Please fill out all fields.')

      visit '/register'

      fill_in :name, with: "Alfalfa"
      fill_in :email, with: ""
      click_button "Create a New User"

      expect(current_path).to eq('/register')
      expect(page).to have_content('Please fill out all fields.')
    end
  end
end
