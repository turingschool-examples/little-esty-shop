require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :unit_price}
    it {should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0)}
  end

  it 'is created with status enabled when not provided' do
    cool = Merchant.create!(name: "Cool Beans")
    red = cool.items.create!(
            name: "Red Paint",
            description: "2 oz of red acrylic paint",
            unit_price: 8.99)

    expect(red.status).to eq("enabled")
  end

  it 'can have status disabled' do
    cool = Merchant.create!(name: "Cool Beans")
    red = cool.items.create!(
            name: "Red Paint",
            description: "2 oz of red acrylic paint",
            unit_price: 8.99)
    red.update!(status: :disabled)

    expect(red.status).to eq("disabled")
  end
end
