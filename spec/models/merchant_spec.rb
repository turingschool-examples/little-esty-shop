require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do 
    it { should have_many :items}
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices)}
    it { should define_enum_for(:status).with_values(["enabled", "disabled"]) }
  end
end
