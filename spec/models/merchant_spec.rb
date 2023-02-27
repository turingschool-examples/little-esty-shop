require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:items) }
  end

  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id, created_at: Date.yesterday) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id,  created_at: Date.tomorrow) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

  let!(:sam) { Merchant.create!(name: "Sam's Sports") }
  let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000, status: 0) }
  let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500, status: 0) }
  let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000, status: 1) }

  before (:each) do
    @football_inv = InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id, status: 0)
    @baseball_inv = InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id, status: 1)
    @glove_inv = InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id, status: 2)
  end

  describe 'instance methods' do
    it '#merchant_invoices' do
      expect(sam.merchant_invoices).to eq([invoice1, invoice2])
      expect(sam.merchant_invoices).to_not eq([invoice1, invoice1, invoice2])

      cleats = sam.items.create!(name: "Cleats", description: "These are cleats", unit_price: 7500)
      InvoiceItem.create!(invoice_id: invoice3.id, item_id: cleats.id)

      expect(sam.merchant_invoices).to eq([invoice1, invoice2, invoice3])
    end

    it '#items_not_yet_shipped' do 
      expect(sam.items_not_yet_shipped).to eq([@football_inv, @baseball_inv])
    end

    it '#enabled_items' do
      expect(sam.enabled_items).to eq([football, baseball])
    end

    it '#disabled_items' do 
      expect(sam.disabled_items).to eq([glove])
    end
  end
end
