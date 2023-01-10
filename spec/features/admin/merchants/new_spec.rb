require 'rails_helper'

RSpec.describe 'Admin Merchant New' do
  it 'Shows a form to create a new merchant' do
    visit admin_merchants_path
    click_on('Create a new merchant')

    fill_in('merchant[name]', with: "Jimbob's Carpentry")
    click_button('Create Merchant')

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Jimbob's Carpentry")
    within("#merchant_#{Merchant.find_by_name("Jimbob's Carpentry").id}") do
      expect(page).to have_button('Enable')
    end
  end
end
