require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it {should validate_presence_of :status}
  end

  describe "relationships" do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  before(:each) do
    @customer_1  = Customer.create!(first_name: 'Tanya', last_name: 'Tiger')
    @invoice_1 = @customer_1.invoices.create!(status: 0)
    @invoice_2 = @customer_1.invoices.create!(status: 1)
    @invoice_3 = @customer_1.invoices.create!(status: 1)
    @invoice_4 = @customer_1.invoices.create!(status: 2)
    @invoice_5 = @customer_1.invoices.create!(status: 0)

    @merchant_1 = Merchant.create!(name: 'Roald')
    @item_1 = @merchant_1.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 100)

    InvoiceItem.create!(invoice: @invoice_1, item: @item_1, status: 0)
    InvoiceItem.create!(invoice: @invoice_2, item: @item_1, status: 1)
    InvoiceItem.create!(invoice: @invoice_3, item: @item_1, status: 1)
    InvoiceItem.create!(invoice: @invoice_4, item: @item_1, status: 2)
    InvoiceItem.create!(invoice: @invoice_5, item: @item_1, status: 1)
  end

  describe '::ordered_invoices_not_shipped' do
    it 'orders from oldest to newest a list of invoices that are not shipped' do
      expect(Invoice.ordered_invoices_not_shipped).to eq([@invoice_5, @invoice_3, @invoice_2, @invoice_1])
    end
  end
end
