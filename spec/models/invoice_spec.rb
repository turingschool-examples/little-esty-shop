require 'rails_helper'

RSpec.describe Invoice do
  before :each do
    @merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Bottle', unit_price: 100, description: 'H20')
    @item_2 = @merchant.items.create!(name: 'Can', unit_price: 500, description: 'Soda')

    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson",
                                 created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                 updated_at: Time.parse('2012-03-27 14:54:09 UTC'))

    @invoice = @customer.invoices.create!(status: "in progress",
                                          created_at: Time.parse('2012-03-25 09:54:09 UTC'),
                                          updated_at: Time.parse('2012-03-25 09:54:09 UTC'))

    @invoice_item_1 = @invoice.invoice_items.create!(item_id: @item_1.id, quantity: 8, unit_price: 100, status: 'shipped')
    @invoice_item_2 = @invoice.invoice_items.create!(item_id: @item_2.id, quantity: 5, unit_price: 500, status: 'packaged')
  end

  context 'readable attributes' do
    it 'has a status' do
      expect(@invoice.status).to eq("in progress")
    end
  end

  context 'validations' do
    it { should validate_presence_of :status}
    it { should define_enum_for(:status) }
  end

  context 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items)}
  end

  context 'instance methods' do
    it '.get_invoice_item(id) returns a specific invoice item' do
      expect(@invoice.get_invoice_item(@item_1.id)).to eq(@invoice_item_1)
      expect(@invoice.get_invoice_item(@item_2.id)).to eq(@invoice_item_2)
    end

    it '.total_revenue returns the sum of all item costs' do
      merchant = Merchant.create!(name: 'Brylan')
      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 3, description: 'Soda')
      item_3 = merchant.items.create!(name: 'Bowl', unit_price: 15, description: 'Soda')
      customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
      invoice = customer.invoices.create(status: "in progress", created_at: Time.parse("2022-04-12 09:54:09"))
      item_1.invoice_items.create!(invoice_id: invoice.id, quantity: 3, unit_price: 4, status: 2)
      item_2.invoice_items.create!(invoice_id: invoice.id, quantity: 3, unit_price: 4, status: 2)
      item_3.invoice_items.create!(invoice_id: invoice.id, quantity: 3, unit_price: 4, status: 2)
      expect(invoice.total_revenue).to eq(36)
    end
  end
end
