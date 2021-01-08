require "rails_helper"

describe Merchant, type: :model do
  describe "relations" do
    it {should have_many :invoices}
    it {should have_many :items}
    it {should have_many(:customers).through(:invoices)}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "The instance method:" do
    let(:merchant1) do
      create(:merchant)
    end

    it "favorite_customers;" do
      create_list(:customer, 10)
      Customer.all.each_with_index do |customer, index|
        (index + 1).times do
          invoice = create(:invoice, merchant: merchant1, customer: customer)
          create(:transaction, invoice: invoice, result: 0)
        end
      end

      Customer.order(id: :desc).each_with_index do |customer, index|
        (index + 2).times do
          invoice = create(:invoice, merchant: merchant1, customer: customer)
          create(:transaction, invoice: invoice, result: 1)
        end
      end

      expect(merchant1.favorite_customers.to_set).to eq(Customer.offset(5).limit(5).to_set)
    end

    it 'items_to_ship;' do
      items = create_list(:item, 6, merchant: merchant1)
      items.first(4).each do |item|
        create(:invoice_item, item: item, status: 1)
      end

      expect(merchant1.items_to_ship.to_set).to eq(items.first(4).to_set)
    end
  end
end
