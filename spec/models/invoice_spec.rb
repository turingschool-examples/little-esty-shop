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

  describe 'class methods' do
    describe '#incomplete_invoices_sorted' do
      it 'finds invoices that have invoice items that have not been shipped' do
        invoices = create_list(:invoice, 5)
        
        inv_items_0_shipped = create_list(:invoice_item, 5, invoice: invoices[0], status: 2)
        inv_items_1_shipped = create_list(:invoice_item, 5, invoice: invoices[1], status: 2)
        inv_items_1_unshipped = create_list(:invoice_item, 2, invoice: invoices[1], status: 0)
        
        expect(Invoice.incomplete_invoices_sorted).to eq([invoices[1]])
      end
    end
  end
end
