require 'rails_helper'

RSpec.describe 'Movie results page' do
  describe 'As a user when I visit the Movie Results page top movies' do
    before :each do
      User.create(name: 'Will', email: '123@mail.com', password: '345345')
      visit '/login'
      fill_in :email, with: '123@mail.com'
      fill_in :password, with: '345345'
      click_button 'Login'
    end
    it 'displays the titles of the top rated movies as a link the movie details page', :vcr do

      visit "/dashboard/discover"
      click_button "Discover Top Rated Movies"
      click_button "Discover"
      click_button "Discover Top Rated Movies"
      click_link "The Shawshank Redemption"

      expect(current_path).to eq("/dashboard/movies/278")
    end

    it 'displays the vote average of the movie', :vcr do

      visit "/dashboard/discover"
      click_button "Discover Top Rated Movies"

      within "#movie-278" do
        expect(page).to have_content("8.7")
      end
    end
  end
  describe 'Search for title by name' do
    before :each do
      User.create(name: 'Will', email: '123@mail.com', password: '345345')
      visit '/login'
      fill_in :email, with: '123@mail.com'
      fill_in :password, with: '345345'
      click_button 'Login'
    end
    it 'returns search results for movie title', :vcr do

      visit "/dashboard/discover"
      fill_in :q, with: 'Castaway'
      click_button "Search"

      within "#movie-52886" do
        expect(page).to have_content("6.4")
      end

      within "#movie-52886" do
        click_link "Castaway"
      end

      expect(current_path).to eq("/dashboard/movies/52886")
    end
  end
end
