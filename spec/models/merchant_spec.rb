require 'rails_helper'

RSpec.describe Merchant do
  describe 'associations' do
    it { should have_many :items}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
  end
   describe 'validations' do
    it { should validate_presence_of :name}
   end
end
