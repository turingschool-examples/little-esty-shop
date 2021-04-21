require 'rails_helper'

RSpec.describe Customer, type: :model do
  before :each do
    @merchant1 = create(:merchant, status: true)
    @merchant2 = create(:merchant, status: true)
    @merchant3 = create(:merchant, status: false)
    @merchant4 = create(:merchant, status: false)
    @merchant5 = create(:merchant, status: false)
    @merchant6 = create(:merchant, status: true)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant2.id)
    @item3 = create(:item, merchant_id: @merchant3.id)
    @item4 = create(:item, merchant_id: @merchant4.id)
    @item5 = create(:item, merchant_id: @merchant5.id)
    @item6 = create(:item, merchant_id: @merchant6.id)

    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    @customer7 = create(:customer)

    @invoice1 = create(:invoice, customer_id: @customer1.id)
    @invoice2 = create(:invoice, customer_id: @customer2.id)
    @invoice3 = create(:invoice, customer_id: @customer3.id)
    @invoice4 = create(:invoice, customer_id: @customer4.id)
    @invoice5 = create(:invoice, customer_id: @customer5.id)
    @invoice6 = create(:invoice, customer_id: @customer5.id)
    @invoice7 = create(:invoice, customer_id: @customer6.id)
    @invoice8 = create(:invoice, customer_id: @customer6.id)
    @invoice9 = create(:invoice, customer_id: @customer6.id)
    @invoice10 = create(:invoice, customer_id: @customer7.id)

    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 5, unit_price: 100)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item1.id, status: 1, quantity: 15, unit_price: 100)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item2.id, status: 0, quantity: 9, unit_price: 100)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item3.id, status: 2, quantity: 10, unit_price: 100)
    @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item3.id, status: 0, quantity: 2, unit_price: 100)
    @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item4.id, status: 2, quantity: 11, unit_price: 100)
    @invoice_item7 = create(:invoice_item, invoice_id: @invoice7.id, item_id: @item5.id, status: 2, quantity: 11, unit_price: 100)
    @invoice_item8 = create(:invoice_item, invoice_id: @invoice8.id, item_id: @item5.id, status: 2, quantity: 11, unit_price: 100)
    @invoice_item9 = create(:invoice_item, invoice_id: @invoice9.id, item_id: @item5.id, status: 2, quantity: 11, unit_price: 100)
    @invoice_item10 = create(:invoice_item, invoice_id: @invoice10.id, item_id: @item6.id, status: 2, quantity: 11, unit_price: 100)

    @transactions = create_list(:transaction, 6, invoice_id: @invoice_item1.invoice.id, result: 0)
    @transactions2 = create_list(:transaction, 7, invoice_id: @invoice_item2.invoice.id, result: 0)
    @transactions3 = create_list(:transaction, 8, invoice_id: @invoice_item3.invoice.id, result: 0)
    @transactions4 = create_list(:transaction, 9, invoice_id: @invoice_item4.invoice.id, result: 0)
    @transactions5 = create_list(:transaction, 10, invoice_id: @invoice_item5.invoice.id, result: 0)
    @transactions6 = create_list(:transaction, 11, invoice_id: @invoice_item6.invoice.id, result: 0)
    @transactions7 = create_list(:transaction, 11, invoice_id: @invoice_item7.invoice.id, result: 0)
    @transactions8 = create_list(:transaction, 11, invoice_id: @invoice_item8.invoice.id, result: 0)
    @transactions9 = create_list(:transaction, 11, invoice_id: @invoice_item9.invoice.id, result: 0)
    @transactions10 = create_list(:transaction, 11, invoice_id: @invoice_item10.invoice.id, result: 0)
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'model tests' do
    it 'can return a list of the top 5 customers that have the most successful transactions' do
      expect(Customer.top_five_customers).to eq(
        [@customer6, @customer5, @customer7, @customer4, @customer3]
      )
    end
  end
end
