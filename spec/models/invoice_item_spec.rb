require 'rails_helper'

RSpec.describe InvoiceItem do
  before(:each) do
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @item =  @merchant.items.create!(name: 'Qui Esse', description: 'Lorem ipsim', unit_price: 75107)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 20112)
    @item_3 = @merchant.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 'packaged')
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 'packaged')
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 'shipped')

  end

  describe 'relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'class methods' do

    it "::find_invoice_id" do
      
      expect(InvoiceItem.find_invoice_id(@item_2.id)).to eq (@invoice.id)
    end

    it "::find_invoice_created_at" do
  
      expect(InvoiceItem.find_invoice_created_at(@item_2.id)).to eq (@invoice.created_at)
    end
  end

  describe 'instance methods' do
  end
end
