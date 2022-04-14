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
      save_and_open_page
      expect(page).to have_content('Lord Eldens')
      expect(page).to have_content("Jeffs GoldBlooms")
      expect(page).to have_content("Souls Darkery")
      expect(page).to have_content("My Dog Skeeter")
      expect(page).to have_content("Corgi Town")

    end




  end

end
