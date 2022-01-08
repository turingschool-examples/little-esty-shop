require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchant).through(:items) }
  end

  it '#total_revenue' do
    expect(@invoice_1.total_revenue).to eq(16)
    expect(@invoice_2.total_revenue).to eq(23)
  end
end
