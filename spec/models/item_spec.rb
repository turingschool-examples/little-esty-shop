require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  it 'can update item status' do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)

    @item_1.status_update(1)
    expect(@item_1.status).to eq('enabled')
  end
end