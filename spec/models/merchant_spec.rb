require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'valdiations' do
    it { should validate_presence_of :name}
    it {should define_enum_for(:status).with_values(["disabled", "enabled"])}
  end

  let!(:merchants) { create_list(:merchant, 2) }
  let!(:customers) { create_list(:customer, 6) }

  before :each do
    @items = merchants.flat_map do |merchant|
      create_list(:item, 2, merchant: merchant)
    end

    @invoices = customers.flat_map do |customer|
      create_list(:invoice, 2, customer: customer)
    end

    @transactions = @invoices.each_with_index.flat_map do |invoice, index|
      if index < 2
        create_list(:transaction, 2, invoice: invoice, result: 1)
      else
        create_list(:transaction, 2, invoice: invoice, result: 0)
      end
    end
  end
  let!(:invoice_item1) { create(:invoice_item, item: @items[0], invoice: @invoices[0], status: 0) }
  let!(:invoice_item2) { create(:invoice_item, item: @items[1], invoice: @invoices[1], status: 1) }
  let!(:invoice_item3) { create(:invoice_item, item: @items[0], invoice: @invoices[2], status: 1) }
  let!(:invoice_item4) { create(:invoice_item, item: @items[1], invoice: @invoices[3], status: 0) }
  let!(:invoice_item5) { create(:invoice_item, item: @items[0], invoice: @invoices[4], status: 0) }
  let!(:invoice_item6) { create(:invoice_item, item: @items[1], invoice: @invoices[5], status: 1) }
  let!(:invoice_item7) { create(:invoice_item, item: @items[0], invoice: @invoices[6], status: 1) }
  let!(:invoice_item8) { create(:invoice_item, item: @items[1], invoice: @invoices[7], status: 1) }
  let!(:invoice_item9) { create(:invoice_item, item: @items[0], invoice: @invoices[8], status: 1) }
  let!(:invoice_item10) { create(:invoice_item, item: @items[1], invoice: @invoices[9], status: 0) }
  let!(:invoice_item11) { create(:invoice_item, item: @items[0], invoice: @invoices[10], status: 2) }
  let!(:invoice_item12) { create(:invoice_item, item: @items[1], invoice: @invoices[11], status: 2) }

  describe ".class methods" do
    let!(:merchant1) { create(:merchant, status: 0) }
    let!(:merchant2) { create(:merchant, status: 1) }
    let!(:merchant3) { create(:merchant, status: 0) }
    let!(:merchant4) { create(:merchant, status: 1) }

    it ".enabled returns only merchants with an enabled status" do
      # enums method
      expect(Merchant.enabled).to include(merchant2)
      expect(Merchant.enabled).to include(merchant4)
      expect(Merchant.enabled).to_not include(merchant1)
      expect(Merchant.enabled).to_not include(merchant3)
    end

    it ".disabled returns only merchants with a disabled status" do
      # enums method
      expect(Merchant.disabled).to include(merchant1)
      expect(Merchant.disabled).to include(merchant3)
      expect(Merchant.disabled).to_not include(merchant2)
      expect(Merchant.disabled).to_not include(merchant4)
    end

    it 'returns top five merchants by revenue' do 
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      merchant5 = create(:merchant)
      merchant6 = create(:merchant)
    
      customer = create(:customer)
    
      item1 = create(:item, merchant: merchant1, status: 0)
      item2 = create(:item, merchant: merchant2, status: 0)
      item3 = create(:item, merchant: merchant3, status: 0)
      item4 = create(:item, merchant: merchant4, status: 0)
      item5 = create(:item, merchant: merchant5, status: 0)
      item6 = create(:item, merchant: merchant6, status: 0)
    
    
      invoice1 = create(:invoice, customer: customer, created_at: "2012-03-10 00:54:09 UTC")
      invoice2 = create(:invoice, customer: customer, created_at: "2013-03-10 00:54:09 UTC")
      invoice3 = create(:invoice, customer: customer, created_at: "2014-03-10 00:54:09 UTC")
    
    
      transaction1 = create(:transaction, invoice: invoice1, result: 1)
      transaction2 = create(:transaction, invoice: invoice1, result: 1)
      transaction3 = create(:transaction, invoice: invoice2, result: 0)
      transaction4 = create(:transaction, invoice: invoice2, result: 1)
      transaction5 = create(:transaction, invoice: invoice3, result: 0)
      transaction6 = create(:transaction, invoice: invoice3, result: 0)
    
    
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item: item1, invoice: invoice3, quantity: 6, unit_price: 4)
      invoice_item3 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 3, unit_price: 200)
      invoice_item4 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 22, unit_price: 200)
      invoice_item5 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 5, unit_price: 300)
      invoice_item6 = create(:invoice_item, item: item3, invoice: invoice1, quantity: 63, unit_price: 400)
      invoice_item7 = create(:invoice_item, item: item4, invoice: invoice2, quantity: 16, unit_price: 500)
      invoice_item8 = create(:invoice_item, item: item4, invoice: invoice3, quantity: 1, unit_price: 500)
      invoice_item9 = create(:invoice_item, item: item5, invoice: invoice2, quantity: 2, unit_price: 500)
      invoice_item10 = create(:invoice_item, item: item5, invoice: invoice1, quantity: 7, unit_price: 200)
      invoice_item11 = create(:invoice_item, item: item6, invoice: invoice3, quantity: 1, unit_price: 100)
      invoice_item12 = create(:invoice_item, item: item6, invoice: invoice3, quantity: 1, unit_price: 250)
    
      expect(Merchant.top_5).to eq([merchant3, merchant4, merchant2, merchant5, merchant1])
      expect(Merchant.top_5).to_not eq(merchant6)
    end
  end

  describe '#instance methods' do
    it 'returns top 5 customers' do
      # this fails like once out of every 20 tests...
      # I think it might be because if the transaction count is the same...
      # it doesn't have an explicit order...should we also order by name? how would we test for that?
      expect(merchants[0].top_5_customers).to eq(customers[1..5])
    end

    it 'returns item names ordered, not shipped' do
      expect(merchants[0].ordered_not_shipped).to eq([
        invoice_item1,
        invoice_item2,
        invoice_item3,
        invoice_item4,
        invoice_item5,
        invoice_item6,
        invoice_item7,
        invoice_item8,
        invoice_item9,
        invoice_item10
        ])#item and item invoice number
    end
  end

  
  xit "#best_day returns the merchants best selling day" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    merchant5 = create(:merchant)
    
    customer = create(:customer)
    
    item1 = create(:item, merchant: merchant1, status: 0)
    item2 = create(:item, merchant: merchant2, status: 0)
    item3 = create(:item, merchant: merchant3, status: 0)
    item4 = create(:item, merchant: merchant4, status: 0)
    item5 = create(:item, merchant: merchant5, status: 0)
    
    
    invoice1 = create(:invoice, customer: customer, created_at: "2012-03-10 00:54:09 UTC")
    invoice2 = create(:invoice, customer: customer, created_at: "2013-03-10 00:54:09 UTC")
    invoice3 = create(:invoice, customer: customer, created_at: "2014-03-10 00:54:09 UTC")
    
    
    transaction1 = create(:transaction, invoice: invoice1, result: 1)
    transaction2 = create(:transaction, invoice: invoice1, result: 1)
    transaction3 = create(:transaction, invoice: invoice2, result: 0)
    transaction4 = create(:transaction, invoice: invoice2, result: 1)
    transaction5 = create(:transaction, invoice: invoice3, result: 0)
    transaction6 = create(:transaction, invoice: invoice3, result: 0)
    
    
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100)
    invoice_item2 = create(:invoice_item, item: item1, invoice: invoice3, quantity: 6, unit_price: 4)
    invoice_item3 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 3, unit_price: 200)
    invoice_item4 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 22, unit_price: 200)
    invoice_item5 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 5, unit_price: 300)
    invoice_item6 = create(:invoice_item, item: item3, invoice: invoice1, quantity: 63, unit_price: 400)
    invoice_item7 = create(:invoice_item, item: item4, invoice: invoice2, quantity: 16, unit_price: 500)
    invoice_item8 = create(:invoice_item, item: item4, invoice: invoice3, quantity: 1, unit_price: 500)
    invoice_item9 = create(:invoice_item, item: item5, invoice: invoice2, quantity: 2, unit_price: 500)
    invoice_item10 = create(:invoice_item, item: item5, invoice: invoice1, quantity: 7, unit_price: 200)
    
    expect(merchant1.best_day).to eq(invoice1.created_at.strftime("%m/%d/%y"))
    expect(merchant2.best_day).to eq(invoice2.created_at.strftime("%m/%d/%y"))
    expect(merchant3.best_day).to eq(invoice2.created_at.strftime("%m/%d/%y"))
    expect(merchant4.best_day).to eq(invoice2.created_at.strftime("%m/%d/%y"))
    expect(merchant5.best_day).to eq(invoice1.created_at.strftime("%m/%d/%y"))
    
  end
 
end
