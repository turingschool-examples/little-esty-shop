require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to(:customer) }
  end
end
