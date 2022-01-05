require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it 'reports a merchants invoices' do
      merchant1 = create(:merchant)
      invoice1 = create(:invoice)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      expect(merchant1.invoice_finder).to eq [invoice1]
    end
  end
end
