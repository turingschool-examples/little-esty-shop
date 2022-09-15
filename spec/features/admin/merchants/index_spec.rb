require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  it 'shows the name of each merchant' do

    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit '/admin/merchants'

    within "#merchant-#{merchant1.id}" do
      expect(page).to have_content(merchant1.name)
      expect(page).to_not have_content(merchant2.name)
    end

    within "#merchant-#{merchant2.id}" do
      expect(page).to have_content(merchant2.name)
      expect(page).to_not have_content(merchant3.name)
    end

    within "#merchant-#{merchant3.id}" do
      expect(page).to have_content(merchant3.name)
      expect(page).to_not have_content(merchant1.name)
    end
  end

  it 'takes you to merchant show page when you click on the name of a merchant' do
    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit '/admin/merchants'

    click_link "Bobbis Bees"

    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
  end

end
