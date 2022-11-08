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

    it 'next to each merchant name, I see a button to disable or enable that merchant.
    when I click this button, I am redirected back to the admin merchants index and
    I see that the merchants status has changed' do

    end
    
    xit 'has two sections, one for enabled merchants and one for disabled merchants.
    I see that each merchant is listed in the appropriate section' do
      visit admin_merchants_path


    end
  end
end
