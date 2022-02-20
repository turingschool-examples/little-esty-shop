require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  describe 'user story #17' do
    it "when visiting /admin/merchants I see the name of each merchant" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")
      merchant_2 = Merchant.create!(name: 'Handmade in CO Co.')
      merchant_3 = Merchant.create!(name: 'Moss Box Inc')

      visit "/admin/merchants"

      expect(page).to have_content("LT's Tee Shirts LLC")
      expect(page).to have_content('Handmade in CO Co.')
      expect(page).to have_content('Moss Box Inc')
    end
  end

  describe 'user story #14' do
    before :each do
      @merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")
      @merchant_2 = Merchant.create!(name: 'Handmade in CO Co.')

      visit "/admin/merchants"
    end

    it "enable/disable button appears next to each merchant - toggles status" do
      within("#merchant-#{@merchant_1.id}") do
        expect(@merchant_1.status).to eq("disabled")
        expect(page).to have_button("Enable")
        click_button "Enable"
        expect(@merchant_1.status).to eq("disabled")
      end
    end
  end

  describe 'user story #13' do
    before :each do
      @merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC", status: 0)
      @merchant_2 = Merchant.create!(name: 'Handmade in CO Co.', status: 1)

      visit "/admin/merchants"
    end

    it "enabled merchants div shows enabled merchants" do
      within("#enabled_merchants") do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_1.name)
      end

      within("#disabled_merchants") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
      end
    end
  end
end
