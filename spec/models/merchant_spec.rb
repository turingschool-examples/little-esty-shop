require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should have_many(:items) }
  end

  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
    @not_joe = Merchant.create!(name: "Not Joe Rogan")
    @customer1 = Customer.create!(first_name: "Dana", last_name: "White")
    @customer2 = Customer.create!(first_name: "John", last_name: "Singer")
    @customer3 = Customer.create!(first_name: "Jack", last_name: "Berry")
    @customer4 = Customer.create!(first_name: "Jill", last_name: "Kellogg")
    @customer5 = Customer.create!(first_name: "Jason", last_name: "Sayles")
    @item1 = @joe.items.create!(name: "Basketball", description: "Bouncy", unit_price: 20)
    @item2 = @joe.items.create!(name: "Baseball", description: "Not Bouncy", unit_price: 10)
    @item3 = @joe.items.create!(name: "Hockey Puck", description: "Not Bouncy", unit_price: 2)
    @item4 = @not_joe.items.create!(name: "Not A Baseball", description: "Not Bouncy", unit_price: 10)
    @item5 = @not_joe.items.create!(name: "not A Hockey Puck", description: "Not Bouncy", unit_price: 2)
    @inv1 = @customer1.invoices.create!(status: "completed")
    @inv2 = @customer2.invoices.create!(status: "completed")
    @inv3 = @customer3.invoices.create!(status: "completed")
    @inv4 = @customer4.invoices.create!(status: "completed")
    @inv5 = @customer5.invoices.create!(status: "completed")
    @inv6 = @customer5.invoices.create!(status: "completed")
    @inv7 = @customer5.invoices.create!(status: "completed")
    InvoiceItem.create!(invoice: @inv1, item: @item1, unit_price: 20, status: "packaged")
    InvoiceItem.create!(invoice: @inv2, item: @item2, unit_price: 10, status: "packaged")
    InvoiceItem.create!(invoice: @inv3, item: @item3, unit_price: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv4, item: @item1, unit_price: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv5, item: @item2, unit_price: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv6, item: @item4, unit_price: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv7, item: @item5, unit_price: 2, status: "shipped")
    InvoiceItem.create!(invoice: @inv7, item: @item1, unit_price: 2, status: "shipped")
  end

  describe 'methods' do
    it 'should find all unshipped items' do
      unshipped_items = 2

      expect(@joe.unshipped.length).to eq(unshipped_items)
    end

    it 'can find all its customers' do
      expect(@joe.customers).to include(@customer1, @customer2, @customer3, @customer4, @customer5)
    end

    it 'can find its top 5 customers' do
      5.times{@inv5.transactions.create!(result: "success")}
      4.times{@inv4.transactions.create!(result: "success")}
      3.times{@inv3.transactions.create!(result: "success")}
      2.times{@inv2.transactions.create!(result: "success")}
      @inv1.transactions.create!(result: "success")

      expect(@joe.top_five_customers).to eq([@customer5, @customer4, @customer3, @customer2, @customer1])
      expect(@joe.top_five_customers).to_not eq([@customer1, @customer4, @customer3, @customer2, @customer5])
    end

    it "#invoice_ids" do
      expect(@joe.invoice_ids).to eq([@inv1.id, @inv2.id, @inv3.id, @inv4.id, @inv5.id, @inv7.id])
    end
  end
end
