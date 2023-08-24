require "rails_helper"

# --------  User Story 2, Parent Show 
# As a visitor
# When I visit '/parents/:id'
# Then I see the parent with that id including the parent's attributes
# (data from each column that is on the parent table)

RSpec.describe "constellations show page", type: :feature do
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
  
  describe "When I visit '/constellations/:id'" do
    describe "I see the constellation with that id and all its attributes" do
      it "displays all constellation attributes" do
        
        visit "/constellations/#{@cons_1.id}"
        #save_and_open_page
        expect(page).to have_content(@cons_1.name)
        expect(page).to have_content(@cons_1.symbolism)
        expect(page).to have_content(@cons_1.bayer_stars)
        expect(page).to have_content(@cons_1.stars_with_planets)
        expect(page).to have_content(@cons_1.in_zodiac)


        expect(page).to_not have_content(@cons_2.name)
      end
      
    end
  end
end