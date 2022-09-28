require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'methods' do
    it 'item name' do
      merchant = Merchant.create!(name: "Stephen's Shady Store")
      item = merchant.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
      customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      invoice = customer.invoices.create!(status: 'in progress')
      invoice_item = invoice.invoice_items.create!(item_id: item.id,
                                         quantity: 1,
                                         unit_price: 6000,
                                         status: :pending)

      expect(invoice_item.item_name).to eq(item.name)
    end

    it 'can find the best applicable discount' do
      merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
      merchant2 = Merchant.create!(name: "Jack", status: 'Enabled')

      customer1 = Customer.create(first_name: 'Jack', last_name: 'Black')

      discount1 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 15, discount: 10)
      discount2 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 26, discount: 50)
      discount3 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 10, discount: 5)
      discount4 = BulkDiscount.create(merchant_id: merchant2.id, threshold: 18, discount: 80)

      invoice1 = Invoice.create(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create(status: "completed", customer_id: customer1.id)
      invoice3 = Invoice.create(status: "completed", customer_id: customer1.id)

      item1 = Item.create(name: 'Fountian Pen', description: 'The fanciest of pens', unit_price: 10, merchant_id: merchant1.id)
      item2 = Item.create(name: 'Mech Pencil', description: 'The fanciest of pencils', unit_price: 10, merchant_id: merchant2.id)

      invoice_item1 = InvoiceItem.create(invoice_id: invoice1.id, item_id: item1.id, quantity: 20, unit_price: 1000, status: 'shipped')
      invoice_item2 = InvoiceItem.create(invoice_id: invoice2.id, item_id: item2.id, quantity: 28, unit_price: 100, status: 'shipped')
      invoice_item3 = InvoiceItem.create(invoice_id: invoice3.id, item_id: item1.id, quantity: 30, unit_price: 1000, status: 'shipped')

      expect(invoice_item1.best_valid_discount).to eq(10)
    end

    it 'can find the discount applied to an item-invoice' do
      merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
      merchant2 = Merchant.create!(name: "Jack", status: 'Enabled')

      customer1 = Customer.create(first_name: 'Jack', last_name: 'Black')

      discount1 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 15, discount: 10)
      discount2 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 26, discount: 50)
      discount3 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 10, discount: 5)
      discount4 = BulkDiscount.create(merchant_id: merchant2.id, threshold: 18, discount: 80)

      invoice1 = Invoice.create(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create(status: "completed", customer_id: customer1.id)
      invoice3 = Invoice.create(status: "completed", customer_id: customer1.id)

      item1 = Item.create(name: 'Fountian Pen', description: 'The fanciest of pens', unit_price: 10, merchant_id: merchant1.id)
      item2 = Item.create(name: 'Mech Pencil', description: 'The fanciest of pencils', unit_price: 10, merchant_id: merchant2.id)

      invoice_item1 = InvoiceItem.create(invoice_id: invoice1.id, item_id: item1.id, quantity: 20, unit_price: 1000, status: 'shipped')
      invoice_item2 = InvoiceItem.create(invoice_id: invoice2.id, item_id: item2.id, quantity: 28, unit_price: 100, status: 'shipped')
      invoice_item3 = InvoiceItem.create(invoice_id: invoice3.id, item_id: item1.id, quantity: 30, unit_price: 1000, status: 'shipped')

      expect(invoice_item1.discount_applied).to eq(discount1.id)
    end

    it 'can return a 0 discount if none apply' do
      merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
      customer1 = Customer.create(first_name: 'Jack', last_name: 'Black')
      invoice1 = Invoice.create(status: "completed", customer_id: customer1.id)
      item1 = Item.create(name: 'Fountian Pen', description: 'The fanciest of pens', unit_price: 10, merchant_id: merchant1.id)
      invoice_item1 = InvoiceItem.create(invoice_id: invoice1.id, item_id: item1.id, quantity: 20, unit_price: 1000, status: 'shipped')

      expect(invoice_item1.best_valid_discount).to eq(0)
    end


    it 'returns discount 0 if no discount was applied' do
      merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
      customer1 = Customer.create(first_name: 'Jack', last_name: 'Black')
      invoice1 = Invoice.create(status: "completed", customer_id: customer1.id)
      item1 = Item.create(name: 'Fountian Pen', description: 'The fanciest of pens', unit_price: 10, merchant_id: merchant1.id)
      invoice_item1 = InvoiceItem.create(invoice_id: invoice1.id, item_id: item1.id, quantity: 20, unit_price: 1000, status: 'shipped')

      expect(invoice_item1.discount_applied).to eq(0)
    end

  end

end
