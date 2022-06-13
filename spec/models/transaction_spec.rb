require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should have_many(:invoice_items).through(:invoice) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:customers).through(:invoice) }
  end

  describe 'validations' do
    it { should define_enum_for(:result).with_values(%i[success failed]) }
  end

  describe 'scopes' do
    before(:each) do
      @merchant = Merchant.create!(name: 'BuyMyThings')
      @merchant2 = Merchant.create!(name: 'BuyMyThings')
      @customer1 = Customer.create!(first_name: 'Fred', last_name: 'Dunce')
      @customer2 = Customer.create!(first_name: 'Sal', last_name: 'Dali')
      @customer3 = Customer.create!(first_name: 'Earny', last_name: 'Hemi')
      @customer4 = Customer.create!(first_name: 'Jack', last_name: 'Wack')
      @customer5 = Customer.create!(first_name: 'Mack', last_name: 'Aurther')
      @customer6 = Customer.create!(first_name: 'Charly', last_name: 'Dicky')

      @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
      @invoice2 = Invoice.create!(status: 0, customer_id: @customer1.id)
      @invoice3 = Invoice.create!(status: 0, customer_id: @customer2.id)
      @invoice4 = Invoice.create!(status: 0, customer_id: @customer3.id)
      @invoice5 = Invoice.create!(status: 0, customer_id: @customer4.id)
      @invoice6 = Invoice.create!(status: 0, customer_id: @customer5.id)
      @invoice7 = Invoice.create!(status: 0, customer_id: @customer6.id)

      @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
      @item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000',
                            merchant_id: @merchant.id)
      @item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '3500',
                            merchant_id: @merchant2.id)

      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                           status: 1)
      @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 400,
                                           status: 0)
      @invoice_item3 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 200,
                                           status: 2)
      @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                           status: 2)
      @invoice_item5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 100,
                                           status: 2)
      @invoice_item6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice5.id, quantity: 2, unit_price: 400,
                                           status: 2)
      @invoice_item7 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 3, unit_price: 200,
                                           status: 2)
      @invoice_item8 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 100,
                                           status: 2)

      @transaction1 = Transaction.create!(result: 0, invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(result: 0, invoice_id: @invoice3.id)
      @transaction3 = Transaction.create!(result: 0, invoice_id: @invoice4.id)
      @transaction4 = Transaction.create!(result: 1, invoice_id: @invoice5.id)
    end
    describe '#successful_transactions' do
      it 'should only return successful_transactions' do
        expect(Transaction.successful_transactions.count).to eq(3)
      end
    end
  end
end
