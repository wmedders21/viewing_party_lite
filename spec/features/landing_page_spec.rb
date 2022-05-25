require 'rails_helper'

RSpec.describe 'Landing Page' do
  it 'shows the title of the application' do
    visit '/'
    within '#title' do
      expect(page).to have_content("Viewing Party Lite")
    end
  end

  it 'has a button to create a new user' do
    visit '/'
    expect(page).to have_button("Create a New User")
  end

  it 'as a visitor, has no list of existing users with their emails listed' do
    user1 = User.create(name: 'Will', email: 'abc@mail.com', password: '24356243562')
    user2 = User.create(name: 'Craig', email: 'zyx@mail.com', password: '24356243562')
    user3 = User.create(name: 'Alicia', email: '321@mail.com', password: '24356243562')
    visit '/'

    expect(page).to have_no_content('abc@mail.com')
    expect(page).to have_no_content('zyx@mail.com')
    expect(page).to have_no_content('321@mail.com')  
  end

  it 'has a link to the landing page at the top of all pages' do
    User.create(name: 'Will', email: 'abc@mail.com', password: '24356243562')

    visit '/'
    click_link "Login"

    fill_in :email, with: "abc@mail.com"
    fill_in :password, with: '24356243562'
    click_button "Login"

    expect(page).to have_content("Home")
    visit "/dashboard"
    expect(page).to have_content("Home")
  end

  it 'has a link to log in an existing user' do
    User.destroy_all
    user1 = User.create(name: 'Will', email: 'abc@mail.com', password: '24356243562')

    visit '/'
    click_link "Login"
    expect(current_path).to eq('/login')
    fill_in :email, with: "abc@mail.com"
    fill_in :password, with: '24356243562'
    click_button "Login"
    expect(current_path).to eq("/dashboard")
  end

  it 'sad path wrong password' do
    user1 = User.create!(name: 'Will', email: 'abc@mail.com', password: '24356243562')

    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')
    fill_in :email, with: "abc@mail.com"
    fill_in :password, with: '2443562'
    click_button "Login"
    expect(current_path).to eq("/login")
    expect(page).to have_content('Sorry, your credentials are bad')
  end

  it 'after logged in, create new user and login options are replaced by logout' do
    User.create(name: 'Will', email: 'abc@mail.com', password: '24356243562')

    visit '/'
    click_link "Login"
    expect(current_path).to eq('/login')
    fill_in :email, with: "abc@mail.com"
    fill_in :password, with: '24356243562'
    click_button "Login"

    visit '/'

    expect(page).to have_link('Logout')
    expect(page).to have_no_link('Login')
    expect(page).to have_no_button('Create a New User')

    click_link 'Logout'
    expect(current_path).to eq('/')
    expect(page).to have_no_link('Logout')
    expect(page).to have_link('Login')
    expect(page).to have_button('Create a New User')

  end

end
