require "rails_helper"

# --------  User Story 2, Parent Show 
# As a visitor
# When I visit '/parents/:id'
# Then I see the parent with that id including the parent's attributes
# (data from each column that is on the parent table)

RSpec.describe "constellations show page", type: :feature do
  before :each do
      @lynx = Constellation.create!(
        name: "Lynx",
        symbolism: "The faint Tiger",
        bayer_stars: 42,
        stars_with_planets: 6,
        in_zodiac: false
      )
      @pisces = Constellation.create!(
        name: "Pisces",
        symbolism: "The Fishes",
        bayer_stars: 86,
        stars_with_planets: 13,
        in_zodiac: true
      )
      @star_1 = @lynx.stars.create!(
        name: "38 Lyncis",
        distance: 117,
        mass: 1.9,
        radius: 3.07,
        visible: true
      )
      @star_2 = @lynx.stars.create!(
        name: "XO-5",
        distance: 910,
        mass: 0.88,
        radius: 1.08,
        visible: false
      )
      @star_3 = @pisces.stars.create!(
        name: "Eta Piscium",
        distance: 350,
        mass: 3.78,
        radius: 26.48,
        visible: true
      )
  end
  
  describe "When I visit '/constellations/:id'" do
    describe "I see the constellation with that id and all its attributes" do
      it "displays all constellation attributes" do
        
        visit "/constellations/#{@lynx.id}"
        #save_and_open_page
        expect(page).to have_content(@lynx.name)
        expect(page).to have_content(@lynx.symbolism)
        expect(page).to have_content(@lynx.bayer_stars)
        expect(page).to have_content(@lynx.stars_with_planets)
        expect(page).to have_content(@lynx.in_zodiac)
        expect(page).to_not have_content(@pisces.name)
      end
    end
    
    # -------   User Story 7, Parent Child Count
    # As a visitor
    # When I visit a parent's show page
    # I see a count of the number of children associated with this parent
    describe "I see a count of this constellation's stars" do
      it "displays the star count for each constellation" do
        
        visit "/constellations/#{@lynx.id}"
        expect(page).to have_content("There are 2 stars in Lynx.")
        
        visit "/constellations/#{@pisces.id}"
        expect(page).to have_content("There are 1 stars in Pisces.")
      end
    end

  end
end