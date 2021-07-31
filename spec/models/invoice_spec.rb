require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Osinski')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
    @customer_4 = Customer.create!(first_name: 'Leanne', last_name: 'Braun')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Heber', last_name: 'Kuhn')
    @customer_7 = Customer.create!(first_name: 'Parker', last_name: 'Daugherty')

    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = Invoice.create!(status: 1, customer_id: "#{@customer_1.id}")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-24 09:54:09 UTC')
    @invoice_4 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-23 09:54:09 UTC')
    @invoice_5 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}", created_at: '2012-03-22 09:54:09 UTC')
    @invoice_6 = Invoice.create!(status: 0, customer: @customer_1)
    @invoice_7 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_8 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_9 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_10 = Invoice.create!(status: 0, customer: @customer_2)
    @invoice_11 = Invoice.create!(status: 0, customer: @customer_3)
    @invoice_12 = Invoice.create!(status: 0, customer: @customer_3)
    @invoice_13 = Invoice.create!(status: 0, customer: @customer_3)
    @invoice_14 = Invoice.create!(status: 0, customer: @customer_4)
    @invoice_15 = Invoice.create!(status: 0, customer: @customer_4)
    @invoice_16 = Invoice.create!(status: 0, customer: @customer_5)

    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_6.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_7.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_8.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_9.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_10.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_11.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_12.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_13.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_14.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_15.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_16.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')

    @item_1 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_3 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_4 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_5 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_6 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)

    InvoiceItem.create!(invoice: @invoice_1, item: @item_1, quantity: 0, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_3, item: @item_3, quantity: 0, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_4, item: @item_4, quantity: 0, unit_price: 1000, status: 1)
    InvoiceItem.create!(invoice: @invoice_5, item: @item_5, quantity: 0, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_6, item: @item_6, quantity: 0, unit_price: 1000, status: 2)
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it {should define_enum_for(:status).with_values([:cancelled, 'in progress', :completed])}
  end

  describe 'class methods' do
    describe '::admin_incomplete_invoices' do

      it 'can find all the incomplete invoices listed by least recent created at date' do

        expect(Invoice.admin_incomplete_invoices).to eq([@invoice_5, @invoice_4, @invoice_3, @invoice_1])
      end
    end
  end
end
