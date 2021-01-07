require "rails_helper"

describe Customer, type: :model do
  describe "relations" do
    it { should have_many :invoices }
  end

  describe 'class methods' do
    it ".favorite_customers" do
      create_list(:customer, 10)
      Customer.all.each_with_index do |customer, index|
        (index + 1).times do
          invoice = create(:invoice, customer: customer)
          create(:transaction, invoice: invoice, result: 0)
        end
      end
      Customer.order(id: :desc).each_with_index do |customer, index|
        (index + 2).times do
          invoice = create(:invoice, customer: customer)
          create(:transaction, invoice: invoice, result: 1)
        end
      end

      favorites = Customer.joins(:invoices).favorite_customers
      expect(favorites.to_set).to eq(Customer.offset(5).limit(5).to_set)
      expect(favorites[0].count).to eq(10)
      expect(favorites[1].count).to eq(9)
      expect(favorites[2].count).to eq(8)
      expect(favorites[3].count).to eq(7)
      expect(favorites[4].count).to eq(6)
    end
  end
end
