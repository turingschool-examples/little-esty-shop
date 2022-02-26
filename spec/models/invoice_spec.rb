require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :status }
  end

  it 'exists' do
    invoice = create(:invoice)
    expect(invoice).to be_a(Invoice)
    expect(invoice).to be_valid
  end

  describe 'relationships' do
    it { should belong_to(:customer)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions)}
  end

  it "tests the total_revenue" do
    @merchant1 = Merchant.create!(name: "The Tornado")
    @item1 = @merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    @customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, unit_price: 125, status: 1)

    expect(@invoice1.total_revenue).to eq(125)
  end

  describe 'class methods' do
    it "gives invoices listed by oldest first" do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      invoice3 = create(:invoice)

      expect(Invoice.all_oldest_first).to eq([invoice1, invoice2, invoice3])
    end
  end
end
