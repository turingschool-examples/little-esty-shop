require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'class methods' do
    describe 'incomplete_invoices' do
      it 'gives invoices that are incomplete' do
        data = Invoice.incomplete_invoices
        expect(data.count).to eq 288
        test = data[0].created_at < data[1].created_at
        expect(test).to eq true
      end
    end
  end
end
