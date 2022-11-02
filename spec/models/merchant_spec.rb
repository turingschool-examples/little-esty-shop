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
    @invoice2 = @customer2.invoices.create!(status: 2)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @invoice5 = @customer5.invoices.create!(status: 2)

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

  describe 'grouping by status' do 
    before :each do 
      @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones")
      @whb = Merchant.create!(name: "WHB")
      @something= @klein_rempel.items.create!(name: "Something", description: "A thing that is something", unit_price: 300, status: "Enabled")
      @another = @klein_rempel.items.create!(name: "Another", description: "One more something", unit_price: 150, status: "Enabled")
      @water= @klein_rempel.items.create!(name: "Water", description: "like the ocean", unit_price: 80, status: "Disabled")
      @other = @whb.items.create!(name: "Other", description: "One more something", unit_price: 150)
    end

    it 'returns a list of merchant items that are enabled' do 
      expect(@klein_rempel.enabled_items).to eq([@something.name, @another.name])
      expect(@klein_rempel.enabled_items).to_not eq([@other.name])
    end

    it 'returns a list of merchant items that are disabled' do 
      expect(@klein_rempel.disabled_items).to eq([@water.name])
      expect(@klein_rempel.disabled_items).to_not eq([@another.name, @something.name])

    end

  end
end