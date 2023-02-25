require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do 
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should define_enum_for(:status).with_values(["pending", "packaged", "shipped"]) }
  end

  describe "class method" do
    before(:each) do
      @merchant1 = Merchant.create!(name: "Mel's Travels")
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

      @item1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant1)
      @item2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
      @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant1)

      @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant2)
      @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant2)

      @deniz = Customer.create!(first_name: "Deniz", last_name: "Ocean")
      @invoice3 = Invoice.create!(customer: @deniz, status: 0) #in progress
      @invoice4 = Invoice.create!(customer: @deniz, status: 0) #in progress
      @invoice5 = Invoice.create!(customer: @deniz, status: 0) #in progress
      InvoiceItem.create!(item: @item1, invoice: @invoice3, quantity: 1, unit_price: 1950, status: 0) #pending
      InvoiceItem.create!(item: @item2, invoice: @invoice4, quantity: 1, unit_price: 2850, status: 2) #shipped (Expect NOT to see on page)
      InvoiceItem.create!(item: @item3, invoice: @invoice5, quantity: 1, unit_price: 1650, status: 1) #packaged
      @invoice3.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
      @invoice4.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
      @invoice5.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success

      @emre = Customer.create!(first_name: "Emre", last_name: "Bond")
      @invoice6  = Invoice.create!(customer: @emre, status: 0) #in progress
      InvoiceItem.create!(item: @item4, invoice: @invoice6, quantity: 1, unit_price: 9950, status: 1) #packaged
      InvoiceItem.create!(item: @item5, invoice: @invoice6, quantity: 1, unit_price: 1000, status: 2) #shipped
      @invoice6.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) #success

      @serap = Customer.create!(first_name: "Serap", last_name: "Yilmaz")
      @invoice7  = Invoice.create!(customer: @serap, status: 0) #in progress
      InvoiceItem.create!(item: @item4, invoice: @invoice7, quantity: 1, unit_price: 9950, status: 1) #packaged
      InvoiceItem.create!(item: @item5, invoice: @invoice7, quantity: 1, unit_price: 1000, status: 1) #packaged
      @invoice6.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) #success

    end

    it "#incomplete_invoices" do
      expect(InvoiceItem.incomplete_invoices.to_a).to eq([@invoice3.id, @invoice5.id, @invoice6.id, @invoice7.id])
    end
  end
end
