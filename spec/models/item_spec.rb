require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'associations' do
    it {should have_many :invoice_items}
    it {should belong_to :merchant}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_numericality_of(:unit_price).only_integer }
    it {should validate_numericality_of(:unit_price).is_greater_than(0)}
    it { should define_enum_for(:status).with([:enabled, :disabled])}
  end

  describe 'default' do
    it 'has a default of enabled' do
      merchant = Merchant.create!(name: "Sam's Toys")
      item = merchant.items.create!(name: "Potato gun", description: "Shoots potatoes", unit_price: 1800)

      expect(item.status).to eq("enabled")
    end
  end

end
