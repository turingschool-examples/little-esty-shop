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
    it '.formatted_date returns the date in day, month, year format' do
      expect(@invoice.formatted_date).to eq("Sunday, March 25, 2012")
    end

    it '.get_invoice_item(id) returns a specific invoice item' do
      expect(@invoice.get_invoice_item(@item_1.id)).to eq(@invoice_item_1)
      expect(@invoice.get_invoice_item(@item_2.id)).to eq(@invoice_item_2)
    end
  end
end
