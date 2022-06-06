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
  end
end
