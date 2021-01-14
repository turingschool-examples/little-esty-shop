require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :merchants }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many :items }
  end

  before :each do
    @merchant = FactoryBot.create(:merchant)

    @customer1 = FactoryBot.create(:customer)
    @customer2 = FactoryBot.create(:customer)
    @customer3 = FactoryBot.create(:customer)
    @customer4 = FactoryBot.create(:customer)
    @customer5 = FactoryBot.create(:customer)
    @customer6 = FactoryBot.create(:customer)

    Customer.all.each do |customer|
        FactoryBot.create_list(:invoice, 1, customer: customer, merchant: @merchant)
    end

    FactoryBot.create_list(:transaction, 1, invoice: @customer1.invoices.first, result: 0)
    FactoryBot.create_list(:transaction, 2, invoice: @customer2.invoices.first, result: 0)
    FactoryBot.create_list(:transaction, 3, invoice: @customer3.invoices.first, result: 0)
    FactoryBot.create_list(:transaction, 4, invoice: @customer4.invoices.first, result: 0)
    FactoryBot.create_list(:transaction, 5, invoice: @customer5.invoices.first, result: 0)
    FactoryBot.create_list(:transaction, 6, invoice: @customer6.invoices.first, result: 0)
    # Customer.all.each do |customer|
    #   transaction_count = [1..8].sample
    #   FactoryBot.create_list(:transaction, transaction_count, invoice: customer.invoices.first, result: 1)
    # end
end

  describe "class methods" do
    it "can get top 5 customers by successful transactions" do
      expect(Customer.top_five.first).to eq(@customer6)
      expect(Customer.top_five.last).to eq(@customer2)
      # expect(Customer.top_five.last).to not include customer 1
    end
  end

  describe "instance methods" do
    it "can get count of successful transactions" do
      expect(@customer1.successful_count).to eq(1)
      expect(@customer6.successful_count).to eq(6)
    end
  end

end
