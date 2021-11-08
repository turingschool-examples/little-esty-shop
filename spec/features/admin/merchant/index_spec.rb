require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  it 'has a link to create a new merchant' do
    visit admin_merchants_path

    click_link 'Create Merchant'

    expect(current_path).to eq(admin_merchants_new_path)

    fill_in :name, with: 'Bob'
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Name: Bob')
    expect(page).to have_content('Status: Disabled')
  end

  it 'has a button to change the status of a merchant' do
    merchant1 = Merchant.create!(name: 'Alan Apple')
    merchant2 = Merchant.create!(name: 'Bob Burger')
    
    visit admin_merchants_path

    within "#id-#{merchant1.id}" do
      expect(page).to have_button("Enable/Disable")
    end

    within "#id-#{merchant2.id}" do
      expect(page).to have_button("Enable/Disable")
    end
  end

  it 'when the button is clicked it changes the status of the merchant' do
    merchant1 = Merchant.create!(name: 'Alan Apple', status: 'Enabled')
    
    visit admin_merchants_path

    within "#id-#{merchant1.id}" do
      click_button 'Enable/Disable'
      expect(page).to have_content("Status: Disabled")
    end

  end
end