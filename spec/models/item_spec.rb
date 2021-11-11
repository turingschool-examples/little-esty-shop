require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  before(:each) do
      @merchant1 = Merchant.create!(name: 'Willms and Sons')
      @merchant2 = Merchant.create!(name: 'John Jacob J')
      @item1 = @merchant1.items.create!(name: "Item 1", description: "An item", unit_price: 1300, status:0)
      @item2 = @merchant1.items.create!(name: "Item 2", description: "Another item", unit_price: 1200, status: 1)
      @item3 = @merchant2.items.create!(name: "Item 3", description: "Another other item", unit_price: 1240, status:1)
    end

    it ".disabled_items" do
      expect(Item.disabled_items).to eq([@item2, @item3])
    end
end
