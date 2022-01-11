require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:merchant_1) {FactoryBot.create(:merchant)}
  let!(:merchant_2) {FactoryBot.create(:merchant)}

  let!(:item_1) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1)}
  let!(:item_4) {FactoryBot.create(:item, merchant: merchant_2)}

  let!(:invoice_1) {FactoryBot.create(:invoice)}

  let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, credit_card_expiration_date: Date.today, result: 0)}

  let!(:invoice_item_1) {FactoryBot.create(:invoice_item, quantity: 100, unit_price: 200, item: item_1, invoice: invoice_1, status: 0)}
  let!(:invoice_item_2) {FactoryBot.create(:invoice_item, quantity: 50, unit_price: 100, item: item_2, invoice: invoice_1, status:0)}
  let!(:invoice_item_3) {FactoryBot.create(:invoice_item, item: item_3)}
  let!(:invoice_item_4) {FactoryBot.create(:invoice_item, item: item_4)}
  
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:merchant) }
    it { should validate_numericality_of(:unit_price) }
    it { should define_enum_for(:status).with_values(disabled: 0,enabled: 1) }
  end 
  
  describe 'instance methods' do 
    it 'can return the quantity of the item on an invoice' do 
      expect(item_1.invoice_item_quantity(invoice_1)).to eq(100)
    end

    it 'can return the unit price of the item on an invoice' do 
      expect(item_1.invoice_item_unit_price(invoice_1)).to eq(200)
    end

    it 'can return the status of the item on an invoice' do 
      expect(item_1.invoice_item_status(invoice_1)).to eq("pending")
    end
  end

  describe '#date_created' do
    it 'returns the date created of an items invoice and formats it' do
      expect(invoice_item_1.item.date_created).to eq(invoice_item_1.invoice.created_at.strftime("%A, %B %-d, %Y"))
    end
  end

  describe '#top_day' do
    before (:each) do
      @merch_1 = Merchant.create!(name: "Cat Stuff")
      @merch_2 = Merchant.create!(name: "Dog Stuff")

      @cust1 = FactoryBot.create(:customer)
      @cust2 = FactoryBot.create(:customer)
      @cust3 = FactoryBot.create(:customer)
      @cust4 = FactoryBot.create(:customer)
      @cust5 = FactoryBot.create(:customer)

      @inv1 = @cust1.invoices.create!(status: 1, created_at: Time.now - 6.day)
      @tran1 = FactoryBot.create(:transaction, invoice: @inv1,  result: 1)

      @inv2 = @cust1.invoices.create!(status: 1, created_at: Time.now - 5.day)
      @tran2 = FactoryBot.create(:transaction, invoice: @inv2,  result: 1)

      @inv3 = @cust2.invoices.create!(status: 1, created_at: Time.now - 5.day)
      @tran3 = FactoryBot.create(:transaction, invoice: @inv3,  result: 1)

      @inv4 = @cust2.invoices.create!(status: 1, created_at: Time.now - 4.day)
      @tran4 = FactoryBot.create(:transaction, invoice: @inv4,  result: 1)

      @inv5 = @cust2.invoices.create!(status: 1, created_at: Time.now - 3.day)
      @tran5 = FactoryBot.create(:transaction, invoice: @inv5,  result: 1)

      @inv6 = @cust3.invoices.create!(status: 1, created_at: Time.now - 2.day)
      @tran5 = FactoryBot.create(:transaction, invoice: @inv5,  result: 1)

      @inv7 = @cust3.invoices.create!(status: 1, created_at: Time.now - 2.day)
      @tran5 = FactoryBot.create(:transaction, invoice: @inv5,  result: 1)

      @inv8 = @cust4.invoices.create!(status: 1, created_at: Time.now - 2.day)
      @tran5 = FactoryBot.create(:transaction, invoice: @inv5,  result: 1)

      @inv9 = @cust4.invoices.create!(status: 0)
      @tran9 = FactoryBot.create(:transaction, invoice: @inv6,  result: 1)

      @inv10 = @cust5.invoices.create!(status: 1)
      @tran10 = FactoryBot.create(:transaction, invoice: @inv7,  result: 0)

      @inv11 = @cust5.invoices.create!(status: 0)
      @tran11 = FactoryBot.create(:transaction, invoice: @inv8,  result: 0)

      @item1 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 100)
      @item2 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 200)
      @item3 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 300)
      @item4 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 400)
      @item5 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 500)
      @item6 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 600)
      @item7 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 700)
      @item8 = FactoryBot.create(:item, merchant: @merch_2, unit_price: 10000)
#need to edit quantity for top_days, may need to add invoice items, edit invoices too????
      @ii_1 = InvoiceItem.create!(invoice: @inv1, item: @item7, quantity: 20, unit_price: 700)
      @ii_2 = InvoiceItem.create!(invoice: @inv1, item: @item5, quantity: 15, unit_price: 500)
      @ii_3 = InvoiceItem.create!(invoice: @inv2, item: @item7, quantity: 10, unit_price: 700)
      @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item5, quantity: 10, unit_price: 500)
      @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item1, quantity: 20, unit_price: 100)
      @ii_5 = InvoiceItem.create!(invoice: @inv3, item: @item4, quantity: 8, unit_price: 400)
      @ii_6 = InvoiceItem.create!(invoice: @inv3, item: @item1, quantity: 30, unit_price: 100)
      @ii_7 = InvoiceItem.create!(invoice: @inv3, item: @item2, quantity: 5, unit_price: 200)
      @ii_8 = InvoiceItem.create!(invoice: @inv4, item: @item3, quantity: 5, unit_price: 300)
      @ii_9 = InvoiceItem.create!(invoice: @inv5, item: @item3, quantity: 6, unit_price: 300)
      @ii_10 = InvoiceItem.create!(invoice: @inv5, item: @item6, quantity: 1, unit_price: 600)
      @ii_11 = InvoiceItem.create!(invoice: @inv5, item: @item7, quantity: 50, unit_price: 700)
      @ii_12 = InvoiceItem.create!(invoice: @inv5, item: @item5, quantity: 5, unit_price: 500)
      @ii_13 = InvoiceItem.create!(invoice: @inv6, item: @item7, quantity: 5, unit_price: 700)
      @ii_14 = InvoiceItem.create!(invoice: @inv7, item: @item7, quantity: 30, unit_price: 700)
      @ii_15 = InvoiceItem.create!(invoice: @inv8, item: @item1, quantity: 10, unit_price: 100)
      @ii_15 = InvoiceItem.create!(invoice: @inv8, item: @item3, quantity: 7, unit_price: 100)
      @ii_5 = InvoiceItem.create!(invoice: @inv8, item: @item4, quantity: 1, unit_price: 400)

      @ii_11 = InvoiceItem.create!(invoice: @inv9, item: @item6, quantity: 2000, unit_price: 600)
      @ii_12 = InvoiceItem.create!(invoice: @inv10, item: @item6, quantity: 2000, unit_price: 600)
      @ii_13 = InvoiceItem.create!(invoice: @inv11, item: @item6, quantity: 2000, unit_price: 600)
      @ii_14 = InvoiceItem.create!(invoice: @inv11, item: @item8, quantity: 2000, unit_price: 10000)
    end

    it 'shows the day in which an item generated the most revenue' do

      expect(@item7.top_day).to eq(@inv5.created_at)
      expect(@item5.top_day).to eq(@inv1.created_at)
      expect(@item1.top_day).to eq(@inv3.created_at)
      expect(@item3.top_day).to eq(@inv8.created_at)
      expect(@item4.top_day).to eq(@inv3.created_at)
    end
  end
end
