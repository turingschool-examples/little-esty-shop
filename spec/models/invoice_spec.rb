require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
    it { should define_enum_for(:status).with_values(["In Progress", "Completed", "Cancelled"])}

  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
  end
    
  it 'instantiates with factorybot' do
    customer = create(:customer)
    invoice = customer.invoices.create(attributes_for(:invoice))
    x = create_list(:invoice, 10, customer: customer)
   
  end

  it 'instantiates without creating parents' do
    invoice = create(:invoice)
    #calling parents: invoice.customer 
  end

  it 'creates a list of invoices belonging to one customer' do
    customer = create(:customer)
    customer_invoices = create_list(:invoice, 10, customer: customer)
  end

  it 'creates a list of 10 customers' do
    customers = create_list(:customer, 10)
  end

  it 'can return only invoices with a status of in progress' do
    completed_invoices = create_list(:invoice, 10, status: 1)
    cancelled_invoices = create_list(:invoice, 10, status: 2)
    
    inc_inv_oldest = create(:invoice, status: 0, created_at: Date.yesterday)
    inc_inv_middle = create(:invoice, status: 0, created_at: Date.today)
    inc_inv_newest = create(:invoice, status: 0, created_at: Date.tomorrow)
    
    expect(Invoice.incomplete_invoices_sorted).to eq([inc_inv_oldest, inc_inv_middle, inc_inv_newest])
  end

  





end
