require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end

  it 'status can be 0 by default' do
      invoice = create(:invoice, status: :in_progress)
      expect(invoice.status).to eq("in_progress")
      expect(invoice.canceled?).to eq(false)
      expect(invoice.completed?).to eq(false)
      expect(invoice.in_progress?).to eq(true)
    end

  it 'status can be canceled' do
      invoice = create(:invoice, status: :canceled)
      expect(invoice.status).to eq("canceled")
      expect(invoice.canceled?).to eq(true)
      expect(invoice.completed?).to eq(false)
      expect(invoice.in_progress?).to eq(false)
    end

  it 'status can be canceled' do
      invoice = create(:invoice, status: :completed)
      expect(invoice.status).to eq("completed")
      expect(invoice.canceled?).to eq(false)
      expect(invoice.completed?).to eq(true)
      expect(invoice.in_progress?).to eq(false)
    end
end
