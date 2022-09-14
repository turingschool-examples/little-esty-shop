require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  describe "A list of all merchants' names" do
    it 'shows the names of each merchant' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch3 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch4 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch5 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      all_merchants = [merch1, merch2, merch3, merch4, merch5]
      visit "/admin/merchants"

      within '#merchants' do
        all_merchants.each do |merchant|
          within "#merchant_#{merchant.id}" do
            expect(page).to have_content("#{merchant.name}")
          end
        end
      end
    end

    it 'has each merchant name is a link to the admin merchant show page' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch3 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch4 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch5 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      all_merchants = [merch1, merch2, merch3, merch4, merch5]
      visit "/admin/merchants"

      within '#merchants' do
        all_merchants.each do |merchant|
          within "#merchant_#{merchant.id}" do
            click_link("#{merchant.name}")
            expect(page).to have_current_path("/admin/merchants/#{merchant.id}")
            visit "/admin/merchants"
          end
        end
      end
    end
  end
end