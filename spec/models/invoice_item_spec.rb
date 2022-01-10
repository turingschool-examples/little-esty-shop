require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let!(:merchant_1) {FactoryBot.create(:merchant)}

  let!(:item_1) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_4) {FactoryBot.create(:item, merchant: merchant_1)}
  
  let!(:invoice_1) {FactoryBot.create(:invoice)}

  let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, credit_card_expiration_date: Date.today, result: 0)}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, quantity: 100, unit_price: 200, item: item_1, invoice: invoice_1)}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, item: item_2)}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, item: item_3)}
  let!(:invoice_item_4) {FactoryBot.create(:invoice_item, item: item_4)}
  
  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "validations" do
    it { should validate_presence_of(:item) }
    it { should validate_presence_of(:invoice) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
  end 
end
