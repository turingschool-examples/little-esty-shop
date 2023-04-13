require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
  end

  describe "instance methods" do
    describe 'customer_name' do
      it 'returns the name of the customer' do
        expect(@invoice_1.customer_name).to eq(@customer_1.first_name + " " + @customer_1.last_name)
      end
    end
  end

  describe "Class methods" do
  end

  describe "Instance methods" do
    describe "#created_at_date" do
      it "converts timestamp format to a readable date" do
      customer_1 = create(:customer)
      invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: '2011-01-08 20:54:10 UTC')
      invoice_2 = create(:invoice, customer_id: @customer_1.id, created_at: '2012-05-11 13:54:10 UTC')
      invoice_3 = create(:invoice, customer_id: @customer_1.id, created_at: '2013-08-21 08:54:10 UTC')

      expect(invoice_1.convert_created_at).to eq('Saturday, January 08, 2011')
      expect(invoice_2.convert_created_at).to eq('Friday, May 11, 2012')
      expect(invoice_3.convert_created_at).to eq('Wednesday, August 21, 2013')
      end
    end

    describe 'customer_name' do
      it 'returns the name of the customer' do
        expect(@invoice_1.customer_name).to eq(@customer_1.first_name + " " + @customer_1.last_name)
      end
    end
    
  end

end
