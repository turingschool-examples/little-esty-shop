require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'instance methods' do
  end

  describe 'class methods' do 
  end
  
end
