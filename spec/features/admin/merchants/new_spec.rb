require 'rails_helper'

RSpec.describe 'Create new merchant' do
  it 'has a link on the admin dashboard form to create a new merchant and the status is set to disabled by default' do
    visit "/admin/merchants"

    within("#admin_dashboard") do
      expect(page).to have_link("New Merchant")

      click_on "New Merchant"
    end
    
    expect(current_path).to eq("/admin/merchants/new")

    fill_in :name, with: "Banana Fran"
    click_on "Create Merchant"
    expect(current_path).to eq("/admin/merchants")

    within("#disabled_merchants") do
      expect(page).to have_content("Banana Fran")
    end
  end

  it 'returns an error message if the name is not inputted' do
    visit "/admin/merchants"

    expect(page).to have_link("New Merchant")
    click_on "New Merchant"
 
  
    expect(current_path).to eq("/admin/merchants/new")

    fill_in :name, with: nil
    click_on "Create Merchant"
    expect(current_path).to eq("/admin/merchants/new")
    expect(page).to have_content("ERROR: Please enter a valid name.")
  end
end