require "rails_helper"

# ---------  User Story 5, Parent Children Index 
# As a visitor
# When I visit '/parents/:parent_id/child_table_name'
# Then I see each Child that is associated with that Parent with each Child's attributes
# (data from each column that is on the child table)

RSpec.describe "constellation stars index page", type: :feature do
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
  
  describe "When I visit '/constellations/:const_id/stars'" do
    describe "I see each star associated with that constellation" do
      it "displays all star attributes" do
        visit "/constellations/#{@lynx.id}/stars"
        #save_and_open_page
        expect(page).to have_content(@star_1.name)
        expect(page).to have_content(@star_1.distance)
        expect(page).to have_content(@star_1.mass)
        expect(page).to have_content(@star_1.radius)
        expect(page).to have_content(@star_1.visible)
        
        expect(page).to have_content(@star_2.name)
        expect(page).to have_content(@star_2.distance)
        expect(page).to have_content(@star_2.mass)
        expect(page).to have_content(@star_2.radius)
        expect(page).to have_content(@star_2.visible)
        
      end
      it "only displays stars belonging to that constellation's id" do
        visit "/constellations/#{@lynx.id}/stars"

        expect(page).to_not have_content(@star_3.name)
        expect(page).to_not have_content(@star_4.name)

      end
    end
  end
end
