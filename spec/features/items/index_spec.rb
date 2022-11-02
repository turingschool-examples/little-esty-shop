require 'rails_helper'

RSpec.describe 'items index page', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:luffy) {Customer.create!(first_name: "Monkey", last_name: "Luffy")}
  let!(:nami) {Customer.create!(first_name: "Nami", last_name: "Waves")}
  let!(:sanji) {Customer.create!(first_name: "Sanji", last_name: "Foot")}
  let!(:zoro) {Customer.create!(first_name: "Zoro", last_name: "Sword")}

  let!(:invoice_1) {luffy.invoices.create!(status: 2)}
  let!(:invoice_2) {luffy.invoices.create!(status: 2)}
  let!(:invoice_3) {luffy.invoices.create!(status: 2)}
  let!(:invoice_4) {nami.invoices.create!(status: 2)}
  let!(:invoice_5) {nami.invoices.create!(status: 2)}
  let!(:invoice_6) {sanji.invoices.create!(status: 2)}
  let!(:invoice_7) {sanji.invoices.create!(status: 2)}
  let!(:invoice_8) {sanji.invoices.create!(status: 2)}
  let!(:invoice_9) {sanji.invoices.create!(status: 2)}
  let!(:invoice_10) {zoro.invoices.create!(status: 2)}
  let!(:invoice_11) {zoro.invoices.create!(status: 2)}
  let!(:invoice_12) {zoro.invoices.create!(status: 2)}

  let!(:invoice_item_1)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 2999, status: "shipped")}
  let!(:invoice_item_2)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 2999, status: "shipped")}
  let!(:invoice_item_3)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_5.id, quantity: 2, unit_price: 2999, status: "shipped")}
  let!(:invoice_item_4)  {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_7.id, quantity: 5, unit_price: 100, status: "shipped")}
  let!(:invoice_item_5)  {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_9.id, quantity: 1, unit_price: 100, status: "shipped")}
  let!(:invoice_item_6)  {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_11.id, quantity: 1, unit_price: 1000, status: "shipped")}
  let!(:invoice_item_7)  {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_11.id, quantity: 1, unit_price: 1000, status: "shipped")}
  let!(:invoice_item_8)  {InvoiceItem.create!(item_id: oil.id, invoice_id: invoice_11.id, quantity: 10, unit_price: 2599, status: "shipped")}
  let!(:invoice_item_9)  {InvoiceItem.create!(item_id: pants.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 2100, status: "shipped")}

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 599)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  let!(:oil) {tyty.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)}
  let!(:water) {tyty.items.create!(name: "The Best Water Ever", description: "from the great Cherry Creek Reservoir", unit_price: 100)}
  let!(:shirt) {tyty.items.create!(name: "Funny Shirt", description: "nice", unit_price: 1099)}
  let!(:pants) {tyty.items.create!(name: "Pants", description: "nice", unit_price: 2010)}

  let!(:transaction_1)  {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_1.id)}
  let!(:transaction_2) {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_2.id)}
  let!(:transaction_3) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_3.id)}
  let!(:transaction_4) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_4.id)}
  let!(:transaction_5) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_5.id)}
  let!(:transaction_6) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_6.id)}
  let!(:transaction_7) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_7.id)}
  let!(:transaction_8) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_8.id)}
  let!(:transaction_9) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_9.id)}
  let!(:transaction_10) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_10.id)}
  let!(:transaction_11) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_11.id)}
  let!(:transaction_12) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_12.id)}

  describe 'items#index' do
    it 'shows a list of names of all merchants items' do
      visit merchant_items_path(nomi)

      expect(page).to have_content(nomi.name)

      within ("#my-items") do
        expect(page).to have_content(stickers.name)
        expect(page).to have_content(lamp.name)
        expect(page).to have_content(orion.name)

        expect(page).to_not have_content(oil.name)
      end
    end

    it 'takes you to item show page when you click on the link on the item name' do
      visit merchant_items_path(nomi)

      within ("#left") do
        click_link lamp.name
      end

      expect(current_path).to eq(merchant_item_path(nomi, lamp))
    end

    it 'changes the item to be enabled after clicking Enable' do
      visit merchant_items_path(nomi)
    
      within("#item-#{lamp.id}") do
        click_button 'Enable'
      end

      expect(current_path).to eq(merchant_items_path(nomi))
 
      within("#enabled") do
        expect(page).to have_content(lamp.name)
      end

      within("#disabled") do
        expect(page).to_not have_content(lamp.name)
      end
    end

    it 'changes the item to be disabled after clicking Disable' do
      lamp.update_attribute :status, 0
      
      visit merchant_items_path(nomi)
    
      within("#item-#{lamp.id}") do
        click_button 'Disable'
      end

      expect(current_path).to eq(merchant_items_path(nomi))
 
      within("#enabled") do
        expect(page).to_not have_content(lamp.name)
      end

      within("#disabled") do
        expect(page).to have_content(lamp.name)
      end
    end

    it 'has a link to create a new item' do
      visit merchant_items_path(nomi)

      click_link 'New Item'

      expect(current_path).to eq(new_merchant_item_path(nomi))
    end

    it 'shows the top 5 items and each item has a link to its show page' do
      visit merchant_items_path(nomi)
      
      within("#right") do
        expect(lamp.name).to appear_before(orion.name)
        expect(orion.name).to appear_before(stickers.name)
      
        expect(page).to have_content("#{lamp.name} - $149 in sales")
        expect(page).to have_content("#{orion.name} - $20 in sales")
        expect(page).to have_content("#{stickers.name} - $6 in sales")
      end

      expect(page).to have_content(lamp.name, count: 2)
      expect(page).to have_content(orion.name, count: 2)
      expect(page).to have_content(stickers.name, count: 2)
    end
  end
end