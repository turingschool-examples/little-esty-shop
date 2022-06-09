require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should have_many(:customers).through(:invoice) }
    it { should have_many(:invoice_items).through(:invoice) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_presence_of(:result) }
  end
end
