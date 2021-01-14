require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :customers }
    it { should have_many :items }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
  end

  describe 'instance methods' do
    before :each do

      @merchant = FactoryBot.create(:merchant)
      @item1 = FactoryBot.create(:item, merchant: @merchant)
      @item2 = FactoryBot.create(:item, merchant: @merchant)
      @item3 = FactoryBot.create(:item, merchant: @merchant)
      @item4 = FactoryBot.create(:item, merchant: @merchant)
      @item5 = FactoryBot.create(:item, merchant: @merchant)
      @item6 = FactoryBot.create(:item, merchant: @merchant)

      @invoice_item2 = FactoryBot.create(:invoice_item, item: @item2)
      @invoice_item3 = FactoryBot.create(:invoice_item, item: @item3)
      @invoice_item4 = FactoryBot.create(:invoice_item, item: @item4)
      @invoice_item5 = FactoryBot.create(:invoice_item, item: @item5)
      @invoice_item6 = FactoryBot.create(:invoice_item, item: @item6)
      @invoice_item7 = FactoryBot.create(:invoice_item, item: @item1)
      @invoice_item8 = FactoryBot.create(:invoice_item, item: @item2)
      @invoice_item9 = FactoryBot.create(:invoice_item, item: @item3)
      @invoice = FactoryBot.create(:invoice, merchant: @merchant, customer: Customer.first)
      @invoice_item1 = FactoryBot.create(:invoice_item, item: @item1, invoice: @invoice)

      @transactions = FactoryBot.create(:transaction, invoice: @invoice)

 # before :each do
   # @merchant1 = Merchant.create!(name: "Robert Heath")
   # @merchant2 = Merchant.create!(name: "Liam and Sons and Daughters")

  #  @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
  #  @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
  #  @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
  #  @item4 = Item.create!(name: "My shoes", description: "too big", unit_price: 200, merchant_id: @merchant2.id)
  #  @item5 = Item.create!(name: "my tie", description: "too tight", unit_price: 300, merchant_id: @merchant2.id)

  #  @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Steel')
  #  @customer_2 = Customer.create!(first_name: 'Phoebe', last_name: 'Link')
  #  @customer_3 = Customer.create!(first_name: 'Rachel', last_name: 'Doop')
  #  @customer_4 = Customer.create!(first_name: 'Other', last_name: 'Diny')
  #  @customer_5 = Customer.create!(first_name: 'Macy', last_name: 'Finy')
  #  @customer_6 = Customer.create!(first_name: 'Grayson', last_name: 'Niny')

  #  @invoice_1 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 1)
  #  @invoice_2 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 1)
  #  @invoice_3 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_2.id, status: 1)
  #  @invoice_4 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_3.id, status: 1)
  #  @invoice_5 = Invoice.create!(merchant_id: @merchant2.id, customer_id: @customer_4.id, status: 1)
  #  @invoice_6 = Invoice.create!(merchant_id: @merchant2.id, customer_id: @customer_5.id, status: 1)
  #  @invoice_7 = Invoice.create!(merchant_id: @merchant2.id, customer_id: @customer_6.id, status: 2)

  #  @ii1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item1.id, quantity: 9, unit_price: 10, status: 2, created_at: "2012-03-27 14:54:09")
  #  @ii2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
  #  @ii3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item2.id, quantity: 2, unit_price: 8, status: 2, created_at: "2012-03-28 14:54:09")
  #  @ii4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item3.id, quantity: 3, unit_price: 5, status: 2, created_at: "2012-03-30 14:54:09")
  #  @ii6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item4.id, quantity: 1, unit_price: 1, status: 2, created_at: "2012-04-01 14:54:09")
  #  @ii7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item5.id, quantity: 1, unit_price: 3, status: 2, created_at: "2012-04-02 14:54:09")
  #  @ii8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item5.id, quantity: 1, unit_price: 5, status: 2, created_at: "2012-04-03 14:54:09")
  #  @ii9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item4.id, quantity: 1, unit_price: 1, status: 1, created_at: "2012-04-04 14:54:09")

  #  @transaction1 = Transaction.create!(credit_card_number: 203942, result: 0, invoice_id: @invoice_1.id)
  #  @transaction2 = Transaction.create!(credit_card_number: 230948, result: 0, invoice_id: @invoice_2.id)
  #  @transaction3 = Transaction.create!(credit_card_number: 234092, result: 0, invoice_id: @invoice_3.id)
  #  @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
  #  @transaction5 = Transaction.create!(credit_card_number: 102938, result: 0, invoice_id: @invoice_5.id)
  #  @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
  #  @transaction7 = Transaction.create!(credit_card_number: 203942, result: 0, invoice_id: @invoice_7.id)

  end

  describe 'class methods' do
    it 'can select top five merchant by total revenue' do
      expect(Merchant.top_five.first).to eq(@merchant1)
      expect(Merchant.top_five.last).to eq(@merchant2)
    end
  end

  describe 'instance methods' do
    it 'can find all enabled items for a merchant' do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item10 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item20 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item30 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
      @item40 = Item.create!(name: "blue pencil", description: "blue", unit_price: 100.00, merchant_id: @merchant1.id)

      expect(@merchant1.enabled_items).to eq([@item10, @item20])
    end

    it 'can find all disabled items for a merchant' do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item10 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item20 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item30 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
      @item40 = Item.create!(name: "blue pencil", description: "blue", unit_price: 100.00, merchant_id: @merchant1.id)

      expect(@merchant1.disabled_items).to eq([@item30, @item40])
    end

    it 'can find top five items for a merchant' do

      expect(@merchant.top_five_items).to eq([@item1])
    end

    it 'can find top_5 customers by number successfull transactions' do
    end

    it 'can find items ready to ship' do
    end

    it 'can find invoices of items ready to ship' do
    end

    it 'can find best_day based off merchant invoices' do
      expect(@merchant1.best_day).to eq("Thursday, January 01, 2021")
    end

  end
  
end
