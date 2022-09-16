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

    expect(current_path).to eq(admin_merchants_path(merchant1.id))
  end

  it 'has a button to disable or enable next to each merchant, when I click it I am stay on the index page but the merchant status has changed' do
    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit '/admin/merchants'

    within "#merchant-#{merchant1.id}" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
    end

    within "#merchant-#{merchant2.id}" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
    end

    within "#merchant-#{merchant3.id}" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")

      click_button("Disable")

      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")

    end


  end

  xit 'has a link to create a new merchant' do
    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit '/admin/merchants'

    expect(page).to have_content("Create a new merchant")

    click_link 'Create a new merchant'

    expect(current_path).to eq('/admin/merchants/new')
  end
end
