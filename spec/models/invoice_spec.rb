require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @billman = Merchant.create!(name: "Billman")

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka")

    @invoice_1 = @customer_1.invoices.create!(status: "cancelled", created_at: Time.now - 1.days)
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled", created_at: Time.now - 2.days)
    @invoice_3 = @customer_1.invoices.create!(status: "cancelled", created_at: Time.now - 3.days)

    @invoice_items_1 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "pending", invoice_id: @invoice_1.id)
    @invoice_items_2 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "pending", invoice_id: @invoice_1.id)
    @invoice_items_3 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "shipped", invoice_id: @invoice_2.id)
    @invoice_items_4 = @mood.invoice_items.create!(quantity: 1, unit_price: 2002, status: "packaged", invoice_id: @invoice_3.id)
    @invoice_items_5 = @bracelet.invoice_items.create!(quantity: 1, unit_price: 1001, status: "shipped", invoice_id: @invoice_3.id)
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many :transactions}
  end

  describe 'validations' do
    it {should validate_presence_of(:status)}

  end

  describe 'instance methods' do
    it "can give total revenue for invoice" do
      expect(@invoice_1.total_revenue).to eq(30.03)
    end

    it "determines incomplete invoices" do
      expect(@invoice_1.incomplete?).to eq(true)
      expect(@invoice_2.incomplete?).to eq(false)
      expect(@invoice_3.incomplete?).to eq(true)
    end

    it "can order invoices by date desc" do
      expect(Invoice.oldest_first).to eq([@invoice_3,@invoice_2, @invoice_1])
    end
  end
end
