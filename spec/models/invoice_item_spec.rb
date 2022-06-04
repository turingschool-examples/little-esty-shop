require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  before :each do
    @billman = Merchant.create!(name: "Billman")
    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka")
    @invoice_1 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_items_1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice_1.id)

    @parker = Merchant.create!(name: "Parker's Perfection Pagoda")

  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'validations' do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:status)}

  end

  describe "instance methods" do
    it "converts unit price into dollar format" do
      expect(@invoice_items_1.price_convert).to eq(10.01)
    end

    it 'belongs to merchant returns true if an invoice item belongs to the given merchant' do

      expect(@invoice_items_1.belongs_to_merchant(@billman)).to eq(true)
    end

    it 'belongs to merchant returns false if an invoice item does not belong to the given merchant' do

      expect(@invoice_items_1.belongs_to_merchant(@parker)).to eq(false)
    end
  end
end
