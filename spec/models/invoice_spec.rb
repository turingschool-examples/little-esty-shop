require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
  end

  describe 'enum validation' do
    it { should define_enum_for(:status).with([:in_progress, :cancelled, :completed])}
  end
end
