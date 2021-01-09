require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'instance methods' do
  end

  describe 'class methods' do 
  end
  
end