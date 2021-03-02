require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
  end

  describe "Class methods" do
    before (:each) do
      @merchant = create(:merchant)

      @item1 = create(:item, merchant: @merchant, status: "enabled")
      @item2 = create(:item, merchant: @merchant, status: "enabled")

      @item3 = create(:item, merchant: @merchant, status: "disabled")
      @item4 = create(:item, merchant: @merchant, status: "disabled")
    end

    describe "::enabled_items" do
      it "lists all of the enabled items" do
        expected = [@item1, @item2]
        
        expect(Item.enabled_items).to eq(expected)
      end
    end

    describe "::disabled_items" do
      it "lists all of the disabled items" do
        expected = [@item3, @item4]
        
        expect(Item.disabled_items).to eq(expected)
      end
    end
  end
end
