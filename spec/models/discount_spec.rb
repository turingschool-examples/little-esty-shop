require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "Relationships" do
    it { should belong_to(:merchant) }
  end

  describe "Validations" do
    it { should validate_presence_of(:quantity_threshold) }
    it { should validate_presence_of(:percentage_discount) }
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)


    @merchant_2 = create(:merchant)
    @item_2 = create(:item, merchant: @merchant_2)


    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)
    @discount_3 = create(:discount, merchant: @merchant_2)
  end
  describe 'Class methods' do
    describe '.avaliable_discounts' do
      it 'filters an array of avaliable discounts for that item, by merchant' do
        discounts = Discount.all
        expect(discounts.avaliable_discounts(@item_2)).to eq([@discount_3])
      end
    end

  end
end