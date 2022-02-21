require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  it "exists" do
    invoice = create(:invoice)
    expect(invoice).to be_a(Invoice)
    expect(invoice).to be_valid
  end
end
