require 'rails_helper'

RSpec.describe "Admin Merchants Index" do
  it 'displays a header showing the Admin Merchants Index' do
    visit '/admin/merchants'

    within(".header") do
      expect(page).to have_content("Merchant Index - Admin")
    end
  end

  it 'displays all of the merchants' do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")
    @merchant_3 = Merchant.create!(name: "Jimmys")

    visit '/admin/merchants'

    within(".index") do
      expect(page).to have_content('Mollys')
      expect(page).to have_content('Berrys')
      expect(page).to have_content('Jimmys')
      expect(page).to_not have_content('Willys')
    end
  end
end
