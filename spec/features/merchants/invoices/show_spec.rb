require 'rails_helper'

RSpec.describe 'merchant_invoices show page' do
  it 'shows invoice details: id, status,customer name, created_at in Monday, July 18, 2019 format' do
    merch1 = Merchant.create!(name: 'Needful Things Imports')

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
    customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

    item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 20)
    item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 6)

    invoice1 = customer1.invoices.create!(status: 1)
    invoice2 = customer2.invoices.create!(status: 1)

    invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 6, status: 1)
    invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)

    visit merchant_invoice_path(merch1.id, invoice1.id)

    within('#invoice-details') do
      expect(page).to have_content("ID: #{invoice1.id}")
      expect(page).to have_content("Status: #{invoice1.status}")
      expect(page).to have_content("Created: #{invoice1.formatted_date}")
      expect(page).to have_content("Customer: #{invoice1.customer_name}")
      expect(page).to_not have_content("ID: #{invoice2.id}")
    end
  end

  it 'displays items within invoice with their name, qty, price, and status' do
    merch1 = Merchant.create!(name: 'Needful Things Imports')

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
    customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

    item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 2000)
    item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 600)

    invoice1 = customer1.invoices.create!(status: 1)
    invoice2 = customer2.invoices.create!(status: 1)

    invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 600, status: 1)
    invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 2000, status: 1)

    visit merchant_invoice_path(merch1.id, invoice1.id)

    within "#invoice-item-information" do
      expect(page).to have_content("Item Name: #{invoice_item1.item.name}")
      expect(page).to have_content("Quantity Ordered: #{invoice_item1.quantity}")
      expect(page).to have_content("Price: $6.00")
      expect(page).to have_content("Status: #{invoice_item1.status}")
      expect(page).to_not have_content("Item Name: #{invoice_item2.item.name}")
    end
  end

  it 'displays total revenue from all items on invoice' do
      merch1 = Merchant.create!(name: 'Needful Things Imports')

      customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
      customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

      item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 2000)
      item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 600)
      item3 = merch1.items.create!(name: 'Bag of Holding', description: 'This bag has an interior space considerably larger than its outside dimensions, roughly 2 feet in diameter at the mouth and 4 feet deep.', unit_price: 10)
      item4 = merch1.items.create!(name: 'Ring of Resonance', description: 'A ring that resonates with the Ring of Flame Lord', unit_price: 1500)
      item5 = merch1.items.create!(name: 'Phreeoni Card', description: 'HIT + 100', unit_price: 2000)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 1, unit_price: 2000, status: 1)
      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 2, unit_price: 600, status: 1)
      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 1000, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item4, quantity: 2, unit_price: 1500, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item5, quantity: 1, unit_price: 2000, status: 1)

      visit merchant_invoice_path(merch1.id, invoice1.id)

      within "#invoice-item-total-revenue" do
        expect(page).to have_content("Total Revenue: $42.00")
        expect(page).to_not have_content("Total Revenue: $50.00")
      end
  end

  it 'displays form to update item status' do
    merch1 = Merchant.create!(name: 'Needful Things Imports')

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
    customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

    item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 20)
    item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 6)

    invoice1 = customer1.invoices.create!(status: 1)
    invoice2 = customer2.invoices.create!(status: 1)

    invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 6, status: 1)
    invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)

    visit merchant_invoice_path(merch1.id, invoice1.id)

    within "#invoice-item-information" do
      expect(page).to have_content("Item Name: #{invoice_item1.item.name}")
      expect(page).to_not have_content("Item Name: #{invoice_item2.item.name}")
      expect(page).to have_content("pending")
      select("shipped", from: "Status")
      click_button "Update Item Status"
      expect(page).to have_content("shipped")
    end
  end
  it 'displays the total discounted revenue for this invoice from bulk discounts' do
    merch1 = Merchant.create!(name: 'Needful Things Imports')
    discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 10, quantity_threshold: 10)
    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
    customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

    item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 2000)
    item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 600)
    item3 = merch1.items.create!(name: 'Bag of Holding', description: 'This bag has an interior space considerably larger than its outside dimensions, roughly 2 feet in diameter at the mouth and 4 feet deep.', unit_price: 1000)
    item4 = merch1.items.create!(name: 'Ring of Resonance', description: 'A ring that resonates with the Ring of Flame Lord', unit_price: 1500)
    item5 = merch1.items.create!(name: 'Phreeoni Card', description: 'HIT + 100', unit_price: 2000)

    invoice1 = customer1.invoices.create!(status: 1)
    invoice2 = customer2.invoices.create!(status: 1)

    invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 10, unit_price: 2000, status: 1)
    invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 9, unit_price: 600, status: 1)
    invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 20, unit_price: 1000, status: 1)
    invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item4, quantity: 2, unit_price: 1500, status: 1)
    invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item5, quantity: 1, unit_price: 2000, status: 1)

    visit merchant_invoice_path(merch1.id, invoice1.id)

    within "#invoice-item-discounted-revenue" do
        expect(page).to have_content("Total Discounted Revenue: $414.00")
        expect(page).to_not have_content("Total Discounted Revenue: $408.60")
    end
  end
end