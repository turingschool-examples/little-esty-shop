require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe "validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  it "exists" do
    invoice_item = create(:invoice_item)
    expect(invoice_item).to be_a(InvoiceItem)
    expect(invoice_item).to be_valid
  end
end
