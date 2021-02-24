require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should have_many :invoices }
  end

  describe "class methods" do
    it ".top_five" do
      @customer1 = Customer.create!(first_name: "First1", last_name: "Last1")
      @customer2 = Customer.create!(first_name: "First2", last_name: "Last2")
      @customer3 = Customer.create!(first_name: "First3", last_name: "Last3")
      @customer4 = Customer.create!(first_name: "First4", last_name: "Last4")
      @customer5 = Customer.create!(first_name: "First5", last_name: "Last5")
      @customer6 = Customer.create!(first_name: "First6", last_name: "Last6")

      @invoice1 = @customer2.invoices.create!(status: 1)
      @transaction1 = @invoice1.transactions.create!(result: 0)
      @invoice2 = @customer2.invoices.create!(status: 1)
      @transaction2 = @invoice2.transactions.create!(result: 0)
      @invoice3 = @customer3.invoices.create!(status: 1)
      @transaction3 = @invoice3.transactions.create!(result: 0)
      @invoice4 = @customer4.invoices.create!(status: 2)
      @transaction4 = @invoice4.transactions.create!(result: 0)
      @invoice5 = @customer4.invoices.create!(status: 1)
      @transaction5 = @invoice5.transactions.create!(result: 0)
      @invoice6 = @customer5.invoices.create!(status: 0)
      @transaction6 = @invoice6.transactions.create!(result: 0)
      @invoice7 = @customer5.invoices.create!(status: 1)
      @transaction7 = @invoice7.transactions.create!(result: 0)
      @invoice8 = @customer5.invoices.create!(status: 1)
      @transaction8 = @invoice8.transactions.create!(result: 0)
      @invoice9 = @customer5.invoices.create!(status: 2)
      @transaction9 = @invoice9.transactions.create!(result: 0)
      @invoice10 = @customer6.invoices.create!(status: 1)
      @transaction10 = @invoice10.transactions.create!(result: 0)
      @invoice11 = @customer6.invoices.create!(status: 0)
      @transaction11 = @invoice11.transactions.create!(result: 0)
      @invoice12 = @customer6.invoices.create!(status: 0)
      @transaction12 = @invoice12.transactions.create!(result: 0)

      expect(Customer.top_five).to eq([@customer5, @customer6, @customer2, @customer4, @customer3])
    end
  end
end
