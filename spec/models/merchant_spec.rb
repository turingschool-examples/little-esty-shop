require 'rails_helper'

RSpec.describe Merchant do 
  describe 'relationships' do 
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
  end

  before(:each) do 
    @merchant1 = Merchant.create!(name: 'Lisa Frank Knockoffs', status: 'Enabled')
    @merchant2 = Merchant.create!(name: 'East India Trading Company', status: 'Disabled')
    @merchant3 = Merchant.create!(name: 'Waffles, Inc', status: 'Disabled')

    @item1 = @merchant1.items.create!(name: 'Trapper Keeper', description: 'Its a Lisa Frank Trapper Keeper', unit_price: 3000)

    @customer1 = Customer.create!(first_name: 'Dandy', last_name: 'Dan')
    @customer2 = Customer.create!(first_name: 'Rockin', last_name: 'Rick')
    @customer3 = Customer.create!(first_name: 'Swingin', last_name: 'Susie')
    @customer4 = Customer.create!(first_name: 'Party', last_name: 'Pete')
    @customer5 = Customer.create!(first_name: 'Swell', last_name: 'Sally')
    @customer6 = Customer.create!(first_name: 'Margarita', last_name: 'Mary')

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer2.invoices.create!(status: 2)
    @invoice3 = @customer3.invoices.create!(status: 1)
    @invoice4 = @customer4.invoices.create!(status: 1)
    @invoice5 = @customer5.invoices.create!(status: 1)

    @item1.invoices << @invoice1 << @invoice2 << @invoice3 << @invoice4 << @invoice5

    @invoice1.transactions.create!(result: 0)
    @invoice1.transactions.create!(result: 0)
    @invoice1.transactions.create!(result: 0)
    @invoice2.transactions.create!(result: 0)
    @invoice2.transactions.create!(result: 0)
    @invoice3.transactions.create!(result: 0)
    @invoice4.transactions.create!(result: 0)
    @invoice5.transactions.create!(result: 0)
  end

  describe 'class methods' do 
    describe '#all_disabled' do 
      it 'returns all disabled merchants' do 
        expect(Merchant.all_disabled).to eq([@merchant2, @merchant3])
      end
    end
    describe '#all_enabled' do
      it 'returns all enabled merchants' do 
        expect(Merchant.all_enabled).to eq([@merchant1])
      end
    end
  end

  describe 'instance methods' do 
    describe '#top_five_customers' do 
      it 'returns top five customers of merchant' do 
        expect(@merchant1.top_five_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5,])

        invoice6 = @customer6.invoices.create!(status: 2)

        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)

        @item1.invoices << invoice6

        expect(@merchant1.top_five_customers).to eq([@customer6, @customer1, @customer2, @customer3, @customer4])
      end

      it 'doesnt count unsuccessful transactions' do
        invoice6 = @customer6.invoices.create!(status: 2)

        invoice6.transactions.create!(result: 1)
        invoice6.transactions.create!(result: 1)

        @item1.invoices << invoice6

        expect(@merchant1.top_five_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5,])
      end

      it 'doesnt count transactions for other merchants' do 
        invoice6 = @customer6.invoices.create!(status: 2)

        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)

        expect(@merchant1.top_five_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
      end

      it 'doesnt count transactions on users other invoices' do 
        invoice6 = @customer2.invoices.create!(status: 2)

        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)
        invoice6.transactions.create!(result: 0)

        expect(@merchant1.top_five_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
      end
    end

    describe '#incomplete_invoices' do 
      it 'returns all invoices of merchant that are incomplete' do 
        expect(@merchant1.incomplete_invoices).to eq([@invoice3, @invoice4, @invoice5])

        invoice6 = @customer1.invoices.create!(status: 1)
        @item1.invoices << invoice6

        expect(@merchant1.incomplete_invoices).to eq([@invoice3, @invoice4, @invoice5, invoice6])
      end

      it 'doesnt return invoices not associated with merchant' do 
        @customer1.invoices.create!(status: 1)

        expect(@merchant1.incomplete_invoices).to eq([@invoice3, @invoice4, @invoice5])
      end

      it 'works across multiple items' do 
        item2 = @merchant1.items.create!(name: 'Fuzzy Pencil', description: 'Its a fuzzy pencil', unit_price: 500)
        invoice6 = @customer1.invoices.create!(status: 1)
        item2.invoices << invoice6

        expect(@merchant1.incomplete_invoices).to eq([@invoice3, @invoice4, @invoice5, invoice6])
      end
    end
  end
end