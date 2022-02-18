require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  it 'exists' do
    ii = create(:invoice_item)

    expect(ii).to be_a(InvoiceItem)
    expect(ii).to be_valid
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:transactions).through(:invoice)}
  end
end
