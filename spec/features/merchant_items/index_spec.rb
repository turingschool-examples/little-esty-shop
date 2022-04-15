require 'rails_helper'

RSpec.describe 'merchant items index page' do
  describe 'list of item names for merchant' do
    it 'lists items for merchant' do
      merchant = Merchant.create!(name: 'Yeti')
      merchant_2 = Merchant.create!(name: 'Hydroflask')
      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
      item_3 = merchant.items.create!(name: 'Mug', unit_price: 15, description: 'Coffee')
      item_4 = merchant_2.items.create!(name: 'Kettle', unit_price: 20, description: 'Tea')

      visit "/merchants/#{merchant.id}/items"
      expect(page).to have_content("#{item_1.name}")
      expect(page).to have_content("#{item_2.name}")
      expect(page).to have_content("#{item_3.name}")
      expect(page).to_not have_content("#{item_4.name}")
    end

    it 'displays a disable or enable button' do
      merchant = Merchant.create!(name: 'Yeti')
      merchant_2 = Merchant.create!(name: 'Hydroflask')
      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
      item_3 = merchant.items.create!(name: 'Mug', unit_price: 15, description: 'Coffee')
      item_4 = merchant_2.items.create!(name: 'Kettle', unit_price: 20, description: 'Tea')
      visit "/merchants/#{merchant.id}/items"
      expect(page).to have_button("Disable #{item_1.name}")
      expect(page).to have_content("available")
      click_button "Disable #{item_1.name}"
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      expect(page).to have_content("unavailable")
      click_button "Enable #{item_1.name}"
      expect(page).to have_content("available")
    end

    it 'Then I see two sections, one for enabled items and one for disabled items' do
      merchant = Merchant.create!(name: 'Yeti')
      merchant_2 = Merchant.create!(name: 'Hydroflask')
      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
      item_3 = merchant.items.create!(name: 'Mug', unit_price: 15, description: 'Coffee')
      item_4 = merchant_2.items.create!(name: 'Kettle', unit_price: 20, description: 'Tea')
      visit "/merchants/#{merchant.id}/items"
      click_button "Disable #{item_3.name}"
      expect("#{item_1.name}").to appear_before("#{item_3.name}")
      expect("#{item_2.name}").to appear_before("#{item_3.name}")
      click_button "Disable #{item_1.name}"
      expect("#{item_2.name}").to appear_before("#{item_1.name}")
      click_button "Enable #{item_1.name}"
    end

    it 'Then I see the names of the top 5 most popular items ranked by total revenue generated' do
      merchant = Merchant.create!(name: 'Brylan')

      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      invoice_1 = customer_1.invoices.create!(status: 'completed')
      item_1 = merchant.items.create!(name: 'Pencil', unit_price: 1, description: 'Writes things.')
      item_2 = merchant.items.create!(name: 'Eraser', unit_price: 2, description: 'Does things.')
      item_3 = merchant.items.create!(name: 'Pen', unit_price: 3, description: 'Helps things.')
      item_4 = merchant.items.create!(name: 'Calculator', unit_price: 4, description: 'Considers things.')
      item_5 = merchant.items.create!(name: 'Stapler', unit_price: 5, description: 'Wishes things.')
      item_6 = merchant.items.create!(name: 'Computer', unit_price: 6, description: 'Hopes things.')
      item_7 = merchant.items.create!(name: 'Backpack', unit_price: 7, description: 'Forgets things.')
      item_1.invoice_items.create!(invoice_id: invoice_1.id, quantity: 1, unit_price: 4, status: 2)
      item_2.invoice_items.create!(invoice_id: invoice_1.id, quantity: 2, unit_price: 5, status: 2)
      item_3.invoice_items.create!(invoice_id: invoice_1.id, quantity: 3, unit_price: 6, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_1.id, quantity: 4, unit_price: 7, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_1.id, quantity: 5, unit_price: 8, status: 2)
      invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')

      customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
      invoice_2 = customer_2.invoices.create!(status: 'completed')
      item_3.invoice_items.create!(invoice_id: invoice_2.id, quantity: 1, unit_price: 4, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_2.id, quantity: 2, unit_price: 5, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_2.id, quantity: 3, unit_price: 6, status: 2)
      item_6.invoice_items.create!(invoice_id: invoice_2.id, quantity: 4, unit_price: 7, status: 2)
      item_7.invoice_items.create!(invoice_id: invoice_2.id, quantity: 5, unit_price: 8, status: 2)
      invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')

      visit "/merchants/#{merchant.id}/items"
      within "#top_merchant_items-#{merchant.id}" do
        expect("#{item_5.name}").to appear_before("#{item_7.name}")
        expect("#{item_7.name}").to appear_before("#{item_4.name}")
        expect("#{item_4.name}").to appear_before("#{item_6.name}")
        expect("#{item_6.name}").to appear_before("#{item_3.name}")
        expect(page).to_not have_content("#{item_2.name}")
        expect(page).to_not have_content("#{item_1.name}")
      end
    end
    it 'I see that each item name links to my merchant item show page for that item' do
      merchant = Merchant.create!(name: 'Brylan')

      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      invoice_1 = customer_1.invoices.create!(status: 'completed')
      item_1 = merchant.items.create!(name: 'Pencil', unit_price: 1, description: 'Writes things.')
      item_2 = merchant.items.create!(name: 'Eraser', unit_price: 2, description: 'Does things.')
      item_3 = merchant.items.create!(name: 'Pen', unit_price: 3, description: 'Helps things.')
      item_4 = merchant.items.create!(name: 'Calculator', unit_price: 4, description: 'Considers things.')
      item_5 = merchant.items.create!(name: 'Stapler', unit_price: 5, description: 'Wishes things.')
      item_6 = merchant.items.create!(name: 'Computer', unit_price: 6, description: 'Hopes things.')
      item_7 = merchant.items.create!(name: 'Backpack', unit_price: 7, description: 'Forgets things.')
      item_1.invoice_items.create!(invoice_id: invoice_1.id, quantity: 1, unit_price: 4, status: 2)
      item_2.invoice_items.create!(invoice_id: invoice_1.id, quantity: 2, unit_price: 5, status: 2)
      item_3.invoice_items.create!(invoice_id: invoice_1.id, quantity: 3, unit_price: 6, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_1.id, quantity: 4, unit_price: 7, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_1.id, quantity: 5, unit_price: 8, status: 2)
      invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')

      customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
      invoice_2 = customer_2.invoices.create!(status: 'completed')
      item_3.invoice_items.create!(invoice_id: invoice_2.id, quantity: 1, unit_price: 4, status: 2)
      item_4.invoice_items.create!(invoice_id: invoice_2.id, quantity: 2, unit_price: 5, status: 2)
      item_5.invoice_items.create!(invoice_id: invoice_2.id, quantity: 3, unit_price: 6, status: 2)
      item_6.invoice_items.create!(invoice_id: invoice_2.id, quantity: 4, unit_price: 7, status: 2)
      item_7.invoice_items.create!(invoice_id: invoice_2.id, quantity: 5, unit_price: 8, status: 2)
      invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')

      visit "/merchants/#{merchant.id}/items"
      expect(page).to have_content("Total Revenue: 58")
      save_and_open_page
      click_link "#{item_5.name}"
      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item_5.id}")
    end
  end
end
