require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  before :each do
    # enabled
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    # disabled
    @merchant3 = Merchant.create!(name: "Bob", status: 0)
  end

  describe 'class methods' do
    describe '.enabled' do
      it "returns merchants with an enable status" do
        expect(Merchant.enabled).to eq([@merchant1, @merchant2])
        expect(Merchant.enabled).to_not eq([@merchant3])
      end
    end

    describe '.disabled' do
      it "returns merchants with an disable status" do
        expect(Merchant.disabled).to eq([@merchant3])
        expect(Merchant.disabled).to_not eq([@merchant1, @merchant2])
      end
    end

    describe '.new_mechant_id' do
      it "returns merchants with an disable status" do
        expect(Merchant.new_mechant_id).to eq(Merchant.all.last.id + 1)
        expect(Merchant.new_mechant_id).to_not eq(Merchant.all.last)
      end
    end
  end

  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
