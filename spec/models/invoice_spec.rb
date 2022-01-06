require 'rails_helper'
describe Invoice, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to :customer }
    it { should have_many :transactions }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values([:cancelled, 'in progress', :completed])}
  end

  # describe 'methods' do
  #   xit '' do
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #
  #   end
  end
