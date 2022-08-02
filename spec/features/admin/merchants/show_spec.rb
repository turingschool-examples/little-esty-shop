require 'rails_helper'

RSpec.describe 'admin merchants show' do
  it 'displays the name of the merchant' do

    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Merchant')

    visit "/admin/merchants/#{merchant1.id}"

    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    expect(page).to have_content("Fake Merchant")
    expect(page).to_not have_content("Another Merchant")
  end
end
