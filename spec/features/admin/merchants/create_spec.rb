require 'rails_helper'

RSpec.describe 'Creating a new merchant', type: :feature do
  
  it 'creates a new merchant' do
    visit '/admin/merchants'

    expect(page).to have_link("Add New Merchant")
    click_link("Add New Merchant")

    expect(current_path).to eq('/admin/merchants/new')

    fill_in("Name", with: "Bliffert's Bootleg Beanie Babies")

    click_button("Submit")
    expect(current_path).to eq('/admin/merchants')

    # within("#Merchant-#{Merchant.last.id}") do
      expect(page).to have_content("Bliffert's Bootleg Beanie Babies")
      # expect(page).to have_content("Status: Disabled")
    # end
  end
end
