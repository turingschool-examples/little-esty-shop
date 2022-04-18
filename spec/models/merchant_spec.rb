require "rails_helper"
#   it "text" do
#     merchant = create(:merchant, enabled: false)  can control attributes by adding them in here after comma
#     merchants = create_list(:merchant, 5, merchant: merchant)
#     # item1 = create(:item, merchant: merchant)  to create one instance
#     # items = create_list(:item, 5, merchant: merchant) ==> creates multiple instances relationship for item belongs_to merchant.  Automatically assigns foreign key to that merchant
#     require "pry"; binding.pry
#   end
# end
RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should allow_value([true, false]).for(:enabled) }
    it { should_not allow_value(nil).for(:enabled) }
  end

  describe "methods" do
    it 'Finds all enabled or disabled merchants' do
      merchant_1 = create(:merchant)
      merchant_2 = Merchant.create!(name: "Doesn't matter", enabled: false)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)

      expect(Merchant.enabled_check(true)).to eq([merchant_1, merchant_3, merchant_4])
      expect(Merchant.enabled_check(false)).to eq([merchant_2])
    end

    it 'Shows total revenue for a merchant' do
      merchant_1 = create(:merchant)
      item_1 = Item.create!(name: "Gloomhaven", description: "Lorem ipsum", unit_price: 5, enabled: 0, merchant_id: merchant_1.id)
      customer_1 = create(:customer)
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 4, unit_price: item_1.unit_price)

      expect(merchant_1.total_revenue).to eq(20)
    end

    it 'Displays top 5 highest revenue merchants' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      merchant_5 = create(:merchant)
      merchant_6 = create(:merchant)
  
      customer_1 = create(:customer)
      customer_2 = create(:customer)
  
      item_1 = Item.create!(name: "Gloomhaven", description: "Lorem ipsum", unit_price: 5, enabled: 0, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Frosthaven", description: "Lorem ipsum 2", unit_price: 7, enabled: 0, merchant_id: merchant_2.id)
      item_3 = Item.create!(name: "Monopoly", description: "The worst board game", unit_price: 4, enabled: 0, merchant_id: merchant_3.id)
      item_4 = Item.create!(name: "Mysterium", description: "Lorem ipsum 4", unit_price: 4, enabled: 0, merchant_id: merchant_4.id)
      item_5 = Item.create!(name: "Apocrypha", description: "Lorem ipsum 5", unit_price: 8, enabled: 0, merchant_id: merchant_5.id)
      item_6 = Item.create!(name: "Zombicide", description: "Lorem ipsum 6", unit_price: 6, enabled: 0, merchant_id: merchant_6.id)
  
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 2)
  
      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 4, unit_price: item_1.unit_price)
      invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 5, unit_price: item_2.unit_price)
      invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 8, unit_price: item_3.unit_price)
      invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_4.id, quantity: 4, unit_price: item_4.unit_price)
      invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_5.id, quantity: 3, unit_price: item_5.unit_price)
      invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_6.id, quantity: 3, unit_price: item_6.unit_price)

      expect(Merchant.top_sellers).to eq([merchant_2, merchant_3, merchant_5, merchant_1, merchant_6])
    end
  end
      
end
