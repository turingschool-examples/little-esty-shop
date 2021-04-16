require 'rails_helper'

RSpec.describe 'admin merchant show page', type: :feature do
  it 'has the name of the merchant' do
    merchant1 = Merchant.create!(name: "Abe")
    
    visit "/admin/merchants/#{merchant1.id}"
    
    expect(page).to have_content(merchant1.name)
  end
  
  it 'has a link to update the merchants attributes' do
    merchant1 = Merchant.create!(name: "Abe")

    visit "/admin/merchants/#{merchant1.id}"
    
    expect(page).to have_link("Update")
    click_link "Update"
    expect(current_path).to eq("/admin/merchants/#{merchant1.id}/edit")
  end
end