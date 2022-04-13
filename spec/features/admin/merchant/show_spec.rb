require 'rails_helper'

RSpec.describe "Admin Merchants Show" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")
  end

  it 'has a link for each merchant show page' do
    visit '/admin/merchants'

    expect(page).to have_link(@merchant_1.name)

    click_link @merchant_1.name

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
  end

  it 'displays the admin merchant show page' do
    visit "/admin/merchants/#{@merchant_1.id}"

    within(".header") do
      expect(page).to have_content("Merchant Show - Admin")
    end

    within("#text") do
      expect(page).to have_content("Name: ")
      expect(page).to have_content("Mollys")
      expect(page).to_not have_content("Berrys")
    end
  end
end
