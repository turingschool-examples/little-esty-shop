require 'rails_helper'


RSpec.describe "Admin Merchants Index Page" do

  describe 'As a Visitor' do

    it 'I see the name of each merchant in the system' do

      date1 = "2020-02-08 09:54:09 UTC".to_datetime
      date2 = "2017-03-16 04:04:09 UTC".to_datetime
      date3 = "2012-08-07 01:44:09 UTC".to_datetime
      date4 = "2015-05-03 08:23:09 UTC".to_datetime
      date5 = "2021-01-11 12:55:09 UTC".to_datetime
      merch1 = Merchant.create!(name: 'Lord Eldens', created_at: date1, updated_at: date1, status: 0)
      merch2 = Merchant.create!(name: 'Jeffs GoldBlooms', created_at: date2, updated_at: date2, status: 1)
      merch3 = Merchant.create!(name: 'Souls Darkery', created_at: date3, updated_at: date3, status: 0)
      merch4 = Merchant.create!(name: 'My Dog Skeeter', created_at: date4, updated_at: date4, status: 1)
      merch5 = Merchant.create!(name: 'Corgi Town', created_at: date5, updated_at: date5, status: 0)

      visit "/admin/merchants"
      # save_and_open_page

      # within "#merchant-#{merch1.id}" do
      #   expect(page).to have_content('Lord Eldens')
      # end
      expect(page).to have_content("Jeffs GoldBlooms")
      expect(page).to have_content("Souls Darkery")
      expect(page).to have_content("My Dog Skeeter")
      expect(page).to have_content("Corgi Town")

    end

    it 'I see a section for enabled/disabled merchants, each merchant in appropriate section' do
      merch1 = Merchant.create!(name: 'Lord Eldens', created_at: Time.now, updated_at: Time.now, status: 0)
      merch2 = Merchant.create!(name: 'Jeffs GoldBlooms', created_at: Time.now, updated_at: Time.now, status: 1)
      merch3 = Merchant.create!(name: 'Souls Darkery', created_at: Time.now, updated_at: Time.now, status: 0)
      merch4 = Merchant.create!(name: 'My Dog Skeeter', created_at: Time.now, updated_at: Time.now, status: 1)
      merch5 = Merchant.create!(name: 'Corgi Town', created_at: Time.now, updated_at: Time.now, status: 0)
      merch6 = Merchant.create!(name: 'Cheese Company', created_at: Time.now, updated_at: Time.now, status: 1)
      merch7 = Merchant.create!(name: 'Brisket is Tasty', created_at: Time.now, updated_at: Time.now, status: 0)

      visit "/admin/merchants"
      # Enabled Merchants Section
      within "#enabled_merchants-#{merch1.id}" do
        expect(page).to have_content("Lord Eldens")
      end
      within "#enabled_merchants-#{merch3.id}" do
        expect(page).to have_content("Souls Darkery")
      end
      within "#enabled_merchants-#{merch5.id}" do
        expect(page).to have_content("Corgi Town")
      end
      within "#enabled_merchants-#{merch7.id}" do
        expect(page).to have_content("Brisket is Tasty")
      end

      # Disabled Merchants Section
      within "#disabled_merchants-#{merch2.id}" do
        expect(page).to have_content("Jeffs GoldBlooms")
      end
      within "#disabled_merchants-#{merch4.id}" do
        expect(page).to have_content("My Dog Skeeter")
      end
      within "#disabled_merchants-#{merch6.id}" do
        expect(page).to have_content("Cheese Company")
      end
    end

    it 'each merchants name is a link to their admin/merchants show page' do
      merch1 = Merchant.create!(name: 'Lord Eldens', created_at: Time.now, updated_at: Time.now, status: 0)
      merch2 = Merchant.create!(name: 'Jeffs GoldBlooms', created_at: Time.now, updated_at: Time.now, status: 1)
      merch3 = Merchant.create!(name: 'Souls Darkery', created_at: Time.now, updated_at: Time.now, status: 0)
      visit "/admin/merchants"
      save_and_open_page
      within "#enabled_merchants-#{merch1.id}" do
        expect(page).to have_link("#{merch1.name}")
      end
      within "#disabled_merchants-#{merch2.id}" do
        expect(page).to have_link("#{merch2.name}")
      end
      within "#enabled_merchants-#{merch3.id}" do
        expect(page).to have_link("#{merch3.name}")
      end
      click_on "#{merch3.name}"
      expect(current_path).to eq("/admin/merchants/#{merch3.id}")
    end




  end

end
