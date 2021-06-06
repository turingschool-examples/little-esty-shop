require 'rails_helper'

RSpec.describe Item do
  before(:each) do
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @item =  @merchant.items.create!(name: 'Qui Esse', description: 'Lorem ipsim', unit_price: 75107)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 20112)
    @item_3 = @merchant.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 2)
end

  describe 'relationships' do
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'class methods' do
    it '::not_yet_shipped' do

      expect(Item.not_yet_shipped).to eq([@item, @item_2])
    end
  end

  describe 'instance methods' do
  end
end
