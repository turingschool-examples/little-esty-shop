require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :name }
  end

  it 'exists' do
    merchant = create(:merchant)
    expect(merchant).to be_a(Merchant)
    expect(merchant).to be_valid
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
end
