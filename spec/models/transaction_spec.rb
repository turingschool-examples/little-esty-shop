require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    context ':credit_card_number' do
      it { should validate_presence_of(:credit_card_number) }
      it { should validate_numericality_of(:credit_card_number).only_integer }
      # it { should validate_inclusion_of(:credit_card_number).in_range(1..9999999999999999) }
    end

    context ':result' do
      it { should allow_value(true).for(:result) }
      it { should allow_value(false).for(:result) }
      it { should_not allow_value(nil).for(:result) }
    end
  end
end
