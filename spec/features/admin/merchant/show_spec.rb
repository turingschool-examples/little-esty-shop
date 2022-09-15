require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  describe "Has the merchant's name" do
    it 'shows the name of the merchant' do
      merch_1 = Merchant.create!(name: Faker::Name.name)
      merch_2 = Merchant.create!(name: Faker::Name.name)

      visit "/admin/merchants/#{merch_1.id}"

      within '#merchants_name' do
        expect(page).to have_content(merch_1.name)
        expect(page).to_not have_content(merch_2.name)
      end
    end
  end
end