require 'rails_helper'

RSpec.describe 'admin index' do
  it 'has a list of each merchant in the system' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    visit "/admin/merchants"

    expect(current_path).to eq("/admin/merchants")

    within "#merchant-#{merchant1.id}" do
      expect(page).to have_content("Fake Merchant")
    end
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_content("Another Merchant")
    end

    click_link "#{merchant1.name}"
    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
  end

  it 'has a button to disable or enable a merchant' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    visit "/admin/merchants"
# save_and_open_page

  within "#merchant-#{merchant1.id}" do
    expect(page).to have_button("Disable")
    expect(page).to have_content("Enabled")
    click_button("Disable")
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_button("Enable")
    end
  end
end
