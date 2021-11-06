require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Bob's Burgers")
  end

  it 'displays the name of all merchants' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_1.name)
  end

  it 'links to each merchants show page' do
    visit '/admin/merchants'

    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_link(@merchant_1.name)
  end

  xit 'has a button to enable/disable a given merchant' do
    visit '/admin/merchants'

    expect(page).to have_button("Disable")
    expect(@merchant_1.status).to eq(true)

    within(".#{@merchant_1.id}-button") do
      click_button "Disable"
    end

    expect(page).to have_button("Enable")
    expect(@merchant_1.status).to eq(false)
  end

  it 'provides a link to create a new merchant' do
    visit '/admin/merchants'

    click_link "Create New Merchant"
    expect(current_path).to eq("/admin/merchant/new")
  end
end
