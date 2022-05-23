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

  it 'has a list of existing users with their names as links to their individual dashboard' do
    user1 = User.create!(name: 'Will', email: 'abc@mail.com', password: '24356243562')
    user2 = User.create!(name: 'Craig', email: 'zyx@mail.com', password: '24356243562')
    user3 = User.create!(name: 'Alicia', email: '321@mail.com', password: '24356243562')
    visit '/'
    within "#existing_users" do
      click_link "#{user1.name}'s Dashboard"
      expect(page).to have_current_path("/users/#{user1.id}")
    end

    visit '/'
    within "#existing_users" do
      click_link "#{user2.name}'s Dashboard"
      expect(page).to have_current_path("/users/#{user2.id}")
    end

    visit '/'
    within "#existing_users" do
      click_link "#{user3.name}'s Dashboard"
      expect(page).to have_current_path("/users/#{user3.id}")
    end
  end

  it 'has a link to the landing page at the top of all pages' do
    user1 = User.create!(name: 'Will', email: 'abc@mail.com', password: '24356243562')

    visit '/'
    expect(page).to have_content("Home")
    visit "/users/#{user1.id}"
    expect(page).to have_content("Home")
  end

  it 'has a link to log in an existing user' do
    user1 = User.create!(name: 'Will', email: 'abc@mail.com', password: '24356243562')

    visit '/'

    click_link "Login"
    expect(current_path).to eq('/login')
    fill_in :email, with: "abc@mail.com"
    fill_in :password, with: '24356243562'
    click_button "Login"
    expect(current_path).to eq("/users/#{user1.id}")
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
    expect(page).to have_content('Incorrect login credentials')
  end

end
