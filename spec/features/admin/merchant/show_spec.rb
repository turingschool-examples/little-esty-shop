require 'rails_helper'

RSpec.describe 'Admin merchant show page' do
  it 'displays a merchants information' do
    merchant = Merchant.create!(name: 'Bob')

    visit admin_merchants_show_path(merchant.id)

    expect(page).to have_content("Merchant ##{merchant.id}")
    expect(page).to have_content('Name: Bob')
  end
end