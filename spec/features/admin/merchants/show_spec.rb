require 'rails_helper'

RSpec.describe 'admin merchants show' do
  it 'displays the name of the merchant' do

    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    visit "/admin/merchants/#{merchant1.id}"

    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    expect(page).to have_content("Fake Merchant")
    expect(page).to_not have_content("Another Merchant")
  end

  it 'has a link to update the merchant, once updated, a flash message will appear stating the information was sucessfully updated' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    visit "/admin/merchants/#{merchant1.id}"

    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    expect(page).to have_content("Fake Merchant")
    expect(page).to_not have_content("Another Merchant")

    click_link "Update Merchant"
    expect(current_path).to eq("/admin/merchants/#{merchant1.id}/edit")
    expect(find('form')).to have_content("Name")
    fill_in "Name", with: "Toby"

    click_button "Update"
    expect(page).to have_current_path("/admin/merchants/#{merchant1.id}")
    expect(page).to have_content("Toby")
    expect(page).to_not have_content("Fake Merchant")
    expect(page).to have_content("Successfully Updated")
  end
end
