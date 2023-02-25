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

    it 'has buttons to disable or enable that merchant' do
      visit '/admin/merchants'


      
      within "#merchant_name-#{@merchant_1.id}" do
        expect(page).to have_content("Status: #{@merchant_1.status}")
        expect(page).to have_content("Status: enabled")
        expect(page).to have_button("Disable/Enable")
        click_on("Disable/Enable")
      end

      expect(current_path).to eq("/admin/merchants")

      expect(page).to have_content("Status: disabled")
    end
  end
end