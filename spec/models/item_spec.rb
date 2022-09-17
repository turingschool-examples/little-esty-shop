require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  before :each do
    # @merchant_1 = create(:merchant)
    @items_1 = create_list(:item, 3)
    @items_2 = create_list(:item, 3, active_status: :disabled)
  end

  describe "Class Methods" do
    it "#active" do
      expect(Item.active).to eq([@items_1[0], @items_1[1], @items_1[2]])
    end

    it "#inactive" do
      expect(Item.inactive).to eq([@items_2[0], @items_2[1], @items_2[2]])
    end
  end
end
