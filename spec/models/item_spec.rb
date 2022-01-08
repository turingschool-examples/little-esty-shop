require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
  end

  it '#top_item_best_day' do
    expect(@item_7.invoice_items.first.quantity).to eq(@item_7.invoice_items.second.quantity)
    expect(@item_7.top_item_best_day).to eq(@item_7.invoices.first.updated_at)
  end
end
