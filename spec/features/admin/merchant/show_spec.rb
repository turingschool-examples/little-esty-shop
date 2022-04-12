require 'rails_helper'

RSpec.describe "Admin Merchants Show" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Mollys")
    @merchant_2 = Merchant.create!(name: "Berrys")
  end

  it 'displays the admin merchant show page' do
    visit "/admin/merchants/#{@merchant_1.id}"

    within(".header") do
      expect(page).to have_content("Merchant Show - Admin")
    end

    within("merch-#{@merchant_1.id}") do
      expect(page).to have_content("Mollys")
      expect(page).to_not have_content("Berrys")
    end
  end
end
