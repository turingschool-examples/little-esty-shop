require 'rails_helper'

RSpec.describe Customer, type: :model do
  let!(:customer) { Customer.create!(first_name: "A Name", last_name: "A Last Name") }
  describe 'the customer model' do
    it { should have_many :invoices }
  end
  
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end
end