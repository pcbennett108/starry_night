require "rails_helper"


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
    @star_5 = @lynx.stars.create!(
      name: "HD 75898",
      distance: 255,
      mass: 1.26,
      radius: 1.58,
      visible: false
    )
    @star_6 = @lynx.stars.create!(
      name: "SZ Lyncis",
      distance: 1700,
      mass: 1.7,
      radius: 2.68,
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
  
    # ---------  User Story 5, Parent Children Index 
    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    # Then I see each Child that is associated with that Parent with each Child's attributes
    # (data from each column that is on the child table)
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

  describe "When I visit any page on the site" do
    # -----   User Story 8, Child Index Link
    # As a visitor
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Child Index
    it "has a link at the top for the stars index page" do
      visit "/constellations"

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
      visit "/constellations"

      within("#navbar") do
        expect(page).to have_content("All Constellations")
        click_on "All Constellations"
        expect(current_path).to eq("/constellations")
      end
    end
  end

    # -------    User Story 16, Sort Parent's Children in Alphabetical Order by name 
    # As a visitor
    # When I visit the Parent's children Index Page
    # Then I see a link to sort children in alphabetical order
    # When I click on the link
    # I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
  it "has a link to sort products alphabetically" do
    visit "/constellations/#{@lynx.id}/stars"

    expect(page.all(".star")[0]).to have_content("38 Lyncis")
    expect(page.all(".star")[1]).to have_content("XO-5")
    expect(page.all(".star")[2]).to have_content("HD 75898")
    expect(page.all(".star")[0]).to_not have_content("Eta Piscium")
    click_link("Sort by Name")
    
    expect(current_path).to eq("/constellations/#{@lynx.id}/stars")

    expect(page.all(".star")[0]).to have_content("38 Lyncis")
    expect(page.all(".star")[1]).to have_content("HD 75898")
    expect(page.all(".star")[2]).to have_content("SZ Lyncis")
    expect(page.all(".star")[0]).to_not have_content("Eta Piscium")
  end
end
