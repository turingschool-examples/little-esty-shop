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
      # save_and_open_page
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
    
    it 'each merchant has a button to enable or disable them' do
      merch1 = Merchant.create!(name: 'Lord Eldens', created_at: Time.now, updated_at: Time.now, status: 0)
      merch2 = Merchant.create!(name: 'Jeffs GoldBlooms', created_at: Time.now, updated_at: Time.now, status: 1)
      merch3 = Merchant.create!(name: 'Souls Darkery', created_at: Time.now, updated_at: Time.now, status: 0)
      visit "/admin/merchants"
    
      within "#all_enabled_merchants" do
        expect(page).to have_content("Lord Eldens")
      end
      within "#all_disabled_merchants" do
        expect(page).to_not have_content("Lord Eldens")
      end
      
      within "#enabled_merchants-#{merch1.id}" do
        click_button("Disable Lord Eldens")
      end

      within "#all_enabled_merchants" do
        expect(page).to_not have_content("Lord Eldens")
      end
      within "#all_disabled_merchants" do
        expect(page).to have_content("Lord Eldens")
      end
    end

    describe 'Top 5 Merchants by revenue are shown' do
      
      it 'I see the name of each merchant, and a link to their show page' do

        merchant_1 = Merchant.create!(name: 'Lord Eldens', created_at: Time.now, updated_at: Time.now)
        item_1 = create(:item, name: 'Elden Ring', unit_price: 9999, merchant_id: merchant_1.id)
        customer_1 = create(:customer)
        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: Time.now, updated_at: Time.now)
        transaction_list_1 = Transaction.create!(credit_card_number: '103294023', credit_card_expiration_date: "342", result: 0, created_at: Time.now, updated_at: Time.now, invoice_id: invoice_1.id)
        transaction_list_12 = Transaction.create!(credit_card_number: '103294023', credit_card_expiration_date: "342", result: 1, created_at: Time.now, updated_at: Time.now, invoice_id: invoice_1.id)

        invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: 2, quantity: 1, unit_price: 9999)

        merchant_2 = Merchant.create!(name: 'Jeffs GoldBlooms', created_at: Time.now, updated_at: Time.now)
        item_2 = create(:item, name: 'Bolden Gloom', unit_price: 8888, merchant_id: merchant_2.id)
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: Time.now, updated_at: Time.now)
        transaction_list_2 = Transaction.create!(credit_card_number: '103294023', credit_card_expiration_date: "342", result: 0, created_at: Time.now, updated_at: Time.now, invoice_id: invoice_2.id)

        invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: 2, quantity: 1, unit_price: 8888)

        merchant_3 = Merchant.create!(name: 'Souls Darkery', created_at: Time.now, updated_at: Time.now)
        item_3 = create(:item, name: 'Orthopedic Insole', unit_price: 7777, merchant_id: merchant_3.id)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: Time.now, updated_at: Time.now)
        transaction_list_3 = Transaction.create!(credit_card_number: '103294023', credit_card_expiration_date: "342", result: 0, created_at: Time.now, updated_at: Time.now, invoice_id: invoice_3.id)

        invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, status: 2, quantity: 1, unit_price: 7777)

        merchant_4 = Merchant.create!(name: 'My Dog Skeeter', created_at: Time.now, updated_at: Time.now)
        item_4 = create(:item, name: 'Literally a Dog', unit_price: 12345, merchant_id: merchant_4.id)
        invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: Time.now, updated_at: Time.now)
        transaction_list_4 = Transaction.create!(credit_card_number: '103294023', credit_card_expiration_date: "342", result: 0, created_at: Time.now, updated_at: Time.now, invoice_id: invoice_4.id)

        invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_4.id, status: 2, quantity: 1, unit_price: 12345)

        merchant_5 = Merchant.create!(name: 'Corgi Town', created_at: Time.now, updated_at: Time.now)
        item_5 = create(:item, name: 'Whole Township', unit_price: 2355, merchant_id: merchant_5.id)
        invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: Time.now, updated_at: Time.now)
        transaction_list_5 = Transaction.create!(credit_card_number: '103294023', credit_card_expiration_date: "342", result: 0, created_at: Time.now, updated_at: Time.now, invoice_id: invoice_5.id)
        invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_5.id, status: 2, quantity: 1, unit_price: 2355)

        merchant_6 = Merchant.create!(name: 'Cheese Company', created_at: Time.now, updated_at: Time.now)
        item_6 = create(:item, name: 'Some Cheese', unit_price: 447896, merchant_id: merchant_6.id)
        item_7 = create(:item, name: 'Also Cheese', unit_price: 246735, merchant_id: merchant_6.id)
        invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: Time.now, updated_at: Time.now)
        transaction_list_6 = Transaction.create!(credit_card_number: '103294023', credit_card_expiration_date: "342", result: 0, created_at: Time.now, updated_at: Time.now, invoice_id: invoice_6.id)

        invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 447896)
        invoice_item_7 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_6.id, status: 1, quantity: 2, unit_price: 3242)

        visit "/admin/merchants"
        # save_and_open_page
        within "#top_5_big" do
          expect("Cheese Company").to appear_before("My Dog Skeeter")
          expect("My Dog Skeeter").to appear_before("Lord Eldens")
          expect("Lord Eldens").to appear_before("Jeffs GoldBlooms")
          expect("Jeffs GoldBlooms").to appear_before("Souls Darkery")
        end

        within "#top_five_merchant-#{merchant_6.id}" do
          expect(page).to have_link("Cheese Company")
        end

        within "#top_five_merchant-#{merchant_4.id}" do
          expect(page).to have_link("My Dog Skeeter")
        end

        within "#top_five_merchant-#{merchant_1.id}" do
          expect(page).to have_link("Lord Eldens")
        end

        within "#top_five_merchant-#{merchant_2.id}" do
          expect(page).to have_link("Jeffs GoldBlooms")
        end

        within "#top_five_merchant-#{merchant_3.id}" do
          click_link "Souls Darkery"
        end
        expect(current_path).to eq("/admin/merchants/#{merchant_3.id}")

      end

    end




  end

end
