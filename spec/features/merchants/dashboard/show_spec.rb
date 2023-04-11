require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
 before(:each) do
  @merchant_1 = Merchant.create!(name: "Megans Marmalades")
  @merchant_2 = Merchant.create!(name: "Brians Bagels")
  @merchant_3 = Merchant.create!(name: "Legolas' Lembas")
  @merchant_4 = Merchant.create!(name: "Gandalf's Gummies")
  @merchant_5 = Merchant.create!(name: "Aragorn's Apples")
 end

  describe 'As a merchant' do
    it 'I can see my merchant dashboard' do
      visit dashboard_merchant_path(@merchant_1)

      expect(page).to have_content("Megans Marmalades")

      visit dashboard_merchant_path(@merchant_2)

      expect(page).to have_content("Brians Bagels")
    end
  end
end