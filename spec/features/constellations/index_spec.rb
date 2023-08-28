require "rails_helper"


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
    @cons_3 = Constellation.create!(
      name: "Pegasus",
      symbolism: "The Winged Horse",
      bayer_stars: 88,
      stars_with_planets: 12,
      in_zodiac: false
    )
  end
  
  # ----- User Story 1, Parent Index 
  # For each parent table
  # As a visitor
  # When I visit '/parents'
  # Then I see the name of each parent record in the system
  describe "When I visit '/constellations'" do
    describe "I see the name of each constellation in the system" do
      it "displays all constellations" do
        visit '/constellations'
        #save_and_open_page
        expect(page).to have_content(@cons_1.name)
        expect(page).to have_content(@cons_2.name)
      end
      it "displays only constellation names" do
        visit '/constellations'
        
        expect(page).to_not have_content("The faint Tiger")
        expect(page).to_not have_content("false")
      end
    end
    
    # ---- User Story 6, Parent Index sorted by Most Recently Created 
    # As a visitor
    # When I visit the parent index,
    # I see that records are ordered by most recently created first
    # And next to each of the records I see when it was created
    describe "constellations are in order by most recent" do
      it "shows creation date for each constellation record" do
        visit '/constellations'
        
        expect(page).to have_content("Posted On")
        expect(page).to have_content("#{@cons_1.created_at}")
        expect(page).to have_content("#{@cons_2.created_at}")
        expect(page).to have_content("#{@cons_3.created_at}")
      end
      
      it "lists constellations in order, newest first" do
        visit '/constellations'

        expect(page.all(".constellation")[0]).to have_content("Pegasus")
        expect(page.all(".constellation")[1]).to have_content("Pisces")
        expect(page.all(".constellation")[2]).to have_content("Lynx")
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

      # ------- User Story 17, Parent Update From Parent Index Page 
      # As a visitor
      # When I visit the parent index page
      # Next to every parent, I see a link to edit that parent's info
      # When I click the link
      # I should be taken to that parent's edit page where I can update its information just like in User Story 12
      describe "I see an edit constellation link for every constellation" do
        it "has a link by each farm to edit that farm" do
          visit "/constellations"

          expect(page).to have_content("Edit Info For Scarlet Orchards")
          expect(page).to have_content("Edit Info For Golden Orchards")
          expect(page).to have_content("Edit Info For Lilac Vineyard")
          expect(page).to have_content("Edit Info For Valerie's Veggies")

          click_link("Edit Info For Scarlet Orchards")
          expect(current_path).to eq("/farms/#{@scarlet.id}/edit")
        end
      end

  end
end