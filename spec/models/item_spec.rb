require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end

  describe "instance methods" do
    before(:each) do
      @billman = Merchant.create!(name: "Billman")

      @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001, status: "disabled")
      @mood = @billman.items.create!(name: "Mood Ring", description: "Moody", unit_price: 2002)
      @necklace = @billman.items.create!(name: "Necklace", description: "Sparkly", unit_price: 3045, status: "disabled")
      @toe_ring = @billman.items.create!(name: "Toe Ring", description: "Saucy", unit_price: 1053)
    end

    it "can sort items by their status" do
      expect(@billman.enabled_items).to eq([@mood, @toe_ring])
      expect(@billman.disabled_items).to eq([@bracelet, @necklace])
    end
  end

  describe "class methods" do
    it "can identify top 5 revenue making items" do
      @merchant1 = Merchant.create!(name: 'Merchant1')
      @itemA = @merchant1.items.create!(name: 'itemA', description: 'Description1', unit_price: 222, status: 0)
      @itemB = @merchant1.items.create!(name: 'itemB', description: 'Descriptions', unit_price: 222,status: 0)
      @itemD = @merchant1.items.create!(name: 'itemD', description: 'Descriptive', unit_price: 222, status: 0)
      @itemC = @merchant1.items.create!(name: 'itemC', description: 'Descriptionless', unit_price: 222, status: 0)
      @itemF = @merchant1.items.create!(name: 'ItemF', description: 'Descriptionulous', unit_price: 222, status: 0)
      @itemZ = @merchant1.items.create!(name: 'ItemZ', description: 'DescriptionZ', unit_price: 2222, status: 0)
      @itemX = @merchant1.items.create!(name: 'ItemX', description: 'Descriptionx', unit_price: 2222, status: 0)
      @customer1 = Customer.create!(first_name: "Cuss", last_name: "Tomer")
      @invoiceA = @customer1.invoices.create!(status: "Completed")
      @invoiceB = @customer1.invoices.create!(status: "Completed")
      @invoiceD = @customer1.invoices.create!(status: "Completed")
      @invoiceC = @customer1.invoices.create!(status: "Completed")
      @invoiceF = @customer1.invoices.create!(status: "Completed")
      @invoiceZ = @customer1.invoices.create!(status: "Completed")
      @invoiceX = @customer1.invoices.create!(status: "Completed")
      @transaction1 = @invoiceA.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success")
      @transaction2 = @invoiceB.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction3 = @invoiceD.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction4 = @invoiceC.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction5 = @invoiceF.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction6 = @invoiceZ.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction7 = @invoiceX.transactions.create!(credit_card_number: "12345678912134567", credit_card_expiration_date: "1234", result: "failed" )
      @invoice_itemA = @invoiceA.invoice_items.create!(quantity: 1, unit_price: 10, item_id: @itemA.id, status: "shipped")
      @invoice_itemB = @invoiceB.invoice_items.create!(quantity: 1, unit_price: 8, item_id: @itemB.id, status: "shipped")
      @invoice_itemD = @invoiceD.invoice_items.create!(quantity: 1, unit_price: 6, item_id: @itemD.id, status: "shipped")
      @invoice_itemC = @invoiceC.invoice_items.create!(quantity: 1, unit_price: 4, item_id: @itemC.id, status: "shipped")
      @invoice_itemF = @invoiceF.invoice_items.create!(quantity: 1, unit_price: 2, item_id: @itemF.id, status: "shipped")
      @invoice_itemZ = @invoiceZ.invoice_items.create!(quantity: 1, unit_price: 1, item_id: @itemZ.id, status: "shipped")
      @invoice_itemX = @invoiceX.invoice_items.create!(quantity: 1, unit_price: 12, item_id: @itemX.id, status: "shipped")

      expect(@merchant1.top_5_items).to match_array([@itemA, @itemB, @itemD, @itemC, @itemF])

    end
##########################################
### INTENTIONAL BREAK TO PREVENT ERRORS###
##########################################
    it "#top_sales_date finds the date the top items had their highest sales" do

      @merchant1 = Merchant.create!(name: 'Merchant1')
      @customer1 = Customer.create!(first_name: "Cuss", last_name: "Tomer")
      @itemA = @merchant1.items.create!(name: 'itemA', description: 'Description1', unit_price: 222, status: 0)
      @itemB = @merchant1.items.create!(name: 'itemB', description: 'Descriptions', unit_price: 222,status: 0)
      @itemD = @merchant1.items.create!(name: 'itemD', description: 'Descriptive', unit_price: 222, status: 0)
      @itemC = @merchant1.items.create!(name: 'itemC', description: 'Descriptionless', unit_price: 222, status: 0)
      @itemF = @merchant1.items.create!(name: 'itemF', description: 'Descriptionulous', unit_price: 222, status: 0)

      @invoiceA = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-15 18:00:00 UTC")
      @invoiceB = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-16 18:00:00 UTC")
      @invoiceD = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-17 18:00:00 UTC")
      @invoiceC = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-18 18:00:00 UTC")
      @invoiceF = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-19 18:00:00 UTC")
      @invoiceBB = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-15 18:00:00 UTC")
      @invoiceAA = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-16 18:00:00 UTC")
      @invoiceCC = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-17 18:00:00 UTC")
      @invoiceFF = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-18 18:00:00 UTC")
      @invoiceDD = @customer1.invoices.create!(status: "Completed", created_at: "2012-03-18 18:00:00 UTC")

      @transaction1 = @invoiceA.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success")
      @transaction2 = @invoiceB.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction3 = @invoiceD.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction4 = @invoiceC.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction5 = @invoiceF.transactions.create!(credit_card_number: "1234567891234567", credit_card_expiration_date: "1234", result: "success" )
      @transaction6= @invoiceAA.transactions.create!(credit_card_number: "12345678912134567", credit_card_expiration_date: "1234", result: "success" )
      @transaction7= @invoiceBB.transactions.create!(credit_card_number: "12345678912134567", credit_card_expiration_date: "1234", result: "success" )
      @transaction8= @invoiceDD.transactions.create!(credit_card_number: "12345678912134567", credit_card_expiration_date: "1234", result: "success" )
      @transaction9= @invoiceCC.transactions.create!(credit_card_number: "12345678912134567", credit_card_expiration_date: "1234", result: "success" )
      @transaction10 = @invoiceFF.transactions.create!(credit_card_number: "12345678912134567", credit_card_expiration_date: "1234", result: "success" )
      @invoice_itemA = @invoiceA.invoice_items.create!(quantity: 13, unit_price: 41, item_id: @itemA.id, status: "shipped")
      @invoice_itemB = @invoiceB.invoice_items.create!(quantity: 11, unit_price: 33, item_id: @itemB.id, status: "shipped")
      @invoice_itemD = @invoiceD.invoice_items.create!(quantity: 7, unit_price: 5, item_id: @itemD.id, status: "shipped")
      @invoice_itemC = @invoiceC.invoice_items.create!(quantity: 5, unit_price: 7, item_id: @itemC.id, status: "shipped")
      @invoice_itemF = @invoiceF.invoice_items.create!(quantity: 3, unit_price: 13, item_id: @itemF.id, status: "shipped")
      @invoice_itemBB= @invoiceBB.invoice_items.create!(quantity: 17, unit_price: 33, item_id: @itemB.id, status: "shipped")
      @invoice_itemDD= @invoiceDD.invoice_items.create!(quantity: 11, unit_price: 5, item_id: @itemD.id, status: "shipped")
      @invoice_itemCC= @invoiceCC.invoice_items.create!(quantity: 23, unit_price: 7, item_id: @itemC.id, status: "shipped")
      @invoice_itemFF= @invoiceFF.invoice_items.create!(quantity: 17, unit_price: 13, item_id: @itemF.id, status: "shipped")
      @invoice_itemAA= @invoiceAA.invoice_items.create!(quantity: 19, unit_price: 41, item_id: @itemA.id, status: "shipped")

    expect(@itemA.best_day).to eq('03-16-2012')
    expect(@itemB.best_day).to eq('03-15-2012')
    expect(@itemC.best_day).to eq('03-17-2012')
    expect(@itemD.best_day).to eq('03-18-2012')
    expect(@itemF.best_day).to eq('03-18-2012')
    end
  end
end
