require "rails_helper"


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

  # ---------- User Story 3, Child Index 
  # As a visitor
  # When I visit '/child_table_name'
  # Then I see each Child in the system including the Child's attributes
  # (data from each column that is on the child table)
  
  describe "When I visit '/stars'" do
    describe "I see the name of each star in the system" do
      it "displays all stars" do
        visit '/stars'
        #save_and_open_page
        expect(page).to have_content(@star_1.name)
        expect(page).to have_content(@star_2.name)
        expect(page).to have_content(@star_3.name)
        expect(page).to have_content(@star_4.name)
      end
    end
    describe "I see all attributes of each star in the system" do
      it "displays all star attributes" do
        visit '/stars'
        expect(page).to have_content(@star_1.name)
        expect(page).to have_content(@star_1.distance)
        expect(page).to have_content(@star_1.mass)
        expect(page).to have_content(@star_1.radius)
        expect(page).to have_content(@star_1.visible)
      end
    end
  end

  describe "When I visit any page on the site" do
    # -----   User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it "has a link at the top for the stars index page" do
      visit "/stars"
      within("#navbar") do
        expect(page).to have_content("All Stars")
        click_on "All Stars"
        expect(current_path).to eq("/stars")
      end
    end
    
    # ------   User Story 9, Parent Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Parent Index
    it "has a link at the top for the constellations index page" do
      visit "/stars"

      within("#navbar") do
        expect(page).to have_content("All Constellations")
        click_on "All Constellations"
        expect(current_path).to eq("/constellations")
      end
    end
  end

    # ------   User Story 15, Child Index only shows `true` Records 
    # As a visitor
    # When I visit the child index
    # Then I only see records where the boolean column is `true`
  describe "When I visit the stars index" do
    it "only shows records of visible stars" do
      visit "/stars"
      click_on "Visible to Naked Eye"
      expect(page).to have_content("38 Lyncis")
      expect(page).to have_content("Eta Piscium")
      expect(page).to_not have_content("XO-5")
      expect(page).to_not have_content("WASP-76")
    end
  end
end