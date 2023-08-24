require "rails_helper"

# ----- User Story 1, Parent Index 
# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

RSpec.describe "constellations index page", type: :feature do
  before :each do
      @cons_1 = Constellation.create!(
        name: "Lynx",
        symbolism: "The faint Tiger",
        bayer_stars: 42,
        stars_with_planets: 6,
        in_zodiac: false
      )
      @cons_2 = Constellation.create!(
        name: "Pisces",
        symbolism: "The Fishes",
        bayer_stars: 86,
        stars_with_planets: 13,
        in_zodiac: true
      )
  end
  
  describe "When I visit '/constellations'" do
    describe "I see the name of each constellation in the system" do
      it "displays all constellations" do
        
        visit '/constellations'
        #save_and_open_page
        expect(page).to have_content(@cons_1.name)
        expect(page).to have_content(@cons_2.name)
      end
      
    end
  end
end