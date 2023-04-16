require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "class methods" do
    before(:each) do
      @merchant_1 = create(:merchant, name: "Z", is_enabled: true)
      @merchant_2 = create(:merchant, name: "A", is_enabled: true)
      @merchant_3 = create(:merchant, name: "Z")
      @merchant_4 = create(:merchant, name: "A")
    end

    describe ".all_enabled" do
      it 'returns a list of all enabled merchants sorted by name A-Z' do
        expect(Merchant.all_enabled).to eq([@merchant_2, @merchant_1])
      end
    end

    describe ".all_disabled" do
      it 'returns a list of all disabled merchants sorted by name A-Z' do
        expect(Merchant.all_disabled).to eq([@merchant_4, @merchant_3])
      end
    end
  end

  describe "instance methods" do
    describe "#enabled_status" do
      it "returns enabled if is_enabled is true" do
        merchant = create(:merchant, is_enabled: true)
        expect(merchant.enabled_status).to eq("Enabled")
      end
      it "returns disabled if is_enabled is false" do
        merchant = create(:merchant, is_enabled: false)
        expect(merchant.enabled_status).to eq("Disabled")
      end
    end
  end
end
