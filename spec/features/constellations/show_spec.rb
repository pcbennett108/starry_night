require "rails_helper"


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
  
  # --------  User Story 2, Parent Show 
  # As a visitor
  # When I visit '/parents/:id'
  # Then I see the parent with that id including the parent's attributes
  # (data from each column that is on the parent table)
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
        expect(page).to have_content("There are 2 stars currently in the Lynx database.")
        
        visit "/constellations/#{@pisces.id}"
        expect(page).to have_content("There are 1 stars currently in the Pisces database.")
      end
    end

    # ------   User Story 10, Parent Child Index Link
    # As a visitor
    # When I visit a parent show page ('/parents/:id')
    # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
    describe "I see a link to this constellation's star page" do
      it "links to the constellaton's stars" do
        visit "/constellations/#{@lynx.id}"

        expect(page).to have_content("Stars in #{@lynx.name}")
        click_on "Stars in #{@lynx.name}"
        expect(current_path).to eq("/constellations/#{@lynx.id}/stars")
      end
    end
  end

  describe "When I visit any page on the site" do
    # -----   User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it "has a link at the top for the stars index page" do
      visit "/constellations/#{@lynx.id}"

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
      visit "/constellations/#{@lynx.id}"

      within("#navbar") do
        expect(page).to have_content("All Constellations")
        click_on "All Constellations"
        expect(current_path).to eq("/constellations")
      end
    end
  end

# ---------  User Story 19, Parent Delete 
# As a visitor
# When I visit a parent show page
# Then I see a link to delete the parent
# When I click the link "Delete Parent"
# Then a 'DELETE' request is sent to '/parents/:id',
# the parent is deleted, and all child records are deleted
# and I am redirected to the parent index page where I no longer see this parent
  describe "When I visit a constellation show page, I see a link to delete the constellation and all of it's stars." do
    it "has a link to delete the constellation" do
      visit "/constellations/#{@lynx.id}"

      expect(@lynx).to be_a(constellation)
      expect(page).to have_content("Delete")
      click_link("Delete")

      expect(current_path).to eq("/constellations")
      expect(page).to_not have_content("Lynx")
    end

    it "deletes all associated products when a farm is deleted" do
      visit "/stars"
      expect(page).to have_content("38 Lyncis")
      expect(page).to have_content("XO-5")
      
      visit "/constellations/#{@lynx.id}"
      click_link("Delete")

      visit "/stars"

      expect(page).to_not have_content("38 Lyncis")
      expect(page).to_not have_content("XO-5")
    end
  end
end