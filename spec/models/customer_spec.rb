require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }

  end

  before :each do
    @customer_1 = Customer.create!( first_name: "Blake",
                                    last_name: "Saylor")
  end

  describe 'class methods' do

  end

  describe 'instance methods' do

  end
end
