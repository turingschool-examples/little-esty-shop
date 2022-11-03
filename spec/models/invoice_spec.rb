require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:transactions)}
  end

  describe 'validations' do
    it {should validate_presence_of(:status)}
  end
  
  
end
