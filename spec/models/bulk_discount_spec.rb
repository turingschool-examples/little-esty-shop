require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:percent_discount) }
    it { should validate_numericality_of(:percent_discount) }
    it { should validate_presence_of(:quantity_threshold) }
    it { should validate_numericality_of(:quantity_threshold) }

    describe 'relationships' do
      it { should belong_to(:merchant) }
      it { should have_many(:items).through(:merchant) }
      it { should have_many(:invoice_items).through(:items) }
      it { should have_many(:invoices).through(:invoice_items) }
    end
    describe 'Instance Methods' do
      describe '.display_discount' do
        it 'will convert percent_discount to a whole number' do
          merchant1 = Merchant.create!(name: 'Suzy Hernandez')
          five = BulkDiscount.create!(name: 'Five', percent_discount: 0.05, quantity_threshold: 5,
                                      merchant_id: merchant1.id)
          fifty = BulkDiscount.create!(name: 'Fifty', percent_discount: 0.50, quantity_threshold: 50,
                                       merchant_id: merchant1.id)
          expect(five.display_discount).to eq(5)
          expect(fifty.display_discount).to eq(50)
        end
      end
    end
  end
end
