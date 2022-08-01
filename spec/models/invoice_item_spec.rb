require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    # it { should validate_presence_of :created_at }
    # it { should validate_presence_of :updated_at }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should define_enum_for(:status).with_values({ packaged: 0, pending: 1, shipped: 2}) }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end




end
