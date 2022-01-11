require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:merchant_1) {FactoryBot.create(:merchant)}
  let!(:merchant_2) {FactoryBot.create(:merchant)}

  let!(:item_1) {FactoryBot.create(:item, merchant: merchant_1, unit_price: 200)}
  let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1, unit_price: 100)}
  let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1, unit_price: 300)}
  let!(:item_4) {FactoryBot.create(:item, merchant: merchant_2, unit_price: 400)}

  let!(:invoice_1) {FactoryBot.create(:invoice)}

  let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, credit_card_expiration_date: Date.today, result: 0)}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, quantity: 100, unit_price: 200, item: item_1, invoice: invoice_1, status: 0)}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, quantity: 50, unit_price: 100, item: item_2, invoice: invoice_1, status:0)}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, item: item_3)}
  let!(:invoice_item_4) {FactoryBot.create(:invoice_item, item: item_4)}
  
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:merchant) }
    it { should validate_numericality_of(:unit_price) }
    it { should define_enum_for(:status).with_values(disabled: 0,enabled: 1) }
  end 
  
  describe 'instance methods' do 
    it 'can return the quantity of the item on an invoice' do 
      expect(item_1.invoice_item_quantity(invoice_1)).to eq(100)
    end

    it 'can return the unit price of the item on an invoice' do 
      expect(item_1.invoice_item_unit_price(invoice_1)).to eq(200)
    end

    it 'can return the status of the item on an invoice' do 
      expect(item_1.invoice_item_status(invoice_1)).to eq("pending")
    end
  end

  describe '#date_created' do
    it 'returns the date created of an items invoice and formats it' do
      expect(invoice_item_1.item.date_created).to eq(invoice_item_1.invoice.created_at.strftime("%A, %B %-d, %Y"))
    end
  end
end
