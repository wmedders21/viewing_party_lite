require 'rails_helper'

RSpec.describe 'a user discover page' do
  before :each do
    User.create(name: 'Will', email: '123@mail.com', password: '345345')
    visit '/login'
    fill_in :email, with: '123@mail.com'
    fill_in :password, with: '345345'
    click_button 'Login'
  end
  it 'has a button to discover top rated movies', :vcr do
    visit "/dashboard/discover"

    click_button "Discover Top Rated Movies"

    expect(current_path).to eq("/dashboard/movies")
  end

  it 'displays a text-field and sumbit button to search by movie title', :vcr do

    visit "/dashboard/discover"

    fill_in :q, with: 'castaway'
    click_button "Search"

    expect(current_path).to eq("/dashboard/movies")
  end
end
