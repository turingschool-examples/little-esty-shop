require 'rails_helper'

RSpec.describe Invoice do
  before(:each) do
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @merchant_2 = Merchant.create!(name: 'Billy Mandmade')
    @item =  @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_3 = @merchant_2.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @invoice_2 = Invoice.create!(customer_id: @customer.id, status: 'completed')
    InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'class methods' do
    describe '#filter_by_unshipped_order_by_age' do
      it 'returns all invoices with unshipped items sorted by creation date' do
        expect(Invoice.filter_by_unshipped_order_by_age.count("distinct invoices.id")).to eq(843)
        expect(Invoice.filter_by_unshipped_order_by_age.first.id).to eq(112)
        expect(Invoice.filter_by_unshipped_order_by_age.last.id).to eq(390)
      end
    end
  end

  describe 'instance methods' do

  end
end
