require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  def customer_name
    customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
    invoice = customer.invoices.create!(status: 'in progress')
    expect(invoice.customer_name).to eq("#{customer.first_name} #{customer.last_name}")
  end
end
