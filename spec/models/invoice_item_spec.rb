require 'rails_helper'

RSpec.describe InvoiceItem do
  before :each do
    @merchant = Merchant.create!(name: "Frank's Pudding",
                           created_at: Time.parse('2012-03-27 14:53:59 UTC'),
                           updated_at: Time.parse('2012-03-27 14:53:59 UTC'))

    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson",
                                 created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                 updated_at: Time.parse('2012-03-27 14:54:09 UTC'))

    @invoice = @customer.invoices.create!(status: 'in progress',
                                      created_at: Time.parse("2012-03-17 17:54:13 UTC"),
                                      updated_at: Time.parse("2012-03-17 17:54:13 UTC"))

    @item = @merchant.items.create!(name: 'Chocolate Delight', unit_price: 500,
                             description: 'tastiest chocolate pudding on the east coast',
                              created_at: Time.parse('2012-03-27 14:53:59 UTC'),
                              updated_at: Time.parse('2012-03-27 14:53:59 UTC'))

    @invoice_item = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item.id,
                                            status: 'in progress', quantity: 9, unit_price: 13232,
                                        created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                        updated_at: Time.parse('2012-03-27 14:54:09 UTC'))
  end

  context 'readable attributes' do
    it 'has a status' do
      expect(@invoice_item.status).to eq('in progress')
    end
  end

 context 'validations' do
   it { should validate_presence_of :quantity }
   it { should validate_presence_of :unit_price }
   it { should validate_presence_of :status }
 end

  context 'relationships' do
    it { should belong_to :item}
    it { should belong_to :invoice}
  end
end
