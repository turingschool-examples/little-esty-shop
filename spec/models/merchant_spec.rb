require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do 
    it { should have_many :items}
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices)}
    it { should define_enum_for(:status).with_values(["enabled", "disabled"]) }
  end

  describe '#toggle_status' do
    it 'changes merchant status to disabled if currently enabled and the inverse' do
      @merchant_1 = Merchant.create!(name: "Merchy")
      expect(@merchant_1.status).to eq("enabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("disabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("enabled")
    end
  end
end
