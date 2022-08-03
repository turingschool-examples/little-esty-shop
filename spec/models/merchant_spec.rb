require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'instance method' do
    it "returns the array of invoice ids for a merchant" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes")
      customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
      item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
			invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice2.id)

      expect(merchant1.merchant_invoice_by_item_id).to eq([invoice1.id, invoice2.id])
    end

    it "can calculate the best day of a merchant" do
      merchant1 = Merchant.create!(name: 'Poke pics')

      item1 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 1500, merchant_id: merchant1.id)

      customer1 = Customer.create!(first_name: 'Beannah', last_name: 'Durke')
      customer2 = Customer.create!(first_name: 'Tarker', last_name: 'Phomson')
      customer3 = Customer.create!(first_name: 'Hai', last_name: 'Sall')
      customer4 = Customer.create!(first_name: 'Pach', last_name: 'Zrince')
      customer5 = Customer.create!(first_name: 'Fasey', last_name: 'Cazio')

      invoice1 = Invoice.create!(status: 'completed', customer_id: customer1.id, updated_at: Time.parse('2012-03-25 09:54:09 UTC'))
      invoice2 = Invoice.create!(status: 'completed', customer_id: customer2.id, updated_at: Time.parse('2012-04-25 09:54:09 UTC'))
      invoice3 = Invoice.create!(status: 'completed', customer_id: customer3.id, updated_at: Time.parse('2012-05-25 09:54:09 UTC'))
      invoice4 = Invoice.create!(status: 'completed', customer_id: customer4.id, updated_at: Time.parse('2012-06-25 09:54:09 UTC'))
      invoice5 = Invoice.create!(status: 'completed', customer_id: customer5.id, updated_at: Time.parse('2012-07-25 09:54:09 UTC'))

      invoice_item1 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 100, unit_price: 2000, status: 'shipped', item_id: item1.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity: 100, unit_price: 6000, status: 'shipped', item_id: item1.id, invoice_id: invoice3.id)
      invoice_item4 = InvoiceItem.create!(quantity: 100, unit_price: 4000, status: 'shipped', item_id: item1.id, invoice_id: invoice4.id)
      invoice_item5 = InvoiceItem.create!(quantity: 100, unit_price: 5000, status: 'shipped', item_id: item1.id, invoice_id: invoice5.id)

      transaction1 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
      transaction2 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
      transaction3 = Transaction.create!(result: 'success', invoice_id: invoice3.id)
      transaction4 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
      transaction5 = Transaction.create!(result: 'success', invoice_id: invoice5.id)

      expect(merchant1.merchant_best_day).to eq(invoice3.updated_at)
    end
  end

  describe 'class methods' do
    it "can calculate the top 5 merchants by revenue" do
      merchant1 = Merchant.create!(name: 'Poke pics')
      merchant2 = Merchant.create!(name: 'Daily Dungeons')
      merchant3 = Merchant.create!(name: 'One item')
      merchant4 = Merchant.create!(name: 'More than one item')
      merchant5 = Merchant.create!(name: '2 doller store')
      merchant6 = Merchant.create!(name: '5 above')
      merchant7 = Merchant.create!(name: 'Malwart')

      item1 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 1500, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 2500, merchant_id: merchant2.id)
      item3 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 3500, merchant_id: merchant3.id)
      item4 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 4500, merchant_id: merchant4.id)
      item5 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 5500, merchant_id: merchant5.id)
      item6 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 6500, merchant_id: merchant6.id)
      item7 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 7500, merchant_id: merchant7.id)

      customer1 = Customer.create!(first_name: 'Beannah', last_name: 'Durke')

      invoice1 = Invoice.create!(status: 'completed', customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 'completed', customer_id: customer1.id)
      invoice3 = Invoice.create!(status: 'completed', customer_id: customer1.id)
      invoice4 = Invoice.create!(status: 'completed', customer_id: customer1.id)
      invoice5 = Invoice.create!(status: 'completed', customer_id: customer1.id)
      invoice6 = Invoice.create!(status: 'completed', customer_id: customer1.id)
      invoice7 = Invoice.create!(status: 'completed', customer_id: customer1.id)

      invoice_item1 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 100, unit_price: 2000, status: 'shipped', item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity: 100, unit_price: 3000, status: 'shipped', item_id: item3.id, invoice_id: invoice3.id)
      invoice_item4 = InvoiceItem.create!(quantity: 100, unit_price: 4000, status: 'shipped', item_id: item4.id, invoice_id: invoice4.id)
      invoice_item5 = InvoiceItem.create!(quantity: 100, unit_price: 5000, status: 'shipped', item_id: item5.id, invoice_id: invoice5.id)
      invoice_item6 = InvoiceItem.create!(quantity: 100, unit_price: 6000, status: 'shipped', item_id: item6.id, invoice_id: invoice6.id)
      invoice_item7 = InvoiceItem.create!(quantity: 100, unit_price: 7000, status: 'shipped', item_id: item7.id, invoice_id: invoice7.id)

      transaction1 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
      transaction2 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
      transaction3 = Transaction.create!(result: 'success', invoice_id: invoice3.id)
      transaction4 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
      transaction5 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
      transaction6 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
      transaction7 = Transaction.create!(result: 'success', invoice_id: invoice7.id)

      expect(Merchant.merchant_revenue).to eq([merchant7, merchant6, merchant5, merchant4, merchant3])
    end
  end
end
