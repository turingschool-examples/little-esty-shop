require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'instance methods' do
    describe '#best_sales_day' do
      it 'can return date of highest sales earned' do
        expect(@item1.best_sales_day.strftime("%m/%d/%Y")).to eq("08/03/2021")
      end
    end
  end
end
