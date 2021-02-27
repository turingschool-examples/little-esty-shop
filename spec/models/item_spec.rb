require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "instance methods" do
    it "#disable_item" do
      @merchant1 = create(:merchant)

      @item = create(:item, merchant_id: @merchant1.id)
      @item.disable_item
      expect(@item.status).to be false
    end
  end
end
