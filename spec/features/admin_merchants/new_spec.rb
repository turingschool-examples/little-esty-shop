require 'rails_helper'

RSpec.describe 'New Merchant Form' do
  it 'allows you to add merchant information and has a default status of disabled', :vcr do
    visit new_merchant_path

    expect(page).to have_content "New Merchant Form"
    fill_in 'Name', with: 'Pop Rock Enterprises'
    click_button 'Submit'
    expect(current_path).to eq("/admin/merchants")

    within ".disabled-merchants" do
      expect(page).to have_content('Pop Rock Enterprises')
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')
    end
  end

  it 'returns an error if required info is missing', :vcr do
    visit new_merchant_path

    click_button 'Submit'

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content('A Required Field Was Missing; Merchant Not Created')
  end
end
