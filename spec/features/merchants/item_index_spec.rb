require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  describe "As a merchant" do

    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:item1) { create(:item, merchant_id: merchant1.id, unit_price: 100000) }
    let!(:item2) { create(:item, merchant_id: merchant1.id) }
    let!(:item3) { create(:item, merchant_id: merchant2.id) }
    let!(:item4) { create(:item, merchant_id: merchant2.id) }

    before do
      visit "/merchants/#{merchant1.id}/items"
    end
  
    
    describe "When I visit merchants/merchant_id/items" do
      # 6. Merchant Items Index Page
      it "I see a list of the names of all of my items, And I do not see items for any other merchant" do
        expect(page).to have_content("#{merchant1.name}")
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item2.name)
     
        expect(page).to_not have_content("#{merchant2.name}")
        expect(page).to_not have_content(item3.name)
        expect(page).to_not have_content(item4.name)
      end
    end

      # 7. Merchant Items Show Page
      context "When I click on the name of an item, Then I am taken to that merchant's item's show page" do
        it "I should see all of the item's attributes" do
          expect(page).to have_link("#{item1.name}")
          expect(current_path).to eq("/merchants/#{merchant1.id}/items")

          click_link("#{item1.name}")
          expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")

          expect(page).to have_content(item1.name)
          expect(page).to have_content(item1.description)
          expect(page).to have_content('$1,000.00')

          expect(page).to_not have_content(item3.name)
          expect(page).to_not have_content(item3.description)
          expect(page).to_not have_content(item3.unit_price)
        end
      end

      # 9. Merchant Item Disable/Enable
      
      it 'Next to each item name I see a button to disable or enable that item.' do

        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
      
      end

      it "When I click this button. Then I am redirected back to the items index, and I see that the items status has changed" do

        within "#item-#{item1.id}" do
          click_button('Enable')
        end

        expect(current_path).to eq("/merchants/#{merchant1.id}/items")

        within "#item-#{item1.id}" do
          expect(page).to have_content("Status: enabled")
          click_button("disable")
        end

        expect(current_path).to eq("/merchants/#{merchant1.id}/items")
        
        within "#item-#{item1.id}" do
          expect(page).to have_content("Status: disabled")
        end
      end

      # 11. Merchant Item Create - cont'd in 'spec/features/items/new_spec.rb
      it 'I see a link to create a new item.' do
        expect(page).to have_link("Create a New Item")
      end

      it 'When I click the link "Create New Item" button I am redirected to a new page create a new Item' do
        click_on("Create a New Item")

        expect(current_path).to eq("/merchants/#{merchant1.id}/items/new")
      end

      # 12. Merchant Items Index: 5 most popular items
      context 'I see the names of the top 5 most popular items ranked by total revenue generated' do
        it 'I see the total revenue generated next to each item and each item name is a link to their merchant item show page' do
        
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        customer_1 = create(:customer)
        item_1 = create(:item, merchant_id: merchant_1.id)
        item_2 = create(:item, merchant_id: merchant_1.id)
        item_3 = create(:item, merchant_id: merchant_1.id)
        item_4 = create(:item, merchant_id: merchant_1.id)
        item_5 = create(:item, merchant_id: merchant_1.id)
        item_6 = create(:item, merchant_id: merchant_1.id)
        item_7 = create(:item, merchant_id: merchant_2.id)
        item_8 = create(:item, merchant_id: merchant_2.id)
        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_2 = create(:invoice, customer_id: customer_1.id)
        invoice_3 = create(:invoice, customer_id: customer_1.id)
        invoice_4 = create(:invoice, customer_id: customer_1.id)
        invoice_5 = create(:invoice, customer_id: customer_1.id)
        invoice_6 = create(:invoice, customer_id: customer_1.id)
        invoice_7 = create(:invoice, customer_id: customer_1.id)
        invoice_8 = create(:invoice, customer_id: customer_1.id)
        invoice_item_1 = create(:invoice_item, item_id: item_1.id, quantity: 10, unit_price: 10, invoice_id: invoice_1.id )
        invoice_item_2 = create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 8, invoice_id: invoice_2.id )
        invoice_item_3 = create(:invoice_item, item_id: item_3.id, quantity: 10, unit_price: 6, invoice_id: invoice_3.id )
        invoice_item_4 = create(:invoice_item, item_id: item_4.id, quantity: 10, unit_price: 4, invoice_id: invoice_4.id )
        invoice_item_5 = create(:invoice_item, item_id: item_5.id, quantity: 10, unit_price: 2, invoice_id: invoice_5.id )
        invoice_item_6 = create(:invoice_item, item_id: item_6.id, quantity: 10, unit_price: 1, invoice_id: invoice_6.id )
        invoice_item_7 = create(:invoice_item, item_id: item_7.id, quantity: 10, unit_price: 100, invoice_id: invoice_7.id )
        invoice_item_8 = create(:invoice_item, item_id: item_8.id, quantity: 10, unit_price: 100, invoice_id: invoice_8.id )
        transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 'success')
        transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: 'success')
        transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: 'success')
        transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: 'success')
        transaction_5 = create(:transaction, invoice_id: invoice_5.id, result: 'failure')
        transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 'success')
        transaction_7 = create(:transaction, invoice_id: invoice_7.id, result: 'success')
        transaction_8 = create(:transaction, invoice_id: invoice_8.id, result: 'success')

        visit "/merchants/#{merchant_1.id}/items"

        expect(page).to have_content("Top 5 Most Popular Items (By Revenue)")
        save_and_open_page
        within "#top_5_items" do
          expect(page).to have_content("#{item_1.name}")
          expect(page).to have_content("#{item_2.name}")
          expect(page).to have_content("#{item_3.name}")
          expect(page).to have_content("#{item_4.name}")
          expect(page).to have_content("#{item_6.name}")
          expect(page).to_not have_content("#{item_5.name}")
          expect(page).to_not have_content("#{item_7.name}")
          expect(page).to_not have_content("#{item_8.name}")
          expect(item_1.name).to appear_before(item_2.name)
          expect(item_2.name).to appear_before(item_3.name)
          expect(item_4.name).to appear_before(item_6.name)

          click_on "#{item_1.name}"

          expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")
        end
        end
      end
    end
end
