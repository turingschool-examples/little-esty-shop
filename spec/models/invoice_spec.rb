require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions) }
    it { should belong_to(:customer) }
    it { should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }

  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
    
end