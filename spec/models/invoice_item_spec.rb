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

  it 'instantiates without parents' do
    inv_item = create(:invoice_item)
    #calling parents: inv_item.invoice.customer
    #calling parents: inv_item.item.merchant
  end

  describe "class methods" do
    describe "#unshipped_invoice_items" do
      it 'returns all invoice items with a status of pending or packaged' do
        inv_items_pending = create_list(:invoice_item, 5, status: 0)
        inv_items_packaged = create_list(:invoice_item, 5, status: 1)
        inv_items_shipped = create_list(:invoice_item, 5, status: 2)
        all_inv_items = InvoiceItem.all
        
        all_inv_items.unshipped_invoice_items.each do |ii|
          expect(ii.status).to_not eq("Shipped")
        end
        expect(InvoiceItem.unshipped_invoice_items.count).to eq(10)
      end
    end
  end
end