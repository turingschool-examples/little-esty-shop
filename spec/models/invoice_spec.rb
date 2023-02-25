require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to :customer }
  it { should have_many :invoice_items }
  it { should have_many :items }

  describe "Instance methods" do
    
  end

  describe "Class methods" do
    let!(:merchant) { Merchant.create!(name: "Smiling Mask Merchant") }

    let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }

    let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
    let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

    let!(:item1) { Item.create!(name: "Bleach", description: "Made for consumption", unit_price: 200, merchant_id: merchant.id) } 
    let!(:item2) { Item.create!(name: "Kool-Aid", description: "DO NOT CONSUME", unit_price: 20000, merchant_id: merchant.id) } 
    let!(:item4) { Item.create!(name: "Loofah", description: "It Loofs", unit_price: 66600, merchant_id: merchant.id) } 


    before do
      InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 30, unit_price: 336, status: 0)
      InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 6, unit_price: 34571, status: 2)
      InvoiceItem.create!(invoice: invoice2, item: item4, quantity: 500, unit_price: 66666, status: 1)
    end

    it "#find_invoiceitem_quantity" do
      expect(Invoice.find_invoiceitem_quantity(invoice1, item1)).to eq(30)
      expect(Invoice.find_invoiceitem_quantity(invoice1, item2)).to eq(6)
      expect(Invoice.find_invoiceitem_quantity(invoice2, item4)).to eq(500)
    end

    it "#find_invoiceitem_unitprice" do
      expect(Invoice.find_invoiceitem_unitprice(invoice1, item1)).to eq(336)
      expect(Invoice.find_invoiceitem_unitprice(invoice1, item2)).to eq(34571)
      expect(Invoice.find_invoiceitem_unitprice(invoice2, item4)).to eq(66666)
    end

    it "#find_invoiceitem_status" do
      expect(Invoice.find_invoiceitem_status(invoice1, item1)).to eq("pending")
      expect(Invoice.find_invoiceitem_status(invoice1, item2)).to eq("shipped")
      expect(Invoice.find_invoiceitem_status(invoice2, item4)).to eq("packaged")
    end

  end
end
