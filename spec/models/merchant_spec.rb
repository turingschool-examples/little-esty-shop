require "rails_helper"

RSpec.describe Merchant do
  describe "relationships" do
    it {should have_many :items}
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :status}
  end

  describe "class methods" do
    describe "#enabled?" do
      it 'returns all merchants that are enabled' do
        merchant1 = Merchant.create!(name: "Abe")
        merchant2 = Merchant.create!(name: "Bel", status: :enabled)
        merchant3 = Merchant.create!(name: "Cat", status: :disabled)

        expect(Merchant.enabled?).to eq([merchant1, merchant2])
      end
    end
    describe "#disabled?" do
      it 'returns all merchants that are disabled' do
        merchant1 = Merchant.create!(name: "Abe")
        merchant2 = Merchant.create!(name: "Bel", status: :enabled)
        merchant3 = Merchant.create!(name: "Cat", status: :disabled)
        merchant4 = Merchant.create!(name: "Dap", status: :disabled)

        expect(Merchant.disabled?).to eq([merchant3, merchant4])
      end
    end
  end
end