require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    # Customers:
    @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
    @joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
    @billy    = Customer.create!(first_name: 'Billy', last_name: 'Joel')
    @steve    = Customer.create!(first_name: 'Steve', last_name: 'Carrell')
    @frank    = Customer.create!(first_name: 'Frank', last_name: 'Sinatra')
    @Jon      = Customer.create!(first_name: 'Jon', last_name: 'Travolta')
    # Merchants:
    @amazon   = Merchant.create!(name: 'Amazon')
    @alibaba  = Merchant.create!(name: 'Alibaba')
    @all_birds = Merchant.create!(name: 'All Birds', status: 0)
    @walmart   = Merchant.create!(name: 'Walmart', status: 0)
    @overstock = Merchant.create!(name: 'Overstock', status: 0)
    @big_lots  = Merchant.create!(name: 'Big Lots', status: 0)
    @amazon    = Merchant.create!(name: 'Amazon', status: 0)
    @alibaba   = Merchant.create!(name: 'Alibaba', status: 1)
    #Invoices
    @invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @amazon.id,)
    @invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id,)
    # Transactions:
    @tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, invoice_id: @invoice2.id,)
    @tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: @invoice1.id,)
    # Items:
    @candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: @amazon.id)
    @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
    @bottle   = Item.create!(name: 'bottle', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
    @pencil    = Item.create!(name: 'Pencil', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
    @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
    @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
    # InvoiceItems:
    @invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @candle.id)
    @invitm2  = InvoiceItem.create!(status: 0, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @backpack.id)
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
    it { should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'instance methods' do
    it 'Can return the quantity of items ordered' do
      expect(@candle.quantity_ordered(@candle.id, @invoice1.id)[0]).to eq(25)
    end

    it 'Can calculate the total price' do
      expect(@candle.total_price(@candle.id, @invoice1.id)).to eq(175)
    end

    it 'Can return the status of items ordered' do
      expect(@candle.status(@candle.id, @invoice1.id)[0]).to eq("packaged")
    end

    it "can return the top five most popular items by revenue" do
      all_birds = Merchant.create!(name: 'All Birds', status: 0)
      walmart   = Merchant.create!(name: 'Walmart', status: 0)
      overstock = Merchant.create!(name: 'Overstock', status: 0)
      big_lots  = Merchant.create!(name: 'Big Lots', status: 0)
      amazon    = Merchant.create!(name: 'Amazon', status: 0)
      alibaba   = Merchant.create!(name: 'Alibaba', status: 1)
      # Invoices:
      invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: amazon.id)
      invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: alibaba.id)
      invoice3 = Invoice.create!(status: 0, customer_id: @billy.id, merchant_id: all_birds.id)
      invoice4 = Invoice.create!(status: 0, customer_id: @steve.id, merchant_id: overstock.id)
      invoice5 = Invoice.create!(status: 0, customer_id: @frank.id, merchant_id: big_lots.id)
      invoice6 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: walmart.id)
      # Transactions:
      tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice2.id)
      tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: invoice1.id)
      tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice3.id)
      tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice4.id)
      tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id)
      tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id)
      tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice6.id)
      # Items:
      candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: amazon.id)
      backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: alibaba.id)
      radio1   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
      radio2   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: walmart.id)
      radio3   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: big_lots.id)
      radio4   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: overstock.id)
      # InvoiceItems:
      invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: invoice1.id, item_id: candle.id)
      invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: invoice2.id, item_id: backpack.id)
      invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: invoice3.id, item_id: radio1.id)
      invitm4  = InvoiceItem.create!(status: 1, quantity: 50, unit_price: 9.75, invoice_id: invoice4.id, item_id: radio2.id)
      invitm5  = InvoiceItem.create!(status: 1, quantity: 65, unit_price: 9.75, invoice_id: invoice5.id, item_id: radio3.id)
      invitm6  = InvoiceItem.create!(status: 1, quantity: 30, unit_price: 9.75, invoice_id: invoice6.id, item_id: radio4.id)

      actual = [radio3, radio1, radio2, radio4, backpack]

      expect(Item.top_5_popular_items).to eq(actual)
    end
    it "Can return the date with most sales for each item" do
      all_birds = Merchant.create!(name: 'All Birds', status: 0)
      walmart   = Merchant.create!(name: 'Walmart', status: 0)
      overstock = Merchant.create!(name: 'Overstock', status: 0)
      big_lots  = Merchant.create!(name: 'Big Lots', status: 0)
      amazon    = Merchant.create!(name: 'Amazon', status: 0)
      alibaba   = Merchant.create!(name: 'Alibaba', status: 1)
      # Invoices:
      invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: amazon.id)
      invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: alibaba.id)
      invoice3 = Invoice.create!(status: 0, customer_id: @billy.id, merchant_id: all_birds.id)
      invoice4 = Invoice.create!(status: 0, customer_id: @steve.id, merchant_id: overstock.id)
      invoice5 = Invoice.create!(status: 0, customer_id: @frank.id, merchant_id: big_lots.id)
      invoice6 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: walmart.id)
      # Transactions:
      tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice2.id)
      tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: invoice1.id)
      tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice3.id)
      tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice4.id)
      tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id)
      tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id)
      tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice6.id)
      # Items:
      candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: amazon.id)
      backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: alibaba.id)
      radio1   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
      radio2   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: walmart.id)
      radio3   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: big_lots.id)
      radio4   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: overstock.id)
      # InvoiceItems:
      invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: invoice1.id, item_id: candle.id)
      invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: invoice2.id, item_id: backpack.id)
      invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: invoice3.id, item_id: radio1.id)
      invitm4  = InvoiceItem.create!(status: 1, quantity: 50, unit_price: 9.75, invoice_id: invoice4.id, item_id: radio2.id)
      invitm5  = InvoiceItem.create!(status: 1, quantity: 65, unit_price: 9.75, invoice_id: invoice5.id, item_id: radio3.id)
      invitm6  = InvoiceItem.create!(status: 1, quantity: 30, unit_price: 9.75, invoice_id: invoice6.id, item_id: radio4.id)

      date = radio1.invoices.best_day.created_at
      expected = date.strftime('%m/%d/%y')

      expect(expected).to eq("01/20/21") 
    end
  end
end
