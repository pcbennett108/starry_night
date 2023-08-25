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
        
        expect(page).to have_content("Posted on: #{@cons_1.created_at}")
        expect(page).to have_content("Posted on: #{@cons_2.created_at}")
        expect(page).to have_content("Posted on: #{@cons_3.created_at}")
      end
      
      it "lists constellations in order, newest first" do
        visit '/constellations'

        expect(page.all(".constellation")[0]).to have_content("Pegasus")
        expect(page.all(".constellation")[1]).to have_content("Pisces")
        expect(page.all(".constellation")[2]).to have_content("Lynx")
      end
    end



  end
end