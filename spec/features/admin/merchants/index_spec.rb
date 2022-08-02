require 'rails_helper'

RSpec.describe 'admin index' do
  it 'has a list of each merchant in the system' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Merchant')
    merchant3 = Merchant.create!(name: 'Faux Merchant')

    visit "/admin/merchants"

    expect(current_path).to eq("/admin/merchants")

    within "#merchant-#{merchant2.id}" do
      expect(page).to have_content("Another Merchant")
    end
    
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_content("Fake Merchant")
      click_link "#{merchant1.name}"
      expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    end
  end
end
