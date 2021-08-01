require 'rails_helper'

RSpec.describe Merchant do
  describe 'associations' do
    it {should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :status }

  end

  describe 'Methods' do
    before :each do
      @merchant = Merchant.create!(name: 'Tom Holland', status: 0)

      @customer1 = Customer.create!(first_name: 'Green', last_name: 'Goblin')

      @invoice1 =Invoice.create!(status: 2, customer_id: @customer1.id)

      @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant.id)
      @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant.id)
      @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant.id)

      @inv_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 200, status: 1)
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

    describe '::order_by_enabled' do
      it 'selects all merchatn with enabled status' do
        @merchant1 = Merchant.create!(name: 'Alpha', status: 0)
        @merchant2 = Merchant.create!(name: 'Beta', status: 1)
        @merchant3 = Merchant.create!(name: 'Charlie', status: 0)
        @merchant4 = Merchant.create!(name: 'Delta', status: 1)
        @merchant5 = Merchant.create!(name: 'Exodus', status: 0)
        @merchant6 = Merchant.create!(name: 'Fenta', status: 1)

        expect(Merchant.order_by_enabled).to eq([@merchant, @merchant1, @merchant3, @merchant5])
      end
    end

    describe '::order_by_disabled' do
      it 'selects all merchant with enabled status' do
        @merchant1 = Merchant.create!(name: 'Alpha', status: 0)
        @merchant2 = Merchant.create!(name: 'Beta', status: 1)
        @merchant3 = Merchant.create!(name: 'Charlie', status: 0)
        @merchant4 = Merchant.create!(name: 'Delta', status: 1)
        @merchant5 = Merchant.create!(name: 'Exodus', status: 0)
        @merchant6 = Merchant.create!(name: 'Fenta', status: 1)

        expect(Merchant.order_by_disabled).to eq([@merchant2, @merchant4, @merchant6])
      end
    end

    describe '#enable_opposite' do
      it "returns the opposite of the item's enabled/disabled status; " do
        expect(@merchant.status).to eq('enabled')
        expect(@merchant.status_opposite).to eq('disabled')
      end
    end
  end
end
