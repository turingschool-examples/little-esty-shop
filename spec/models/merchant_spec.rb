require 'rails_helper'

RSpec.describe Merchant do
  describe 'associations' do
    it {should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'Methods' do 
    before :each do 
      @merchant = Merchant.create!(name: 'Tom Holland')

      @customer1 = Customer.create!(first_name: 'Green', last_name: 'Goblin')

      @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)

      @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant.id)
      @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant.id)
      @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant.id)

      @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
    end 

    describe '::merchant_items' do 
      it 'returns all of the merchants items' do 
        expect(@merchant.merchant_items).to eq([@item1, @item2, @item3])
      end 
    end
    
    describe '::merchant_invoice' do 
      it 'returns all invoices with that merchants items' do 
        @merchant = Merchant.create!(name: 'Tom Holland')
        @merchant2 = Merchant.create!(name: 'Tom Holland')


        @customer1 = Customer.create!(first_name: 'Green', last_name: 'Goblin')
        @customer2 = Customer.create!(first_name: 'Green', last_name: 'Goblin')


        @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)
        @invoice2 =Invoice.create!(status: 2, customer_id: @customer1.id)


        @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant.id)
        @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant.id)
        @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant.id)

        @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
        @inv_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 200, status: 1)

        expect(Merchant.merchant_invoices(@merchant.id)).to eq([@invoice1, @invoice2])
      end
    end 
  end 
end
