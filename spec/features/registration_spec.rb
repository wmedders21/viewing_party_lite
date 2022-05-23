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
    fill_in :password, with: "3245rfwr4"
    fill_in :password_confirmation, with: "3245rfwr4"

    click_button "Create a New User"

    george = User.all[0]
    expect(current_path).to eq("/users/#{george.id}")
  end

  describe 'flash messages' do
    it 'requires unique email' do
      visit '/register'

      fill_in :name, with: "George"
      fill_in :email, with: "george@mail.com"
      fill_in :password, with: "3245rfwr4"
      fill_in :password_confirmation, with: "3245rfwr4"
      click_button "Create a New User"

      visit '/register'

      fill_in :name, with: "Other George"
      fill_in :email, with: "george@mail.com"
      fill_in :password, with: "3245rfwr4"
      fill_in :password_confirmation, with: "3245rfwr4"
      click_button "Create a New User"

      expect(current_path).to eq('/register')
      expect(page).to have_content('Email has already been taken')
    end

    it 'rejects empty fields' do
      visit '/register'

      fill_in :name, with: ""
      fill_in :email, with: "billy@mail.com"
      fill_in :password, with: "3245rfwr4"
      fill_in :password_confirmation, with: "3245rfwr4"
      click_button "Create a New User"

      expect(current_path).to eq('/register')
      expect(page).to have_content("Name can't be blank")

      visit '/register'

      fill_in :name, with: "Alfalfa"
      fill_in :email, with: ""
      fill_in :password, with: "3245rfwr4"
      fill_in :password_confirmation, with: "3245rfwr4"
      click_button "Create a New User"

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email can't be blank")
    end
  end
end
