require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'relationships' do
    it { should have_many(:invoices)}
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'instance methods' do
    describe 'successful_transactions' do
      it "returns all the sucessful transactions associated with that customer" do

      end
    end
  end
end
