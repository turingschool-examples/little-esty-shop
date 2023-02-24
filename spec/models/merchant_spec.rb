require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoices).through(:items)}
    it { should have_many(:invoice_items).through(:items) }
  end

  let!(:this_gai_ovah_hea) { Customer.create!(first_name: "Dis", last_name: "Gai") }
  let!(:invoice1) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice2) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 
  let!(:invoice3) { Invoice.create!(customer_id: this_gai_ovah_hea.id) } 

  let!(:sam) { Merchant.create!(name: "Sam's Sports") }
  let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
  let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
  let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }

  before (:each) do
    InvoiceItem.create!(invoice_id: invoice1.id, item_id: football.id, status: 0)
    InvoiceItem.create!(invoice_id: invoice1.id, item_id: baseball.id, status: 1)
    InvoiceItem.create!(invoice_id: invoice2.id, item_id: glove.id, status: 2)
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
      expect(sam.items_not_yet_shipped).to eq([["Football", invoice1.id] , ["Baseball", invoice1.id]])
    end
  end
end
