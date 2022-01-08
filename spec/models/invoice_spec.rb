require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to :customer }
  end

  describe "validations" do
    it { should validate_presence_of(:customer) }
  end

  describe 'instance methods' do
    before(:each) do
      @customer = FactoryBot.create(:customer, first_name: "Cookie", last_name: "Monster")
      @invoice = FactoryBot.create(:invoice, customer: @customer)
    end

    describe 'pretty_created_at' do
      it 'formats created_at datetime' do
        expect(@invoice.pretty_created_at).to eq(Date.today.strftime("%A, %B %-d, %Y"))
      end
    end

    describe 'customer_name' do
      it 'outputs customer full name' do
        expect(@invoice.customer_name).to eq("Cookie Monster")
      end
    end
  end
end
