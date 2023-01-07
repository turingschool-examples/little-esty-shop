require 'rails_helper'

RSpec.describe Invoice do
  before :each do
    FactoryBot.reload
  end

  describe "Relationships" do
    it {should belong_to :customer} 
    it {should have_many :transactions} 
    it {should have_many :invoice_items} 
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'class methods' do
    describe '#incomplete' do
      it "returns invoices with items that haven't yet shipped" do
        pending_invoice  = FactoryBot.create(:invoice_with_invoice_item, invoice_item_status: 0)
        packaged_invoice = FactoryBot.create(:invoice_with_invoice_item, invoice_item_status: 1)
        shipped_invoice  = FactoryBot.create(:invoice_with_invoice_item, invoice_item_status: 2)

        expect(Invoice.incomplete).to include(pending_invoice)
        expect(Invoice.incomplete).to include(packaged_invoice)
        expect(Invoice.incomplete).to_not include(shipped_invoice)
      end
    end
  end

  describe 'instance methods' do
    describe '.created' do
      it 'returns created_at in a readable format' do
        invoice = FactoryBot.create(:invoice, created_at: Time.new(1963, 11, 23))

        expect(invoice.created).to eq("Saturday, November 23, 1963")
      end
    end
  end
end