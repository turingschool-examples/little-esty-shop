require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  describe "A list of all merchants' names" do
    it 'shows the names of each merchant' do
      merch1 = Merchant.create!(name: Faker::Name.name)
      merch2 = Merchant.create!(name: Faker::Name.name)
      merch3 = Merchant.create!(name: Faker::Name.name)
      merch4 = Merchant.create!(name: Faker::Name.name)
      merch5 = Merchant.create!(name: Faker::Name.name)

      all_merchants = [merch1, merch2, merch3, merch4, merch5]
      visit admin_merchants_path

      within '#merchants' do
        all_merchants.each do |merchant|
          within "#merchant_#{merchant.id}" do
            expect(page).to have_content("#{merchant.name}")
          end
        end
      end
    end

    it 'has each merchant name is a link to the admin merchant show page' do
      merch1 = Merchant.create!(name: Faker::Name.name)
      merch2 = Merchant.create!(name: Faker::Name.name)
      merch3 = Merchant.create!(name: Faker::Name.name)
      merch4 = Merchant.create!(name: Faker::Name.name)
      merch5 = Merchant.create!(name: Faker::Name.name)

      all_merchants = [merch1, merch2, merch3, merch4, merch5]
      visit admin_merchants_path

      within '#merchants' do
        all_merchants.each do |merchant|
          within "#merchant_#{merchant.id}" do
            click_link("#{merchant.name}")
            expect(page).to have_current_path("/admin/merchants/#{merchant.id}")
            visit admin_merchants_path
          end
        end
      end
    end
    describe 'under section for enabled merchants' do
      it 'only enabled merchants are shown' do
        merch1 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch2 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch3 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch4 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch5 = Merchant.create!(name: Faker::Name.name, status: 0)

        enabled_merchants = [merch1, merch3, merch5]

        expect(Merchant.enabled_merchants).to eq(enabled_merchants)

        visit admin_merchants_path

        within '#enabled_merchants' do
          enabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              expect(page).to have_content(merchant.name)
              expect(page).to_not have_content(merch2.name)
              expect(page).to_not have_content(merch4.name)
            end
          end
        end
      end

      it 'only disabled buttons are shown' do
        merch1 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch2 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch3 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch4 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch5 = Merchant.create!(name: Faker::Name.name, status: 0)

        enabled_merchants = [merch1, merch3, merch5]

        expect(Merchant.enabled_merchants).to eq(enabled_merchants)

        visit admin_merchants_path

        within '#enabled_merchants' do
          enabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              expect(page).to have_button("Disable")
              expect(page).to_not have_button("Enable")
            end
          end
        end
      end

      it 'clicking disable button, returns to index with merchant now in disabled merchants list' do
        merch1 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch2 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch3 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch4 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch5 = Merchant.create!(name: Faker::Name.name, status: 0)

        enabled_merchants = [merch1, merch3, merch5]

        visit admin_merchants_path

        within '#enabled_merchants' do
          enabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              click_button("Disable")
              expect(current_path).to eq(admin_merchants_path)
            end
          end
          enabled_merchants.each do |merchant|
            expect(page).to_not have_css("#merchant_#{merchant.id}")
          end
        end
        within '#disabled_merchants' do
          enabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              expect(page).to have_content(merchant.name)
            end
          end
        end
      end
    end
    describe 'under section for disabled merchants' do
      it 'only disabled merchants are shown' do
        merch1 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch2 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch3 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch4 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch5 = Merchant.create!(name: Faker::Name.name, status: 0)

        disabled_merchants = [merch2, merch4]

        expect(Merchant.disabled_merchants).to eq(disabled_merchants)

        visit admin_merchants_path

        within '#disabled_merchants' do
          disabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              expect(page).to have_content(merchant.name)
              expect(page).to_not have_content(merch1.name)
              expect(page).to_not have_content(merch3.name)
            end
          end
        end
      end

      it 'only enabled buttons are shown' do
        merch1 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch2 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch3 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch4 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch5 = Merchant.create!(name: Faker::Name.name, status: 0)

        disabled_merchants = [merch2, merch4]


        expect(Merchant.disabled_merchants).to eq(disabled_merchants)

        visit admin_merchants_path

        within '#disabled_merchants' do
          disabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              expect(page).to have_button("Enable")
              expect(page).to_not have_button("Disable")
            end
          end
        end
      end

      it 'clicking disable button, returns to index with merchant now in disabled merchants list' do
        merch1 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch2 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch3 = Merchant.create!(name: Faker::Name.name, status: 0)
        merch4 = Merchant.create!(name: Faker::Name.name, status: 1)
        merch5 = Merchant.create!(name: Faker::Name.name, status: 0)

        disabled_merchants = [merch2, merch4]


        visit admin_merchants_path

        within '#disabled_merchants' do
          disabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              click_button("Enable")
              expect(current_path).to eq(admin_merchants_path)
            end
          end
          disabled_merchants.each do |merchant|
            expect(page).to_not have_css("#merchant_#{merchant.id}")
          end
        end
        within '#enabled_merchants' do
          disabled_merchants.each do |merchant|
            within "#merchant_#{merchant.id}" do
              expect(page).to have_content(merchant.name)
            end
          end
        end
      end
    end
  end
end