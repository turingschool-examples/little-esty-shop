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

  it "tests incomplete" do
    merchant1 = Merchant.create!(name: "The Tornado")
    item1 = merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    item2 = merchant1.items.create!(name: "FunPans", description: "Cha + 20", unit_price: 2000)
    item3 = merchant1.items.create!(name: "FitPants", description: "Con + 20", unit_price: 150)
    customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    customer2 = Customer.create!(first_name: "Larky", last_name: "Lark" )
    customer3 = Customer.create!(first_name: "Sparky", last_name: "Spark" )
    customer4 = Customer.create!(first_name: "Farky", last_name: "Fark" )
    invoice1 = customer1.invoices.create!(status: 0)
    invoice2 = customer2.invoices.create!(status: 0)
    invoice3 = customer3.invoices.create!(status: 0)
    invoice4 = customer4.invoices.create!(status: 2)
    invoice5 = customer4.invoices.create!(status: 1)

    invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 125, status: 0)
    invoice_item3 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 5, unit_price: 125, status: 0)
    invoice_item4 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item1.id, quantity: 2, unit_price: 125, status: 1)

    invoice_item5 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 2, unit_price: 2000, status: 1)

    invoice_item6 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item3.id, quantity: 1, unit_price: 125, status: 2)
    invoice_item7 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item2.id, quantity: 1, unit_price: 2000, status: 2)

    invoice_item9 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: item2.id, quantity: 1, unit_price: 2000, status: 2)


    expect(Invoice.incomplete).to include(invoice_item1)
    expect(Invoice.incomplete).to include(invoice_item3)
    expect(Invoice.incomplete).to include(invoice_item4)
    expect(Invoice.incomplete).to include(invoice_item5)
    expect(Invoice.incomplete).to_not include(invoice_item6)
    expect(Invoice.incomplete).to_not include(invoice_item7)
    expect(Invoice.incomplete).to_not include(invoice_item9)
  end
end
