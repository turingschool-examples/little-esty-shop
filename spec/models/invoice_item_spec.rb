require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  before :each do
    @billman = Merchant.create!(name: "Billman", created_at: Time.now, updated_at: Time.now)
    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001, created_at: Time.now, updated_at: Time.now)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka", created_at: Time.now, updated_at: Time.now)
    @invoice_1 = @customer_1.invoices.create!(status: "cancelled", created_at: Time.now, updated_at: Time.now)
    @invoice_items_1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice_1.id, created_at: Time.now, updated_at: Time.now)
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'validations' do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "instance methods" do
    it "converts unit price into dollar format" do
      expect(@invoice_items_1.price_convert).to eq(10.01)
    end 
  end
end
