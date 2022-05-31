require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @billman = Merchant.create!(name: "Billman", created_at: Time.now, updated_at: Time.now)
    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001, created_at: Time.now, updated_at: Time.now)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002, created_at: Time.now, updated_at: Time.now)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka", created_at: Time.now, updated_at: Time.now)
    @invoice_1 = @customer_1.invoices.create!(status: "cancelled", created_at: Time.now, updated_at: Time.now)
    @invoice_items_1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "Pending", invoice_id: @invoice_1.id, created_at: Time.now, updated_at: Time.now)
    @invoice_items_2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "Pending", invoice_id: @invoice_1.id, created_at: Time.now, updated_at: Time.now)

  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many :transactions}
  end

  describe 'validations' do
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe 'instance methods' do
    it "can give total revenue for invoice" do
      expect(@invoice_1.total_revenue).to eq(30.03)
    end
  end

end
