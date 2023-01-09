require 'rails_helper'

RSpec.describe Transaction do
  describe 'Relationships' do
    it { should belong_to :invoice }
    it { should validate_presence_of :credit_card_number }
  end
end
