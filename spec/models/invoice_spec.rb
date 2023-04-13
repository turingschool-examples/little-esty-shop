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

  describe "Class methods" do
  end

  describe "Instance methods" do
    describe "#created_at_date" do
      it "converts timestamp format to a readable date" do
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Time.now + 2.days)
      @invoice_2 = create(:invoice, customer_id: @customer_1.id, created_at: Time.now + 1.days)
      @invoice_3 = create(:invoice, customer_id: @customer_1.id, created_at: Time.now)

      
      end
    end
  end

end