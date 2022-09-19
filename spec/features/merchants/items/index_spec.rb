require "rails_helper"


RSpec.describe("the merchant items index") do
  it("I see the name of my merchant") do
    merchant1 = Merchant.create!(    name: "Bob")
    visit("/merchants/#{merchant1.id}/items")
    expect(page).to(have_content("#{merchant1.name} Items"))
  end

  it("I see all the items associated with that merchant") do
    merchant1 = Merchant.create!(    name: "Bob")
    merchant2 = Merchant.create!(    name: "Jolene")
    item1 = merchant1.items.create!(    name: "item1",     description: "this is item1 description",     unit_price: 1)
    item2 = merchant1.items.create!(    name: "item2",     description: "this is item2 description",     unit_price: 2)
    item3 = merchant1.items.create!(    name: "item3",     description: "this is item3 description",     unit_price: 3)
    item4 = merchant2.items.create!(    name: "item3",     description: "this is item4 description",     unit_price: 3)
    visit("/merchants/#{merchant1.id}/items")
    expect(page).to(have_content("item1"))
    expect(page).to(have_content("item2"))
    expect(page).to(have_content("item3"))
    expect(page).to_not(have_content("item4"))
  end

  it("directs to the merchant index page") do
    merchant1 = Merchant.create!(    name: "Bob")
    merchant2 = Merchant.create!(    name: "Jolene")
    item1 = merchant1.items.create!(    name: "item1",     description: "this is item1 description",     unit_price: 1)
    item2 = merchant1.items.create!(    name: "item2",     description: "this is item2 description",     unit_price: 2)
    item3 = merchant1.items.create!(    name: "item3",     description: "this is item3 description",     unit_price: 3)
    item4 = merchant2.items.create!(    name: "item3",     description: "this is item4 description",     unit_price: 3)
    visit("/merchants/#{merchant1.id}/items")
    click_on("#{item1.name}")
    expect(current_path).to(eq("/merchants/#{merchant1.id}/items/#{item1.id}"))
  end

  describe 'I see the names of the top 5 most popular items ranked by total revenue generated' do
    let!(:merchant_1) {create(:random_merchant)}
    let!(:merchant_2) {create(:random_merchant)}

    let!(:item_1) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_2) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_3) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_4) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_5) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_6) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_7) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_8) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_9) {create(:random_item, merchant_id: merchant_1.id)}
    let!(:item_10) {create(:random_item, merchant_id: merchant_2.id)}

    let!(:customer_1) {create(:random_customer)}
    let!(:customer_2) {create(:random_customer)}
    let!(:customer_3) {create(:random_customer)}
    let!(:customer_4) {create(:random_customer)}
  
    let!(:invoice_1) {Invoice.create!(customer_id: customer_1.id, status: 'completed')}
    let!(:invoice_2) {Invoice.create!(customer_id: customer_2.id, status: 'completed')}
    let!(:invoice_3) {Invoice.create!(customer_id: customer_3.id, status: 'cancelled')}
    let!(:invoice_4) {Invoice.create!(customer_id: customer_4.id, status: 'completed')}
    let!(:invoice_5) {Invoice.create!(customer_id: customer_4.id, status: 'completed')}

    let!(:transaction_1) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
    let!(:transaction_2) {Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
    let!(:transaction_3) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
    let!(:transaction_4) {Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'failed')}
    let!(:transaction_5) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
    let!(:transaction_6) {Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
    let!(:transaction_7) {Transaction.create!(invoice_id: invoice_4.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}
    let!(:transaction_8) {Transaction.create!(invoice_id: invoice_5.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success')}

    let!(:invoice_item_1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped') }
    let!(:invoice_item_2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 31, unit_price: 13635, status: 'packaged') }
    let!(:invoice_item_3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 13, unit_price: 1335, status: 'shipped') }
    let!(:invoice_item_4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 30, unit_price: 1335, status: 'pending') }
    let!(:invoice_item_5) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending') }
    let!(:invoice_item_6) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 30, unit_price: 1335, status: 'pending') }
    let!(:invoice_item_7) { InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_3.id, quantity: 30, unit_price: 1335, status: 'pending') }
    let!(:invoice_item_8) { InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending') }
    let!(:invoice_item_9) { InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 30, unit_price: 1335, status: 'pending') }
    let!(:invoice_item_10) { InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_5.id, quantity: 30, unit_price: 1335, status: 'pending') }

    describe 'Each item name links to the merchant item show page for that item' do
      describe 'and I see the total revenue generated next to each item name' do
        it 'displays the top 5 most popular items ranked by total revenue' do
          visit merchant_items_path(merchant_1)

          expect(page).to have_content("Top 5 most popular items")
        end

        it 'links each item to the merchant item show page for that item and displays total revenue generated'

      end
    end
  end
end
# Merchant Items Index: 5 most popular items

# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name

# Notes on Revenue Calculation:

# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)