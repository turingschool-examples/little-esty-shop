require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }
  it { should have_many(:invoice_items).through(:items)}
  it { should have_many(:invoices).through(:invoice_items)}
  it { should have_many(:customers).through(:invoices)}
  it { should have_many(:transactions).through(:invoices)}
  it { should validate_presence_of(:name)}

  before :each do
    test_data
    @merchant_6 = Merchant.create!(name: "Sixth Merchant")
  end


  describe "#enabled" do
    it "enables merchant status" do
      merchant = Merchant.create!(name: 'Jimothy', status: 'disabled')
      merchant.enabled!

      expect(merchant.status).to eq('enabled')
    end
  end

  describe "#disabled" do
    it "enables merchant status" do
      merchant = Merchant.create!(name: 'Jimothy', status: 'enabled')
      merchant.disabled!

      expect(merchant.status).to eq('disabled')
    end
  end
end

  describe 'class methods' do
    describe '.top_five_merch_by_revenue' do
      it 'returns an array of five merchants ordered by revenue' do
        expect(Merchant.top_five_merch_by_revenue).to eq([@merchant_2, 
                                                          @merchant_1, 
                                                          @merchant_5, 
                                                          @merchant_3, 
                                                          @merchant_4])
      end
    end
  end

  describe 'instance methods' do
    describe '#total_merch_revenue' do
      it 'returns the total revenue accrued by merchant' do
        merchant_6 = Merchant.create!(name: "kijbt Merchant")
        expect(@merchant_1.total_merch_revenue).to eq(10173900)
        expect(merchant_6.total_merch_revenue).to eq(0)
      end
    end

    describe '#top_selling_date' do
      it 'returns the top selling date' do
        expect(@merchant_1.top_selling_date).to eq("Wednesday, April 19, 2023") 
      end
    end
  end
end
