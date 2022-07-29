require 'rails_helper'


RSpec.describe 'merchants invoice show page' do
  # Merchant Invoice Show Page: Invoice Item Information
  #
  # As a merchant
  # When I visit my merchant invoice show page
  # Then I see all of my items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status
  # And I do not see any information related to Items for other merchants
  it "has all of the item info from an invoice" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant2.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant3.id)

    customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice2 = Invoice.create!(status: "cancelled", customer_id: customer1.id)
    invoice3 = Invoice.create!(status: "in progress", customer_id: customer1.id)
    transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
    invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: item2.unit_price, status: "pending", item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 3, unit_price: item3.unit_price, status: "packaged", item_id: item3.id, invoice_id: invoice3.id)

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"
# save_and_open_page
    within "div#invoice" do
      expect(page).to have_content("Pikachu pics")
      expect(page).to have_content("shipped")
      expect(page).to have_content("Quantity: #{invoice_item1.quantity}")
      expect(page).to have_content("Price: #{invoice_item1.unit_price}")
      expect(page).to have_content("Status: #{invoice_item1.status}")
      expect(page).to_not have_content("Quantity: #{invoice_item2.quantity}")
      expect(page).to_not have_content("Price: #{invoice_item2.unit_price}")
      expect(page).to_not have_content("Status: #{invoice_item2.status}")
      expect(page).to_not have_content("Pokemon stuffy")
      expect(page).to_not have_content("Junk")
      expect(page).to_not have_content("pending")
      expect(page).to_not have_content("packaged")
    end

    visit "/merchants/#{merchant2.id}/invoices/#{invoice2.id}"

    within "div#invoice" do
      expect(page).to have_content("Pokemon stuffy")
      expect(page).to have_content("pending")
      expect(page).to have_content("Quantity: #{invoice_item2.quantity}")
      expect(page).to have_content("Price: #{invoice_item2.unit_price}")
      expect(page).to have_content("Status: #{invoice_item2.status}")
      expect(page).to_not have_content("Quantity: #{invoice_item3.quantity}")
      expect(page).to_not have_content("Price: #{invoice_item3.unit_price}")
      expect(page).to_not have_content("Status: #{invoice_item3.status}")
      expect(page).to_not have_content("Pikachu pics")
      expect(page).to_not have_content("Junk")
      expect(page).to_not have_content("shipped")
      expect(page).to_not have_content("packaged")
    end

    visit "/merchants/#{merchant3.id}/invoices/#{invoice3.id}"
    # save_and_open_page

    within "div#invoice" do
      expect(page).to have_content("Junk")
      expect(page).to have_content("packaged")
      expect(page).to have_content("Quantity: #{invoice_item3.quantity}")
      expect(page).to have_content("Price: #{invoice_item3.unit_price}")
      expect(page).to have_content("Status: #{invoice_item3.status}")
      expect(page).to_not have_content("Quantity: #{invoice_item1.quantity}")
      expect(page).to_not have_content("Price: #{invoice_item1.unit_price}")
      expect(page).to_not have_content("Status: #{invoice_item1.status}")
      expect(page).to_not have_content("Pikachu pics")
      expect(page).to_not have_content("Pokemon stuffy")
      expect(page).to_not have_content("pending")
      expect(page).to_not have_content("shipped")
    end



  end


end