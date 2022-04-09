require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:credit_card_number) }
    #intentionally left out exp date as it does not appear in stories and is and empty field in csv
    it { should validate_presence_of(:result) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'relationships' do
    it { should belong_to(:invoice) }
  end
end
