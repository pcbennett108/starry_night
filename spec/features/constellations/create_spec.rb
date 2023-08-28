require "rails_helper"

# -------   User Story 11, Parent Creation 
# As a visitor
# When I visit the Parent Index page
# Then I see a link to create a new Parent record, "New Parent"
# When I click this link
# Then I am taken to '/parents/new' where I  see a form for a new parent record
# When I fill out the form with a new parent's attributes:
# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route,
# a new parent record is created,
# and I am redirected to the Parent Index page where I see the new Parent displayed.

describe "When I visit the Constellation Index page" do
  it "contains a link to the 'Add New Constellation' form" do
    visit "/constellations/new"
    
    expect(page).to have_content("All Constellations")
    expect(page).to have_content("All Stars")
    expect(page).to have_content("Add New Constellation")
    expect(page).to have_field(:name)
    expect(page).to have_field(:symbolism)
    expect(page).to have_field(:bayer_stars)
    expect(page).to have_field(:stars_with_planets)
    expect(page).to have_field(:in_zodiac)
    expect(page).to have_button(type: "submit")
  end
end

describe "When I fill out the form and click submit, a new constellation is created and I am redirected back to the constellation index page" do
  it "Accepts user input to create a new constellation" do
    visit "/constellations/new"

    expect(Constellation.all).to eq([])

    
    fill_in "name", with: "Zonaii"
    fill_in "symbolism", with: "The Ghost"
    fill_in "bayer_stars", with: 22
    fill_in "stars_with_planets", with: 8

    click_on "Save"
    #binding.pry
    #save_and_open_page
    #expect(Constellation.all.size).to eq(1)
    # zonaii = Constellation.first
          
    # expect(current_path).to eq("/farms")
    # expect(page).to have_content("Bob's Berries")
    # expect(page).to have_content("Date Posted: #{bob.created_at}")
    
  end
end