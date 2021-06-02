require 'rails_helper'

RSpec.describe Item do
  before(:each) do
  end

  describe 'relationships' do
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
