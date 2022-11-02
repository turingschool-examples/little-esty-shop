require 'rails_helper'

RSpec.describe Merchant do 
  describe 'relationships' do 
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
  end

  before(:each) do 
    @merchant1 = Merchant.create!(name: 'Lisa Frank Knockoffs')

    @item1 = @merchant1.items.create!(name: 'Trapper Keeper', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 3000)

    @customer1 = Customer.create!(first_name: 'Dandy', last_name: 'Dan')
    @customer2 = Customer.create!(first_name: 'Rockin', last_name: 'Rick')
    @customer3 = Customer.create!(first_name: 'Swingin', last_name: 'Susie')
    @customer4 = Customer.create!(first_name: 'Party', last_name: 'Pete')
    @customer5 = Customer.create!(first_name: 'Swell', last_name: 'Sally')
    @customer6 = Customer.create!(first_name: 'Margarita', last_name: 'Mary')

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer1.invoices.create!(status: 2)
    @invoice3 = @customer2.invoices.create!(status: 2)
    @invoice4 = @customer3.invoices.create!(status: 2)
    @invoice5 = @customer4.invoices.create!(status: 2)
    @invoice6 = @customer5.invoices.create!(status: 2)

    @item1.invoices << @invoice1 << @invoice2 << @invoice3 << @invoice4 << @invoice5 << @invoice6

    @transaction1 = @invoice1.transactions.create!(result: 0)
    @transaction2 = @invoice2.transactions.create!(result: 0)
    @transaction3 = @invoice3.transactions.create!(result: 0)
    @transaction4 = @invoice4.transactions.create!(result: 0)
    @transaction5 = @invoice5.transactions.create!(result: 0)
    @transaction6 = @invoice6.transactions.create!(result: 0)
    
  end

  describe '#top_five_customers' do 
    it 'returns top five customers of merchant' do 
      expect(@merchant1.top_five_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5,])

      invoice7 = @customer6.invoices.create!(status: 2)
      invoice8 = @customer6.invoices.create!(status: 2)

      invoice7.transactions.create!(result: 0)
      invoice8.transactions.create!(result: 0)

      @item1.invoices << invoice7 << invoice8

      expect(@merchant1.top_five_customers).to eq([@customer1, @customer6, @customer2, @customer3, @customer4,])
    end

    it 'doesnt count unsuccessful transactions' do
      invoice7 = @customer6.invoices.create!(status: 2)
      invoice8 = @customer6.invoices.create!(status: 2)

      invoice7.transactions.create!(result: 1)
      invoice8.transactions.create!(result: 1)

      @item1.invoices << invoice7 << invoice8

      expect(@merchant1.top_five_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5,])
    end
  end
end