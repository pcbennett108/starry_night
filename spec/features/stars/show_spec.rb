require "rails_helper"

# --------- User Story 4, Child Show 
# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes
# (data from each column that is on the child table)

RSpec.describe "stars index page", type: :feature do
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
      @star_4 = @pisces.stars.create!(
        name: "WASP-76",
        distance: 640,
        mass: 1.46,
        radius: 1.73,
        visible: false
      )
  end
  
  describe "When I visit '/stars/:id'" do
    describe "I see the star with that id" do
      it "displays all star attributes" do
        visit "/stars/#{@@star_1.id}"
        #save_and_open_page
        expect(page).to have_content(@star_1.name)
        expect(page).to have_content(@star_1.distance)
        expect(page).to have_content(@star_1.mass)
        expect(page).to have_content(@star_1.radius)
        expect(page).to have_content(@star_1.visible)
      end
    end
  end
end