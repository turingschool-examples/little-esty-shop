require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  it 'can create a custom date' do
    @customer_1 = Customer.create!(first_name: 'Jon', last_name: 'Jones')
    @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09 UTC')
    
    expect(@invoice_1.custom_date).to eq("Sunday, March 25, 2012")
  end
end