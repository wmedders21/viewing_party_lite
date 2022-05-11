require 'rails_helper'

RSpec.describe 'a user discover page' do
  it 'has a button to discover top rated movies' do
    user_1 = User.create!(name: 'Buggs', email: 'buggs@bunny.com')

    visit "/users/#{user_1.id}/discover"

    click_button 'Discover Top Rated Movies'

    expect(current_path).to eq("/users/#{user_1.id}/movies?q=top%20rated")
  end

  it 'displays a text-field and sumbit button to search by movie title' do
    user_1 = User.create!(name: 'Buggs', email: 'buggs@bunny.com')

    visit "/users/#{user_1.id}/discover"

    fill_in "Search by Movie Title", with: 'castaway'
    click_button "Search"

    expect(current_path).to eq("/users/#{user_1.id}/movies?q=castaway")
  end
end