require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
  end

  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe 'model methods' do

    it "can show invoice quantity" do

      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

      customer_1 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)


      invoice_1 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )
      invoice_2 = Invoice.create!(status: :completed, created_at: Time.now, updated_at: Time.now, customer_id: customer_1.id )

      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: item_2.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 3, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_1.id, quantity: 4, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_1.id, quantity: 5, unit_price: item_5.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)
      invoice_item_6 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_1.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)
      invoice_item_7 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 6, unit_price: item_6.unit_price, status: 1, created_at: Time.now, updated_at: Time.now)

      expect(item_1.invoice_quantity(invoice_1.id).first.quantity).to eq(1)
      expect(item_1.invoice_quantity(invoice_2.id).first.quantity).to eq(6)

    end
  end

    it "gets the date for the invoice with the most popular item" do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)

      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_3 = Item.create!(name: "Beanie", description: "Perfect for a cold day", unit_price: 5000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_4 = Item.create!(name: "Socks", description: "Everyone loves socks", unit_price: 6000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_5 = Item.create!(name: "Necklace", description: "Who even wears these anymore", unit_price: 7000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_6 = Item.create!(name: "Wallet", description: "Money pocket for your pocket", unit_price: 8000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)

      customer_1 = Customer.create!(first_name: "James", last_name: "Franco", created_at: Time.now, updated_at: Time.now)
      customer_2 = Customer.create!(first_name: "Frank", last_name: "Jameson", created_at: Time.now, updated_at: Time.now)
      customer_3 = Customer.create!(first_name: "John", last_name: "Smith", created_at: Time.now, updated_at: Time.now)
      customer_4 = Customer.create!(first_name: "Zack", last_name: "Adams", created_at: Time.now, updated_at: Time.now)
      customer_5 = Customer.create!(first_name: "Chloe", last_name: "Wheeler", created_at: Time.now, updated_at: Time.now)
      customer_6 = Customer.create!(first_name: "Zoe", last_name: "Atkins", created_at: Time.now, updated_at: Time.now)
      customer_7 = Customer.create!(first_name: "Mike", last_name: "Dao", created_at: Time.now, updated_at: Time.now)

      invoice_1 = customer_6.invoices.create!(status: 1, created_at: "01/01/1990", updated_at: Time.now)
      invoice_2 = customer_6.invoices.create!(status: 1, created_at: "02/01/1990", updated_at: Time.now)
      invoice_3 = customer_6.invoices.create!(status: 1, created_at: "03/01/1990", updated_at: Time.now)
      invoice_4 = customer_6.invoices.create!(status: 1, created_at: "04/01/1990", updated_at: Time.now)
      invoice_5 = customer_6.invoices.create!(status: 1, created_at: "05/01/1990", updated_at: Time.now)
      invoice_6 = customer_3.invoices.create!(status: 1, created_at: "06/01/1990", updated_at: Time.now)
      invoice_7 = customer_3.invoices.create!(status: 1, created_at: "07/01/1990", updated_at: Time.now)
      invoice_8 = customer_3.invoices.create!(status: 1, created_at: "08/01/1990", updated_at: Time.now)
      invoice_9 = customer_3.invoices.create!(status: 1, created_at: "09/01/1990", updated_at: Time.now)
      invoice_10 = customer_5.invoices.create!(status: 1, created_at: "10/01/1990", updated_at: Time.now)
      invoice_11 = customer_5.invoices.create!(status: 1, created_at: "11/01/1990", updated_at: Time.now)
      invoice_12 = customer_5.invoices.create!(status: 1, created_at: "12/01/1990", updated_at: Time.now)
      invoice_13 = customer_2.invoices.create!(status: 1, created_at: "13/01/1990", updated_at: Time.now)
      invoice_14 = customer_2.invoices.create!(status: 1, created_at: "14/01/1990", updated_at: Time.now)
      invoice_15 = customer_7.invoices.create!(status: 2, created_at: "15/01/1990", updated_at: Time.now)

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_4.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_6.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_7 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_8 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_8.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_9 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_9.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_10 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_10.id, quantity: 1, unit_price:item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)

      invoice_item_11 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_11.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_12 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_12.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_13 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_13.id, quantity: 1, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_14 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_14.id, quantity: 500, unit_price: item_4.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_15 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_14.id, quantity: 1, unit_price: item_4.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_16 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_14.id, quantity: 30, unit_price: item_1.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_17 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_14.id, quantity: 30, unit_price: item_2.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_18 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_14.id, quantity: 30, unit_price: item_3.unit_price, status: 2, created_at: Time.now, updated_at: Time.now)
      invoice_item_19 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_15.id, quantity: 700, unit_price: item_4.unit_price, status: 0, created_at: Time.now, updated_at: Time.now)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '4039485738495837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '4039485738495837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '4039485738495837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '4847583748374837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '4847583748374837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '4847583748374837', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '4364756374652636', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '4364756374652636', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_9 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: '4928294837461125', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_10 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: '4928294837461125', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_11 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: '4738473664751832', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_12 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: '4738473664751832', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_13 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: '4023948573948293', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_14 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: '4023948573948293', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)
      transaction_15 = Transaction.create!(invoice_id: invoice_15.id, credit_card_number: '4023948573948293', credit_card_expiration_date: "1", result: "success", created_at: Time.now, updated_at: Time.now)

      expect(item_5.best_revenue_day[0].date.strftime('%B %d, %Y')).to eq("January 15, 1990")
    end
end
