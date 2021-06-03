require 'rails_helper'

RSpec.describe Transaction, type: :model do
 
  describe 'validations' do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_presence_of(:credit_card_expiration_date) }
  end
end