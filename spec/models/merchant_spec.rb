require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'instance methods' do
    before(:each) do
      @merch1 = create(:merchant)
      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)
      @cust4 = create(:customer)
      @cust5 = create(:customer)
      @cust6 = create(:customer)
      @cust7 = create(:customer)
      @item1 = create(:item, merchant: @merch1)
      @item2 = create(:item, merchant: @merch1)
      @item3 = create(:item, merchant: @merch1)
      @invoice1 = create(:invoice, customer: @cust1)
      @invoice2 = create(:invoice, customer: @cust2)
      @invoice3 = create(:invoice, customer: @cust3)
      @invoice4 = create(:invoice, customer: @cust4)
      @invoice5 = create(:invoice, customer: @cust5)
      @invoice6 = create(:invoice, customer: @cust6)
      @invoice7 = create(:invoice, customer: @cust7)
      @invoice8 = create(:invoice, customer: @cust7)
      InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1)
      InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1)
      InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
      InvoiceItem.create(item: @item1, invoice: @invoice2)
      InvoiceItem.create(item: @item1, invoice: @invoice3)
      InvoiceItem.create(item: @item1, invoice: @invoice4)
      InvoiceItem.create(item: @item1, invoice: @invoice5)
      InvoiceItem.create(item: @item1, invoice: @invoice6)
      InvoiceItem.create(item: @item2, invoice: @invoice7)
      InvoiceItem.create(item: @item2, invoice: @invoice8)
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'failed')
      create(:transaction, invoice: @invoice1, result: 'failed')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
    end

    it '#favorite_customers' do
      expect(@merch1.favorite_customers).to eq([@cust2, @cust6, @cust4, @cust3, @cust5])
    end

    it '#items_ready_to_ship' do
      expect(@merch1.items_ready_to_ship).to eq([@item1, @item2, @item3])
    end

    it '#ordered_invoices' do
      expect(@item2.ordered_invoices).to eq([@invoice2, @invoice7, @invoice8])
    end

    it '#created_at_formatted' do
      expect(@invoice1.created_at_formatted).to eq(@invoice1.created_at.strftime("%A, %B %d, %Y"))
    end
  end

  describe 'top_five_items' do
    it '#top_five_items' do
      @merch1 = create(:merchant)
      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)
      @cust4 = create(:customer)
      @cust5 = create(:customer)
      @cust6 = create(:customer)
      @item1 = create(:item, merchant: @merch1, unit_price: 100)
      @item2 = create(:item, merchant: @merch1, unit_price: 200)
      @item3 = create(:item, merchant: @merch1, unit_price: 500)
      @item4 = create(:item, merchant: @merch1, unit_price: 600)
      @item5 = create(:item, merchant: @merch1, unit_price: 1000)
      @item6 = create(:item, merchant: @merch1, unit_price: 2000)
      @item7 = create(:item, merchant: @merch1, unit_price: 5000)
      @invoice1 = create(:invoice, customer: @cust1)
      @invoice2 = create(:invoice, customer: @cust2)
      @invoice3 = create(:invoice, customer: @cust3)
      @invoice4 = create(:invoice, customer: @cust4)
      @invoice5 = create(:invoice, customer: @cust5)
      @invoice6 = create(:invoice, customer: @cust6)
      @invoice7 = create(:invoice, customer: @cust6)
      @invoice8 = create(:invoice, customer: @cust6)
      @invoice9 = create(:invoice, customer: @cust6)
      @invoice10 = create(:invoice, customer: @cust6)
      @invoice11 = create(:invoice, customer: @cust6)
      @invoice12 = create(:invoice, customer: @cust6)
      @invoice13 = create(:invoice, customer: @cust6)
      @invoice14 = create(:invoice, customer: @cust6)
      InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 1, unit_price: @item1.unit_price)
      InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 2, unit_price: @item1.unit_price)
      InvoiceItem.create(item: @item2, invoice: @invoice4, quantity: 4, unit_price: @item2.unit_price)
      InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 3, unit_price: @item2.unit_price)
      InvoiceItem.create(item: @item3, invoice: @invoice5, quantity: 5, unit_price: @item3.unit_price)
      InvoiceItem.create(item: @item3, invoice: @invoice6, quantity: 6, unit_price: @item3.unit_price)
      InvoiceItem.create(item: @item4, invoice: @invoice7, quantity: 7, unit_price: @item4.unit_price)
      InvoiceItem.create(item: @item4, invoice: @invoice8, quantity: 8, unit_price: @item4.unit_price)
      InvoiceItem.create(item: @item5, invoice: @invoice9, quantity: 9, unit_price: @item5.unit_price)
      InvoiceItem.create(item: @item5, invoice: @invoice10, quantity: 10, unit_price: @item5.unit_price)
      InvoiceItem.create(item: @item6, invoice: @invoice11, quantity: 11, unit_price: @item6.unit_price)
      InvoiceItem.create(item: @item6, invoice: @invoice12, quantity: 12, unit_price: @item6.unit_price)
      InvoiceItem.create(item: @item7, invoice: @invoice13, quantity: 13, unit_price: @item7.unit_price)
      InvoiceItem.create(item: @item7, invoice: @invoice14, quantity: 14, unit_price: @item7.unit_price)
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice7, result: 'success')
      create(:transaction, invoice: @invoice8, result: 'success')
      create(:transaction, invoice: @invoice9, result: 'success')
      create(:transaction, invoice: @invoice10, result: 'success')
      create(:transaction, invoice: @invoice11, result: 'success')
      create(:transaction, invoice: @invoice12, result: 'success')
      create(:transaction, invoice: @invoice13, result: 'success')
      create(:transaction, invoice: @invoice14, result: 'success')
      expected = [@item7, @item6, @item5, @item4, @item3]

      expect(@merch1.top_five_items).to eq(expected)
    end
  end
end
