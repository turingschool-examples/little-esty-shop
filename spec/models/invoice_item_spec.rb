require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it {should validate_presence_of :quantity}
    it {should validate_numericality_of :quantity}
    it {should validate_presence_of :unit_price}
    it {should validate_numericality_of :unit_price}
    it {should validate_presence_of :status}
  end

  describe "relationships" do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  before(:each) do
    @customer_1  = Customer.create!(first_name: 'Tanya', last_name: 'Tiger')
    @invoice_1 = @customer_1.invoices.create!(status: 0)
    @invoice_2 = @customer_1.invoices.create!(status: 1)
    @invoice_3 = @customer_1.invoices.create!(status: 1)
    @invoice_4 = @customer_1.invoices.create!(status: 2)
    @invoice_5 = @customer_1.invoices.create!(status: 0)

    @merchant_1 = Merchant.create!(name: 'Roald')
    @item_1 = @merchant_1.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 39434)
    @item_2 = @merchant_1.items.create!(name: 'Lays', description: 'Deliciouio', unit_price: 8356)
    @item_3 = @merchant_1.items.create!(name: 'Cadlee', description: 'Perfecto', unit_price: 9064)

    InvoiceItem.create!(invoice: @invoice_1, item: @item_1, status: 0, quantity: 200, unit_price: 39434)
    InvoiceItem.create!(invoice: @invoice_1, item: @item_2, status: 1, quantity: 295, unit_price: 8356)
    InvoiceItem.create!(invoice: @invoice_1, item: @item_3, status: 2, quantity: 382, unit_price: 9064)
    InvoiceItem.create!(invoice: @invoice_4, item: @item_1, status: 2, quantity: 130, unit_price: 39434)
    InvoiceItem.create!(invoice: @invoice_5, item: @item_1, status: 1, quantity: 97, unit_price: 39434)
  end

  describe '::find_invoice_items' do
    it 'finds invoice items based on invoice id' do
      expect(InvoiceItem.find_invoice_items(@invoice_1)[0].invoice_id).to eq(@invoice_1.id)
      expect(InvoiceItem.find_invoice_items(@invoice_1)).to_not include(@invoice_4.id)
    end
  end

  describe '#convert_to_dollar' do
    it 'converts unit_price integer to float dollar' do
      @check_first_invoice_item = InvoiceItem.find_invoice_items(@invoice_1).first
      expect(@check_first_invoice_item.convert_to_dollar).to eq(394.34)
    end
  end
end
