require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity)}
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values(["Pending", "Packaged", "Shipped"])}
  end

  describe 'relationships' do
    it { should belong_to :item}
    it { should belong_to :invoice}
  end

  it 'instantiates with factorybot' do
    customer = create(:customer)
    merchant = create(:merchant)
    item = merchant.items.create(attributes_for(:item))
    invoice = customer.invoices.create(attributes_for(:invoice))
    inv_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)
  end

end