require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'valdiations' do
    it { should validate_presence_of :name}
  end

  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }
  let!(:item3) { create(:item, merchant: merchant1) }
  let!(:item4) { create(:item, merchant: merchant2) }
  let!(:item5) { create(:item, merchant: merchant2) }

  let!(:customers1) { create(:customer) }
  let!(:customers2) { create(:customer) }
  let!(:customers3) { create(:customer) }
  let!(:customers4) { create(:customer) }
  let!(:customers5) { create(:customer) }
  let!(:customers6) { create(:customer) }

  let!(:invoice1) { create(:invoice, customer: customer1) }
  let!(:invoice2) { create(:invoice, customer: customer2) }
  let!(:invoice3) { create(:invoice, customer: customer3) }
  let!(:invoice4) { create(:invoice, customer: customer4) }
  let!(:invoice5) { create(:invoice, customer: customer5) }
  let!(:invoice6) { create(:invoice, customer: customer6) }

  let!(:transactions1) { create(:transaction, invoice: invoice1, result: 0) }
  let!(:transactions2) { create(:transaction, invoice: invoice2, result: 0) }
  let!(:transactions3) { create(:transaction, invoice: invoice3, result: 0) }
  let!(:transactions4) { create(:transaction, invoice: invoice4, result: 0) }
  let!(:transactions5) { create(:transaction, invoice: invoice5, result: 0) }
  let!(:transactions6) { create(:transaction, invoice: invoice6, result: 1) }
  let!(:transactions7) { create(:transaction, invoice: invoice1, result: 0) }
  let!(:transactions8) { create(:transaction, invoice: invoice2, result: 0) }
  let!(:transactions9) { create(:transaction, invoice: invoice3, result: 0) }
  let!(:transactions10) { create(:transaction, invoice: invoice4, result: 0) }
  let!(:transactions11) { create(:transaction, invoice: invoice5, result: 0) }
  let!(:transactions12) { create(:transaction, invoice: invoice6, result: 1) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1) }
  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1) }
  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1) }
  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1) }


  describe '#instance methods' do
    it 'returns top 5 customers' do

    expect()

    end
  end
end
