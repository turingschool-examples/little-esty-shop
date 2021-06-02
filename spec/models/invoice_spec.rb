require 'rails_helper'

RSpec.describe Invoice do
  before(:each) do
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
