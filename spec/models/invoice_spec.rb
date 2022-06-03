require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values(["in progress", "completed", "cancelled"])}
  end

  let!(:merchant1) { create(:merchant) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }

  let!(:customer1) { create(:customer) }

  let!(:invoice1) { create(:invoice, customer: customer1) }

  let!(:transaction1) { create(:transaction, invoice: invoice1, result: 1) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524) }

  describe "#instance methods" do
    it "#total_revenue returns total revenue of an invoice" do
      expect(invoice1.total_revenue).to eq("$55.35")
    end
  end
end
