require 'rails_helper'

RSpec.describe 'a user dashboard' do
  before :each do
    User.create(name: 'Will', email: '123@mail.com', password: '345345')
    visit '/login'
    fill_in :email, with: '123@mail.com'
    fill_in :password, with: '345345'
    click_button 'Login'
  end
  it 'displays a header with the users name' do
      visit "/dashboard"

    expect(page).to have_content("Will's Dashboard")
    expect(page).to have_no_content("Elmer's Dashboard")
  end

  it 'has a Discover Movies button' do

      visit "/dashboard"
      click_button "Discover Movies"

      expect(page).to have_current_path("/dashboard/discover")
    end

  it 'has a section that lists viewing parties' do

    visit "/dashboard"

    within '#viewing_parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end

  it 'displays the viewing party that the user has been invited to with details', :vcr do
    user_2 = User.create(name: 'Charles', email: 'abc@mail.com', password: '345345')
    user_3 = User.create(name: 'Dylan', email: 'xyz@mail.com', password: '345345')
    user_4 = User.create(name: 'Samantha', email: 'sam@mail.com', password: '345345')

    visit "/dashboard/movies/278/viewing-party/new"
    fill_in :duration, with: '142'
    fill_in :date, with: Date.current
    fill_in :start_time, with: '00:54 PM'
    within "#user-#{user_2.id}" do
      check
    end

    click_button "Create Party"
    expect(current_path).to eq("/dashboard")
  end
end
