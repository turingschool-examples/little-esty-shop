require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}

  end

  describe 'class methods' do
    before(:each)do
    @billman = Merchant.create!(name: "Billman")
    @parker = Merchant.create!(name: "Parker's Perfection Pagoda")

    @brenda = Customer.create!(first_name: "Brenda", last_name: "Bhoddavista")
    @jimbob = Customer.create!(first_name: "Jimbob", last_name: "Dudeguy")
    @casey = Customer.create!(first_name: "Casey", last_name: "Zafio")
    @nick = Customer.create!(first_name: "Nick", last_name: "Jocabs")
    @chris = Customer.create!(first_name: "Chris", last_name: "Kjolheed")
    @mike = Customer.create!(first_name: "Mike", last_name: "Ado")

    @bracelet = @billman.items.create!(name: "Bracelet", description: "shiny", unit_price: 1001)
    @beard = @parker.items.create!(name: "beard oil", description: "oily", unit_price: 2002)

    @invoice1 = @chris.invoices.create!(status: "In Progress")
    @invoice2 = @chris.invoices.create!(status: "Completed")
    @transaction1 = @invoice1.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction2 = @invoice2.transactions.create!(credit_card_number: 4654405418249632, result: "failed")

    @invoice3 = @jimbob.invoices.create!(status: "Completed")
    @invoice4 = @jimbob.invoices.create!(status: "Completed")
    @transaction3 = @invoice3.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction4 = @invoice4.transactions.create!(credit_card_number: 4654405418249632, result: "success")

    @invoice5 = @casey.invoices.create!(status: "In Progress")
    @transaction5 = @invoice5.transactions.create!(credit_card_number: 4654405418249632, result: "success")

    @invoice6 = @mike.invoices.create!(status: "Completed")
    @invoice7 = @mike.invoices.create!(status: "Completed")
    @invoice8 = @mike.invoices.create!(status: "Completed")
    @transaction6 = @invoice6.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction7 = @invoice7.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction8 = @invoice8.transactions.create!(credit_card_number: 4654405418249632, result: "success")

    @invoice9 = @nick.invoices.create!(status: "Completed")
    @invoice11 = @nick.invoices.create!(status: "Completed")
    @transaction9 = @invoice9.transactions.create!(credit_card_number: 4654405418249632, result: "success")
    @transaction11 = @invoice11.transactions.create!(credit_card_number: 4654405418249632, result: "success")

    @invoice10 = @brenda.invoices.create!(status: "Completed")
    @transaction10 = @invoice10.transactions.create!(credit_card_number: 4654405418249632, result: "failed")


    InvoiceItem.create!(item_id: @beard.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice3.id, quantity: 3, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice4.id, quantity: 4, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice5.id, quantity: 5, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice6.id, quantity: 1, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice7.id, quantity: 2, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice8.id, quantity: 3, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice9.id, quantity: 4, unit_price: 1000, status: "Shipped")
    InvoiceItem.create!(item_id: @bracelet.id, invoice_id: @invoice10.id, quantity: 5, unit_price: 1000, status: "Shipped")
    end

    it 'can display the five customers with the most successful transactions' do
      expect(Customer.top_customers[0].first_name).to eq("Mike") #3 success
      expect(Customer.top_customers[1].first_name).to eq("Jimbob") #2 success
      expect(Customer.top_customers[2].first_name).to eq("Nick") #2 success
      expect(Customer.top_customers[3].first_name).to eq("Casey") #1 success
      expect(Customer.top_customers[4].first_name).to eq("Chris") #1 success
      expect(Customer.top_customers.length).to eq(5)
    end

    it 'can display the number of successful transactions' do
      expect(Customer.top_customers[0].count).to eq(3) #3 success
      expect(Customer.top_customers[1].count).to eq(2) #2 success
      expect(Customer.top_customers[2].count).to eq(2) #2 success
      expect(Customer.top_customers[3].count).to eq(1) #1 success
      expect(Customer.top_customers[4].count).to eq(1) #1 success
    end
  end
end
