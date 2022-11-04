require 'rails_helper' 

RSpec.describe Invoice do 
  before :each do 
    @merchant1 = Merchant.create!(name: "Kevin's Illegal goods")
    @merchant2 = Merchant.create!(name: "Denver PC parts")

    @customer1 = Customer.create!(first_name: "Sean", last_name: "Culliton")
    @customer2 = Customer.create!(first_name: "Sergio", last_name: "Azcona")
    @customer3 = Customer.create!(first_name: "Emily", last_name: "Port")

    @item1 = @merchant1.items.create!(name: "Funny Brick of Powder", description: "White Powder with Gasoline Smell", unit_price: 5000)
    @item2 = @merchant1.items.create!(name: "T-Rex", description: "Skull of a Dinosaur", unit_price: 100000)
    @item3 = @merchant2.items.create!(name: "UFO Board", description: "Out of this world MotherBoard", unit_price: 400)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer2.id, created_at: "2022-11-01 11:00:00 UTC")
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2022-11-01 11:00:00 UTC")
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id, created_at: "2022-11-01 11:00:00 UTC")
    
    @invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: 5000, status: 0, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item2 =InvoiceItem.create!(quantity: 2, unit_price: 5000, status: 1, item_id: @item2.id, invoice_id: @invoice1.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 10, unit_price: 2000, status: 2, item_id: @item3.id, invoice_id: @invoice2.id)

  end
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
  end 

  describe "model methods"

  it 'can calculate total revenue of an invoice' do 

    expect(@invoice1.total_revenue).to eq(15000.00) 
    expect(@invoice2.total_revenue).to eq(20000.00) 

  end

  # it 'find most recent creation date on an invoice' do 
  #   @invoice4 = Invoice.create!(status: 1, customer_id: @customer2.id, created_at: "2022-11-04 11:00:00 UTC")
  #   @invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2022-11-02 11:00:00 UTC")
  #   @invoice5 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2022-11-02 08:00:00 UTC")

  #   # require 'pry'; binding.pry
  #   expect(Invoice.order_by_creation_date).to eq([@invoice4])
  # end
end