require 'rails_helper'



RSpec.describe 'Creating a new merchant', type: :feature do
  # before do
  #   @merchant = create(:merchant)
  # end
  xit 'creates a new merchant' do
    ########## Accidentally started writing the admin merchant create spec in here, keeping this in case any of it applies! --Mark
    visit '/admin/merchants'

    expect(page).to have_link("Add New Merchant")
    click_link("Add New Merchant")

    expect(current_path).to eq('admin/merchants/new')

    fill_in("Name", with: "Bliffert's Bootleg Beanie Babies")

    click_button("Submit")
    expect(current_path).to eq('admin/merchants')

    # within("#Merchant-#{Merchant.last.id}") do
      expect(page).to have_content("Bliffert's Bootleg Beanie Babies")
      # expect(page).to have_content("Status: Disabled")
    # end
  end
end
