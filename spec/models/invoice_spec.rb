require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'validations' do 
    it { should define_enum_for(:status).with_values(['in progress', :cancelled, :completed]) }
  end 

  before :each do 
    @merchant = Merchant.create!(name: 'BuyMyThings')
    @merchant2 = Merchant.create!(name: 'BuyMyThings')

    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @customer2 = Customer.create!(first_name: 'Hungry', last_name: 'Individual')

    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000', merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '1500', merchant_id: @merchant2.id)
    
    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice3 =Invoice.create!(status: 0, customer_id: @customer2.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 400, status: 1)
    @invoice_item3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
  end

  describe 'instance methods' do 
    describe '#customer_name' do
      it 'returns the full name of a the customer an invoice belongs to' do
        expect(@invoice1.customer_name).to eq("Tired Person")
       end 
    end 

    describe '#format_created_at' do
      it 'returns the time the invoice was created at in "Weekday, Month-Day, Year format' do
        expect(@invoice1.format_created_at(@invoice1.created_at)).to eq(Date.today.strftime("%A, %B %d, %Y"))
       end 
    end 

    describe '#invoice_revenue' do
      it 'returns the total revenue that will be generated from all of the items on the invoice' do
        expect(@invoice1.invoice_revenue).to eq(6)
        expect(@invoice2.invoice_revenue).to eq(8)
       end 
    end 
  end 
end
