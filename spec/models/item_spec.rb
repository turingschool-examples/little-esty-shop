require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end
end
