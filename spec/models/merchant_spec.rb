require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through :items }
    it { should have_many(:invoices).through :invoice_items }
    it { should have_many(:customers).through :invoices }
    it { should have_many(:transactions).through :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it '#top_five_by_successful_transaction_count' do
    end
  end
end
