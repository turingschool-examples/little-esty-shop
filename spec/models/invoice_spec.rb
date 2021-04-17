require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through :invoice_items}
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    
    it '::incomplete_invoices' do
      @invoice_1 = FactoryBot.create(:invoice)
      @invoice_2 = FactoryBot.create(:invoice)
      @invoice_3 = FactoryBot.create(:invoice)
      @invoice_4 = FactoryBot.create(:invoice)
      @invoice_5 = FactoryBot.create(:invoice)
      @invoice_6 = FactoryBot.create(:invoice)

      expect(Invoice.incomplete_invoices.map(&:status).uniq).to match_array(["in progress", "cancelled"])
    end
  end
end
