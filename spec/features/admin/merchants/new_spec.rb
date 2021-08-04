require 'rails_helper'
RSpec.describe '' do
  before :each do
    visit "/admin/merchants/new"
  end
  it 'can click a link on the admin merchant index page and be taken to new form' do
    visit "/admin/merchants"
    
    click_link("create a new merchant")

    expect(current_path).to eq("/admin/merchants/new")
  end

  it 'can fill and create a new merchant thorugh the admin merchant path' do
    
    fill_in("Name", with: "Suzie")

    click_button("Create Merchant")

    expect(current_path).to eq("/admin/merchants")

    merchant = Merchant.last

    within "#disabled-admin-merchants-#{merchant.id}" do
      expect(page).to have_content("Suzie")
    end
      
  end

  it 'does not fill out a name and redirects to the new form and gives a flash message' do
    fill_in("Name", with: "")

    click_button("Create Merchant")

    expect(current_path).to eq("/admin/merchants/new")
    expect(page).to have_content("Error: Name can't be blank")
  end
end