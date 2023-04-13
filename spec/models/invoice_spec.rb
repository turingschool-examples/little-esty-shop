require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:status)}
    it { should define_enum_for(:status)}
  end

  describe "instance methods" do
    describe 'customer_name' do
      it 'returns the name of the customer' do
        expect(@invoice_1.customer_name).to eq(@customer_1.first_name + " " + @customer_1.last_name)
      end
    end
  end
end