require 'rails_helper'

RSpec.describe 'Admin merchants edit page' do
  it 'allows the user to edit a merchant' do
    merchant = Merchant.create!(name: 'Bob')

    visit admin_merchants_show_path(merchant.id)

    click_link 'Update Merchant'

    expect(current_path).to eq(admin_merchants_edit_path(merchant.id))

    fill_in :name, with: 'Charles'
    click_button 'Submit'

    expect(current_path).to eq(admin_merchants_show_path(merchant.id))
    expect(page).to have_content("Name: Charles")
  end
end