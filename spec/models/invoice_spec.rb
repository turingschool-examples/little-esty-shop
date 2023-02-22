require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe ‘relationships’ do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'enums tests' do
    before do 
      @customer1 = Customer.create!(first_name: "Joe", last_name: "Shmow", uuid: 55)
      @invoice1 = @customer1.invoices.create!(uuid: 1)
    end

    it "can return a status of 'in progress' by default and can change" do 
      expect(@invoice1.status).to eq("in progress")

      @invoice1.status = 1
      expect(@invoice1.status).to eq("completed")
    
      @invoice1.status = 2
      expect(@invoice1.status).to eq("cancelled")
    end
  end
end
