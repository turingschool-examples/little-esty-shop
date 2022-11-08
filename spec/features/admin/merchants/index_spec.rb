require 'rails_helper'

RSpec.feature "Admin Merchant Index", type: :feature do
  describe 'when visiting the page' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Crystal Moon Designs")
      @merchant_2 = Merchant.create!(name: "Surf & Co. Designs")
      @merchant_3 = Merchant.create!(name: "Outer Outfitters")
    end

    it 'has the name of each merchant in the system' do
      visit admin_merchants_path

      expect(page).to have_content("Crystal Moon Designs")
      expect(page).to have_content("Surf & Co. Designs")
      expect(page).to have_content("Outer Outfitters")
    end

    xit 'has two sections, one for enabled merchants and one for disabled merchants.
    I see that each merchant is listed in the appropriate section' do
      visit admin_merchants_path


    end
  end
end
