require 'rails_helper'

RSpec.describe "admin merchants index" do

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Mel's Travels")
    @merchant_2 = Merchant.create!(name: "Hady's Beach Shack")
    @merchant_3 = Merchant.create!(name: "Huy's Cheese")
  end

  describe 'merchant index' do
    it 'displays the name of each merchant in the system' do
      visit '/admin/merchants'

      within "#merchant_name-#{@merchant_1.id}" do
        expect(page).to have_content("#{@merchant_1.name}")
      end
      within "#merchant_name-#{@merchant_2.id}" do
        expect(page).to have_content("#{@merchant_2.name}")
      end
      within "#merchant_name-#{@merchant_3.id}" do
        expect(page).to have_content("#{@merchant_3.name}")
      end
    end
  end
end