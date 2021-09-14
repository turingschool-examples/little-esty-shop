require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'instance methods' do
    before(:each) do
      @merch_1 = create(:merchant)
      @cust_1 = create(:customer)
      @cust_2 = create(:customer)
      @cust_3 = create(:customer)
      @cust_4 = create(:customer)
      @cust_5 = create(:customer)
      @cust_6 = create(:customer)
      @item_1 = create(:item, merchant: @merch_1)
      @invoice_1 = create(:invoice, customer: @cust_1)
      @invoice_2 = create(:invoice, customer: @cust_2)
      @invoice_3 = create(:invoice, customer: @cust_3)
      @invoice_4 = create(:invoice, customer: @cust_4)
      @invoice_5 = create(:invoice, customer: @cust_5)
      @invoice_6 = create(:invoice, customer: @cust_6)
      InvoiceItem.create(item: @item_1, invoice: @invoice_1)
      InvoiceItem.create(item: @item_1, invoice: @invoice_2)
      InvoiceItem.create(item: @item_1, invoice: @invoice_3)
      InvoiceItem.create(item: @item_1, invoice: @invoice_4)
      InvoiceItem.create(item: @item_1, invoice: @invoice_5)
      InvoiceItem.create(item: @item_1, invoice: @invoice_6)
      create(:transaction, invoice: @invoice_1, result: 'success')
      create(:transaction, invoice: @invoice_1, result: 'failed')
      create(:transaction, invoice: @invoice_1, result: 'failed')
      create(:transaction, invoice: @invoice_2, result: 'success')
      create(:transaction, invoice: @invoice_2, result: 'success')
      create(:transaction, invoice: @invoice_3, result: 'success')
      create(:transaction, invoice: @invoice_3, result: 'success')
      create(:transaction, invoice: @invoice_4, result: 'success')
      create(:transaction, invoice: @invoice_4, result: 'success')
      create(:transaction, invoice: @invoice_4, result: 'success')
      create(:transaction, invoice: @invoice_5, result: 'success')
      create(:transaction, invoice: @invoice_5, result: 'success')
      create(:transaction, invoice: @invoice_6, result: 'success')
      create(:transaction, invoice: @invoice_6, result: 'success')
      create(:transaction, invoice: @invoice_6, result: 'success')
      create(:transaction, invoice: @invoice_6, result: 'success')
    end

    it '#favorite_customers' do
      expected = @merch_1.favorite_customers.map do |customer|
        customer.first_name
      end
      expect(expected).to eq([@cust_6.first_name, @cust_4.first_name, @cust_2.first_name, @cust_3.first_name, @cust_5.first_name])
    end
  end
end
