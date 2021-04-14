require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    # it { should validate_presence_of(:name) }
    # it { should validate_presence_of(:age) }
    # it { should validate_numericality_of(:age) }
  end

  before(:each) do
  end
end
