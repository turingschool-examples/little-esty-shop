require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
   describe '.enabled_merchants' do
      it 'can get all the merchants that are enabled' do
        expect(Merchant.enabled_merchants).to eq([@merchant5, @merchant6])
      end
    end

    describe '.disabled_merchants' do
      it 'can get all the merchants that are disabled' do
        expect(Merchant.disabled_merchants).to eq([@merchant1, @merchant2, @merchant3, @merchant4, @merchant7])
      end
    end

    describe '.top_5_merchants_revenue' do
      it 'can get the top 5 merchants by their revenue based off of successful transactions' do
        expect(Merchant.top_5_merchants_revenue).to eq([@merchant2, @merchant1, @merchant3])
      end
    end
  end

  describe 'instance methods' do
    describe '#best_day' do
      xit 'can get the best day for revenue for the top 5 merchants by revenue' do
        expect(@merchant1.best_day)
      end
    end
    describe '#top_five_items' do
      it 'can return the top five revenue earning items for a merchant' do
        expected = [@item14, @item16, @item1, @item15, @item13]

        expect(@merchant1.top_five_items).to eq(expected)
      end
    end
    describe '#ready_to_ship' do
      it 'can give all items that are ready to ship ordered by oldest first' do
        @merchant1 = Merchant.create!(name: 'Costco', status: "disabled")
        @customer1 = Customer.create!(first_name: 'Gunner', last_name: 'Runkle')
        @item1 = @merchant1.items.create!(name: 'Milk', description: 'A large quantity of whole milk', unit_price: 500)
        @invoice1 = @customer1.invoices.create!(status: 'completed', created_at: '2018-02-13 14:53:59 UTC', updated_at: '2018-02-13 14:53:59 UTC')
        @invoice2 = @customer1.invoices.create!(status: 'completed', created_at: '2015-05-25 14:53:59 UTC', updated_at: '2015-05-25 14:53:59 UTC')
        @invoice3 = @customer1.invoices.create!(status: 'completed', created_at: '2010-01-24 14:53:59 UTC', updated_at: '2010-01-24 14:53:59 UTC')
        @invoice4 = @customer1.invoices.create!(status: 'completed', created_at: '2015-05-25 14:53:59 UTC', updated_at: '2015-05-25 14:53:59 UTC')
        @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 125, unit_price: @item1.unit_price, status: 'packaged')
        @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item1.id, quantity: 250, unit_price: @item1.unit_price, status: 'pending')
        @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item1.id, quantity: 1000, unit_price: @item1.unit_price, status: 'packaged')
        @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item1.id, quantity: 500, unit_price: @item1.unit_price, status: 'shipped')
        @transaction1 = @invoice1.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        @transaction2 = @invoice2.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
        @transaction3 = @invoice3.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)
        @transaction4 = @invoice4.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)

        actual = @merchant1.ready_to_ship.map do |item|
          item.invoice_date
        end

        expected = [@invoice3, @invoice2, @invoice1].map do |invoice|
          invoice.created_at
        end

        expect(actual).to eq(expected)
      end
    end
  end
end
