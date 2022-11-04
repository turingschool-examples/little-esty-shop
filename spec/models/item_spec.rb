require 'rails_helper' 

RSpec.describe Item do 
  describe 'relationships' do 
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  it 'returns most recent top selling date for an item' do 
    @merchant2 = Merchant.create!(name: 'East India Trading Company', status: 'Disabled')
    @customer1 = Customer.create!(first_name: 'Dandy', last_name: 'Dan')

    @customer1.invoices.create!(status: 0)
    @invoice4 = Invoice.create!(status: 0, customer_id: @customer1.id, created_at: "2022-11-04 11:00:00 UTC")
    @invoice5 = Invoice.create!(status: 0, customer_id: @customer1.id, created_at: "2022-11-02 11:00:00 UTC")
    @invoice6 = Invoice.create!(status: 0, customer_id: @customer1.id, created_at: "2022-11-02 08:00:00 UTC")
    @item6 = @merchant2.items.create!(name: 'Kevin Ta Action Figure', description: 'The coolest action figure around!', unit_price: 10000)

    @item6.invoices << @invoice4 << @invoice5 << @invoice6
    expect(@item6.most_recent_date).to eq([@invoice4.created_at])
  end

end