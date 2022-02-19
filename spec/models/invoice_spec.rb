require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do 
    it { should define_enum_for(:status).with_values([:pending, :completed]) }
  end 

  before :each do 
    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @customer2 = Customer.create!(first_name: 'Hungry', last_name: 'Individual')
    
    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice3 =Invoice.create!(status: 0, customer_id: @customer2.id)
  end

  describe 'instance methods' do 
    describe '#customer_name' do
      it 'returns the full name of a the customer an invoice belongs to' do
        expect(@invoice1.customer_name).to eq("Tired Person")
       end 
    end 

    describe '#format_created_at' do
      it 'returns the time the invoice was created at in "Weekday, Month Day, Year format' do
        expect(@invoice1.format_created_at(@invoice1.created_at)).to eq("Saturday, February 19, 2022")
       end 
    end 
  end 
end
