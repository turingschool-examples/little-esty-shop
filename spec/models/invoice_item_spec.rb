require 'rails_helper'

RSpec.describe InvoiceItem do
  before(:each) do
  end

  describe 'relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
