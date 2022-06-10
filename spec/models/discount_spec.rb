require 'rails_helper'

RSpec.describe Discount do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchants) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:percentage) }
    it { should validate_presence_of(:quantity_threshold) }
    it { should validate_numericality_of(:percentage) }
  end
end
